package com.recruitment.service;

import com.recruitment.dao.UserDAO;
import com.recruitment.entity.Candidate;
import com.recruitment.entity.Company;
import com.recruitment.entity.User;
import java.util.Optional;

public class AuthService {

    private UserDAO userDAO = new UserDAO();

    public Optional<User> login(String email, String password) {
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
        candidate.setPassword(password); // Should hash
        candidate.setRole(User.Role.CANDIDATE);
        candidate.setFirstName(firstName);
        candidate.setLastName(lastName);
        userDAO.save(candidate);
        return true;
    }

    public boolean registerCompany(String email, String password, String companyName, String address) {
        if (userDAO.findByEmail(email).isPresent()) {
            return false;
        }
        Company company = new Company();
        company.setEmail(email);
        company.setPassword(password); // Should hash
        company.setRole(User.Role.COMPANY);
        company.setCompanyName(companyName);
        company.setAddress(address);
        userDAO.save(company);
        return true;
    }
}
