package com.recruitment.service;

import com.recruitment.dao.UserDAO;
import com.recruitment.entity.User;
import java.util.List;
import java.util.Optional;

public class UserService {

    private final UserDAO userDAO = new UserDAO();

    public List<User> findAll() {
        return userDAO.findAll();
    }

    public Optional<User> findById(Long id) {
        return userDAO.findById(id);
    }

    public void updateUser(User user) {
        userDAO.update(user);
    }

    public void deleteUser(Long id) {
        jakarta.persistence.EntityManager em = com.recruitment.util.JPAUtil.getEntityManager();
        em.getTransaction().begin();
        try {
            // 1. Delete Notifications
            em.createQuery("DELETE FROM Notification n WHERE n.user.id = :uid")
                    .setParameter("uid", id)
                    .executeUpdate();

            // 2. Load User
            User user = em.find(User.class, id);

            if (user != null) {
                // 3. Handle Role-Specific Dependencies
                if (user instanceof com.recruitment.entity.Candidate) {
                    // Delete applications by this candidate
                    em.createQuery("DELETE FROM Application a WHERE a.candidate.id = :id")
                            .setParameter("id", id)
                            .executeUpdate();

                } else if (user instanceof com.recruitment.entity.Company) {
                    // Fetch JobOffer IDs first to avoid joining tables in DELETE statement
                    List<Long> offerIds = em
                            .createQuery("SELECT j.id FROM JobOffer j WHERE j.company.id = :id", Long.class)
                            .setParameter("id", id)
                            .getResultList();

                    if (!offerIds.isEmpty()) {
                        // 1a. Delete Messages linked to these JobOffers
                        // (Safe delete: messages are linked to JobOffer)
                        em.createQuery("DELETE FROM Message m WHERE m.jobOffer.id IN :ids")
                                .setParameter("ids", offerIds)
                                .executeUpdate();

                        // 1b. Delete Notifications linked to these JobOffers
                        // (Safe delete: notifications about these jobs)
                        em.createQuery("DELETE FROM Notification n WHERE n.jobOffer.id IN :ids")
                                .setParameter("ids", offerIds)
                                .executeUpdate();

                        // 1c. Delete applications for these offers
                        em.createQuery("DELETE FROM Application a WHERE a.jobOffer.id IN :ids")
                                .setParameter("ids", offerIds)
                                .executeUpdate();

                        // 2. Delete the offers themselves
                        em.createQuery("DELETE FROM JobOffer j WHERE j.id IN :ids")
                                .setParameter("ids", offerIds)
                                .executeUpdate();
                    }
                }

                // 4. Delete the User
                em.remove(user);
            }

            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            e.printStackTrace();
            throw new RuntimeException("Error deleting user: " + e.getMessage(), e);
        } finally {
            if (em.isOpen()) {
                em.close();
            }
        }
    }

    public void toggleUserStatus(Long id) {
        Optional<User> userOpt = userDAO.findById(id);
        if (userOpt.isPresent()) {
            User user = userOpt.get();
            user.setActive(!user.isActive());
            userDAO.update(user);
        }
    }
}
