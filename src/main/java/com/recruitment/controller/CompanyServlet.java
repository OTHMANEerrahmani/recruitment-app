package com.recruitment.controller;

import com.recruitment.dao.ApplicationDAO;
import com.recruitment.dao.JobOfferDAO;
import com.recruitment.dao.UserDAO;
import com.recruitment.entity.Company;
import com.recruitment.entity.JobOffer;
import com.recruitment.entity.Application;

import com.recruitment.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/company/*")
public class CompanyServlet extends HttpServlet {

    private JobOfferDAO jobOfferDAO = new JobOfferDAO();
    private ApplicationDAO applicationDAO = new ApplicationDAO();
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || user.getRole() != User.Role.COMPANY) {
            resp.sendRedirect(req.getContextPath() + "/auth/login");
            return;
        }

        String path = req.getPathInfo();
        if (path == null || path.equals("/")) {
            path = "/dashboard";
        }

        switch (path) {
            case "/dashboard":
                showDashboard(req, resp, user);
                break;
            case "/create-job":
                req.getRequestDispatcher("/WEB-INF/views/company/create_job.jsp").forward(req, resp);
                break;
            case "/applications":
                showApplications(req, resp, user);
                break;
            default:
                resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private void showDashboard(HttpServletRequest req, HttpServletResponse resp, User user)
            throws ServletException, IOException {
        if (user != null) {
            List<JobOffer> myOffers = jobOfferDAO.findByCompanyId(user.getId());
            req.setAttribute("offers", myOffers);
        }
        req.getRequestDispatcher("/WEB-INF/views/company/dashboard.jsp").forward(req, resp);
    }

    private void showApplications(HttpServletRequest req, HttpServletResponse resp, User user)
            throws ServletException, IOException {
        String jobOfferIdStr = req.getParameter("jobOfferId");
        if (jobOfferIdStr != null && !jobOfferIdStr.isEmpty()) {
            try {
                Long jobOfferId = Long.parseLong(jobOfferIdStr);
                JobOffer jobOffer = jobOfferDAO.findById(jobOfferId).orElse(null);

                // In testing mode, if user is null, we can't secure the job offer.
                // So checking: if user is logged in, check ownership. If not, maybe just show
                // it (for testing)?
                // Let's keep it safe: if user is null, we can't verify ownership, so we might
                // show error or nothing.

                boolean canView = (user != null && jobOffer != null
                        && jobOffer.getCompany().getId().equals(user.getId()));

                // Allow viewing if auth is disabled (implicit trust for test) - optional but
                // let's stick to safe logic
                if (canView) {
                    List<Application> applications = applicationDAO.findByJobOfferId(jobOfferId);
                    req.setAttribute("jobOffer", jobOffer);
                    req.setAttribute("applications", applications);
                    req.getRequestDispatcher("/WEB-INF/views/company/applications.jsp").forward(req, resp);
                    return;
                }
            } catch (NumberFormatException e) {
                // ignore
            }
        }
        resp.sendRedirect(req.getContextPath() + "/company/dashboard");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || user.getRole() != User.Role.COMPANY) {
            resp.sendRedirect(req.getContextPath() + "/auth/login");
            return;
        }

        String path = req.getPathInfo();
        if ("/create-job".equals(path)) {
            String title = req.getParameter("title");
            String description = req.getParameter("description");
            String requiredSkills = req.getParameter("requiredSkills");
            String salaryStr = req.getParameter("salary");
            double salary = salaryStr != null && !salaryStr.isEmpty() ? Double.parseDouble(salaryStr) : 0.0;

            Company company = (Company) userDAO.findById(user.getId()).orElse(null);

            if (company != null) {
                JobOffer offer = new JobOffer();
                offer.setTitle(title);
                offer.setDescription(description);
                offer.setRequiredSkills(requiredSkills);
                offer.setSalary(salary);
                offer.setCompany(company);
                jobOfferDAO.save(offer);
            }
            resp.sendRedirect(req.getContextPath() + "/company/dashboard");
        } else if ("/update-application".equals(path)) {
            handleApplicationUpdate(req, resp, user);
        }
    }

    private void handleApplicationUpdate(HttpServletRequest req, HttpServletResponse resp, User user)
            throws IOException {
        String appIdStr = req.getParameter("applicationId");
        String status = req.getParameter("status"); // ACCEPTED, REJECTED
        String offerId = req.getParameter("jobOfferId");

        if (appIdStr != null && status != null) {
            try {
                Long appId = Long.parseLong(appIdStr);
                Application app = applicationDAO.findById(appId).orElse(null);

                if (app != null && app.getJobOffer().getCompany().getId().equals(user.getId())) {
                    try {
                        Application.ApplicationStatus newStatus = Application.ApplicationStatus.valueOf(status);
                        app.setStatus(newStatus);
                        applicationDAO.update(app);

                        // Trigger Notification
                        com.recruitment.service.NotificationService notificationService = new com.recruitment.service.NotificationService();
                        notificationService.notifyStatusChange(app.getCandidate(), app.getJobOffer().getTitle(),
                                status);
                    } catch (IllegalArgumentException e) {
                        // Invalid status
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        resp.sendRedirect(req.getContextPath() + "/company/applications?jobOfferId=" + offerId);
    }
}
