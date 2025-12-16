package com.recruitment.service;

import com.recruitment.dao.UserDAO;
import com.recruitment.entity.Candidate;
import com.recruitment.entity.Company;
import com.recruitment.entity.User;
import java.util.Optional;

public class AuthService {

    private UserDAO userDAO = new UserDAO();
    private EmailService emailService = new EmailService();

    public Optional<User> login(String email, String password) {
        // --- HARDCODED ADMIN FALLBACK (Requested by User) ---
        if ("admin@recruitment.com".equals(email) && "admin123".equals(password)) {
            com.recruitment.entity.Admin admin = new com.recruitment.entity.Admin();
            admin.setId(0L); // Dummy ID
            admin.setEmail(email);
            admin.setPassword(password);
            admin.setRole(User.Role.ADMIN);
            admin.setActive(true);
            return Optional.of(admin);
        }

        Optional<User> userOpt = userDAO.findByEmail(email);
        if (userOpt.isPresent()) {
            User user = userOpt.get();
            if (user.getPassword().equals(password)) { // In real app, use hashing!
                return Optional.of(user);
            }
        }
        return Optional.empty();
    }

    public boolean registerCandidate(String email, String password, String firstName, String lastName) {
        if (userDAO.findByEmail(email).isPresent()) {
            return false;
        }
        Candidate candidate = new Candidate();
        candidate.setEmail(email);
        candidate.setPassword(password); // In real app, hash this!
        candidate.setFirstName(firstName);
        candidate.setLastName(lastName);
        candidate.setRole(User.Role.CANDIDATE);
        userDAO.save(candidate);

        emailService.sendEmail(email, "Welcome to RecruttAnty!",
                "Hi " + firstName + ",\n\nWelcome to RecruttAnty! Complete your profile to start applying.");
        return true;
    }

    public boolean registerCompany(String email, String password, String companyName, String address) {
        if (userDAO.findByEmail(email).isPresent()) {
            return false;
        }
        Company company = new Company();
        company.setEmail(email);
        company.setPassword(password); // Hash this!
        company.setCompanyName(companyName);
        company.setAddress(address);
        company.setRole(User.Role.COMPANY);
        userDAO.save(company);

        emailService.sendEmail(email, "Welcome to RecruttAnty!",
                "Hello " + companyName + ",\n\nWelcome to RecruttAnty! You can now post job offers.");
        return true;
    }
}
