package com.recruitment.controller;

import com.recruitment.dao.ApplicationDAO;
import com.recruitment.dao.JobOfferDAO;
import com.recruitment.dao.UserDAO;
import com.recruitment.entity.Application;
import com.recruitment.entity.Candidate;
import com.recruitment.entity.JobOffer;
import com.recruitment.entity.User;
import com.recruitment.service.JobService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/candidate/*")
public class CandidateServlet extends HttpServlet {

    private JobService jobService = new JobService();
    private UserDAO userDAO = new UserDAO();
    private JobOfferDAO jobOfferDAO = new JobOfferDAO();
    private ApplicationDAO applicationDAO = new ApplicationDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || user.getRole() != User.Role.CANDIDATE) {
            resp.sendRedirect(req.getContextPath() + "/auth/login");
            return;
        }

        String path = req.getPathInfo();
        if ("/dashboard".equals(path) || path == null) {
            List<JobOffer> offers = jobService.getAllOffers();
            Candidate candidate = (Candidate) userDAO.findById(user.getId()).orElse(null);

            // Re-fetch candidate to ensure we have latest skills
            if (candidate != null) {
                // Attach match score
                // Ideally create a DTO, but for JSP we can use a map or just pass the service
                req.setAttribute("jobService", jobService);
                req.setAttribute("candidate", candidate);
            }
            req.setAttribute("offers", offers);
            req.getRequestDispatcher("/candidate/dashboard.jsp").forward(req, resp);
        } else if ("/profile".equals(path)) {
            Candidate candidate = (Candidate) userDAO.findById(user.getId()).orElse(null);
            req.setAttribute("candidate", candidate);
            req.getRequestDispatcher("/candidate/profile.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || user.getRole() != User.Role.CANDIDATE) {
            resp.sendRedirect(req.getContextPath() + "/auth/login");
            return;
        }

        String path = req.getPathInfo();
        if ("/profile".equals(path)) {
            String firstName = req.getParameter("firstName");
            String lastName = req.getParameter("lastName");
            String skills = req.getParameter("skills");
            String resumeUrl = req.getParameter("resumeUrl");

            Candidate candidate = (Candidate) userDAO.findById(user.getId()).orElse(null);
            if (candidate != null) {
                candidate.setFirstName(firstName);
                candidate.setLastName(lastName);
                candidate.setSkills(skills);
                candidate.setResumeUrl(resumeUrl);
                userDAO.update(candidate);

                // Update session user to reflect changes if necessary or just reload from DB
                // next time
                session.setAttribute("user", candidate);
            }
            resp.sendRedirect(req.getContextPath() + "/candidate/dashboard");
        } else if ("/apply".equals(path)) {
            String jobIdStr = req.getParameter("jobId");
            Long jobId = Long.parseLong(jobIdStr);

            JobOffer jobOffer = jobOfferDAO.findById(jobId).orElse(null);
            Candidate candidate = (Candidate) userDAO.findById(user.getId()).orElse(null);

            if (jobOffer != null && candidate != null) {
                Application application = new Application();
                application.setCandidate(candidate);
                application.setJobOffer(jobOffer);
                applicationDAO.save(application);
            }
            resp.sendRedirect(req.getContextPath() + "/candidate/dashboard?success=applied");
        }
    }
}
