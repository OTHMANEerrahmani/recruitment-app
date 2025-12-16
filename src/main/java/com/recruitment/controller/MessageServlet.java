package com.recruitment.controller;

import com.recruitment.dao.ApplicationDAO;
import com.recruitment.dao.JobOfferDAO;
import com.recruitment.dao.MessageDAO;
import com.recruitment.dao.UserDAO;
import com.recruitment.entity.Application;
import com.recruitment.entity.Candidate;
import com.recruitment.entity.Company;
import com.recruitment.entity.JobOffer;
import com.recruitment.entity.Message;
import com.recruitment.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/messages/*")
public class MessageServlet extends HttpServlet {

    private MessageDAO messageDAO = new MessageDAO();
    private ApplicationDAO applicationDAO = new ApplicationDAO();
    private JobOfferDAO jobOfferDAO = new JobOfferDAO();
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/auth/login");
            return;
        }

        String jobOfferIdStr = req.getParameter("jobId");
        String candidateIdStr = req.getParameter("candidateId");

        if (jobOfferIdStr == null) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing Job ID");
            return;
        }

        try {
            Long jobOfferId = Long.parseLong(jobOfferIdStr);
            Long candidateId;

            // Determine context based on role
            if (user.getRole() == User.Role.CANDIDATE) {
                candidateId = user.getId();
            } else {
                if (candidateIdStr == null) {
                    resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing Candidate ID for Company view");
                    return;
                }
                candidateId = Long.parseLong(candidateIdStr);
            }

            // Security & Status Check
            if (!canMessage(user, jobOfferId, candidateId)) {
                resp.sendError(HttpServletResponse.SC_FORBIDDEN,
                        "Messaging is not allowed for this application (Must be ACCEPTED).");
                return;
            }

            // Fetch Data
            JobOffer jobOffer = jobOfferDAO.findById(jobOfferId).orElse(null);
            Candidate candidate = (Candidate) userDAO.findById(candidateId).orElse(null);
            List<Message> messages = messageDAO.findByJobOfferAndCandidate(jobOfferId, candidateId);

            req.setAttribute("jobOffer", jobOffer);
            req.setAttribute("candidateTarget", candidate); // 'candidate' might conflict with CandidateServlet attr
            req.setAttribute("messages", messages);

            req.getRequestDispatcher("/WEB-INF/views/common/messages.jsp").forward(req, resp);

        } catch (NumberFormatException e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid ID format");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/auth/login");
            return;
        }

        String jobOfferIdStr = req.getParameter("jobId");
        String candidateIdStr = req.getParameter("candidateId");
        String content = req.getParameter("content");

        if (jobOfferIdStr != null && content != null && !content.trim().isEmpty()) {
            try {
                Long jobOfferId = Long.parseLong(jobOfferIdStr);
                Long candidateId;

                if (user.getRole() == User.Role.CANDIDATE) {
                    candidateId = user.getId();
                } else {
                    if (candidateIdStr == null) {
                        resp.sendError(HttpServletResponse.SC_BAD_REQUEST);
                        return;
                    }
                    candidateId = Long.parseLong(candidateIdStr);
                }

                if (canMessage(user, jobOfferId, candidateId)) {
                    JobOffer jobOffer = jobOfferDAO.findById(jobOfferId).orElse(null);
                    Candidate candidate = (Candidate) userDAO.findById(candidateId).orElse(null);
                    Company company = jobOffer.getCompany();

                    Message message = new Message(content, user.getRole(), candidate, company, jobOffer);
                    messageDAO.save(message);

                    // Redirect back to chat
                    String redirectUrl = req.getContextPath() + "/messages?jobId=" + jobOfferId;
                    if (user.getRole() == User.Role.COMPANY) {
                        redirectUrl += "&candidateId=" + candidateId;
                    }
                    resp.sendRedirect(redirectUrl);
                    return;
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        resp.sendRedirect(req.getContextPath() + "/");
    }

    private boolean canMessage(User user, Long jobOfferId, Long candidateId) {
        // 1. Check Application Status
        if (!applicationDAO.hasApplied(candidateId, jobOfferId)) {
            return false;
        }

        // Fetch application to check status
        // (Optimized: reuse hasApplied logic or fetch directly. For now, fetch list and
        // filter or add findByCandidateAndJob)
        // Since we don't have findByCandidateAndJob returning strict single result
        // nicely exposed, let's look it up via job offer
        List<Application> apps = applicationDAO.findByJobOfferId(jobOfferId);
        Application app = apps.stream()
                .filter(a -> a.getCandidate().getId().equals(candidateId))
                .findFirst()
                .orElse(null);

        if (app == null || app.getStatus() != Application.ApplicationStatus.ACCEPTED) {
            return false;
        }

        // 2. Check User Ownership
        if (user.getRole() == User.Role.CANDIDATE) {
            return user.getId().equals(candidateId);
        } else if (user.getRole() == User.Role.COMPANY) {
            JobOffer offer = jobOfferDAO.findById(jobOfferId).orElse(null);
            return offer != null && offer.getCompany().getId().equals(user.getId());
        }
        return false;
    }
}
