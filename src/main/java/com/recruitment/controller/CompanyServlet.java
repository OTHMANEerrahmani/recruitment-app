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
        if ("/dashboard".equals(path) || path == null) {
            List<JobOffer> myOffers = jobOfferDAO.findByCompanyId(user.getId());
            req.setAttribute("offers", myOffers);
            req.getRequestDispatcher("/company/dashboard.jsp").forward(req, resp);
        } else if ("/create-job".equals(path)) {
            req.getRequestDispatcher("/company/create_job.jsp").forward(req, resp);
        } else if ("/applications".equals(path)) {
            String jobOfferIdStr = req.getParameter("jobOfferId");
            if (jobOfferIdStr != null && !jobOfferIdStr.isEmpty()) {
                try {
                    Long jobOfferId = Long.parseLong(jobOfferIdStr);
                    JobOffer jobOffer = jobOfferDAO.findById(jobOfferId).orElse(null);

                    if (jobOffer != null && jobOffer.getCompany().getId().equals(user.getId())) {
                        List<Application> applications = applicationDAO.findByJobOfferId(jobOfferId);
                        req.setAttribute("jobOffer", jobOffer);
                        req.setAttribute("applications", applications);
                        req.getRequestDispatcher("/company/applications.jsp").forward(req, resp);
                        return;
                    }
                } catch (NumberFormatException e) {
                    // invalid id, redirect
                }
            }
            resp.sendRedirect(req.getContextPath() + "/company/dashboard");
        }
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
        }
    }
}
