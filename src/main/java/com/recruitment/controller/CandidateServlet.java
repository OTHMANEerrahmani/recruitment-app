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
        System.out.println("DEBUG: CandidateServlet doGet entered");
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || user.getRole() != User.Role.CANDIDATE) {
            System.out.println("DEBUG: User not authenticated or wrong role. Redirecting to login.");
            resp.sendRedirect(req.getContextPath() + "/auth/login");
            return;
        }

        String path = req.getPathInfo();
        System.out.println("DEBUG: PathInfo is: " + path);

        // Default to dashboard if path is null or /
        if (path == null || path.equals("/")) {
            path = "/dashboard";
        }

        switch (path) {
            case "/dashboard":
                System.out.println("DEBUG: Handling /dashboard");
                showDashboard(req, resp, user);
                break;
            case "/profile":
                System.out.println("DEBUG: Handling /profile");
                showProfile(req, resp, user);
                break;
            default:
                System.out.println("DEBUG: Path not found: " + path);
                resp.sendError(HttpServletResponse.SC_NOT_FOUND);
                break;
        }
    }

    private void showDashboard(HttpServletRequest req, HttpServletResponse resp, User user)
            throws ServletException, IOException {
        System.out.println("DEBUG: showDashboard executing");
        List<JobOffer> offers = jobService.getAllOffers();
        System.out.println("DEBUG: Found " + (offers != null ? offers.size() : "null") + " offers");

        if (user != null) {
            Candidate candidate = (Candidate) userDAO.findById(user.getId()).orElse(null);
            req.setAttribute("candidate", candidate);

            // Fetch notifications
            com.recruitment.service.NotificationService notificationService = new com.recruitment.service.NotificationService();
            List<com.recruitment.entity.Notification> notifications = notificationService.getUserNotifications(user);
            req.setAttribute("notifications", notifications);

            // Fetch my applications
            List<Application> myApplications = applicationDAO.findByCandidateId(candidate.getId());
            req.setAttribute("myApplications", myApplications);
        }

        req.setAttribute("jobService", jobService);
        req.setAttribute("offers", offers);
        System.out.println("DEBUG: Forwarding to /WEB-INF/views/candidate/dashboard.jsp");
        req.getRequestDispatcher("/WEB-INF/views/candidate/dashboard.jsp").forward(req, resp);
    }

    private void showProfile(HttpServletRequest req, HttpServletResponse resp, User user)
            throws ServletException, IOException {
        if (user != null) {
            Candidate candidate = (Candidate) userDAO.findById(user.getId()).orElse(null);
            req.setAttribute("candidate", candidate);
        }
        req.getRequestDispatcher("/WEB-INF/views/candidate/profile.jsp").forward(req, resp);
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
            handleProfileUpdate(req, resp, session, user);
        } else if ("/apply".equals(path)) {
            handleJobApplication(req, resp, user);
        } else {
            resp.sendRedirect(req.getContextPath() + "/candidate/dashboard");
        }
    }

    private void handleProfileUpdate(HttpServletRequest req, HttpServletResponse resp, HttpSession session, User user)
            throws IOException {
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/auth/login");
            return;
        }

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
            session.setAttribute("user", candidate);
        }
        resp.sendRedirect(req.getContextPath() + "/candidate/dashboard");
    }

    private void handleJobApplication(HttpServletRequest req, HttpServletResponse resp, User user) throws IOException {
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/auth/login");
            return;
        }

        String jobIdStr = req.getParameter("jobId");
        try {
            Long jobId = Long.parseLong(jobIdStr);
            JobOffer jobOffer = jobOfferDAO.findById(jobId).orElse(null);
            Candidate candidate = (Candidate) userDAO.findById(user.getId()).orElse(null);

            if (jobOffer != null && candidate != null) {
                // Check if already applied
                if (applicationDAO.hasApplied(candidate.getId(), jobOffer.getId())) {
                    resp.sendRedirect(req.getContextPath() + "/candidate/dashboard?error=already_applied");
                    return;
                }

                Application application = new Application();
                application.setCandidate(candidate);
                application.setJobOffer(jobOffer);
                applicationDAO.save(application);

                // Trigger Notifications
                com.recruitment.service.NotificationService notificationService = new com.recruitment.service.NotificationService();
                notificationService.notifyApplication(jobOffer.getCompany(), candidate, jobOffer.getTitle());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        resp.sendRedirect(req.getContextPath() + "/candidate/dashboard?success=applied");
    }
}
