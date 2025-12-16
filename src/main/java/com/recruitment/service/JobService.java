package com.recruitment.service;

import com.recruitment.dao.JobOfferDAO;
import com.recruitment.entity.JobOffer;
import java.util.Arrays;

import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

public class JobService {

    private JobOfferDAO jobOfferDAO = new JobOfferDAO();
    private com.recruitment.dao.ApplicationDAO applicationDAO = new com.recruitment.dao.ApplicationDAO();
    private com.recruitment.dao.MessageDAO messageDAO = new com.recruitment.dao.MessageDAO();
    private com.recruitment.dao.NotificationDAO notificationDAO = new com.recruitment.dao.NotificationDAO();

    public List<JobOffer> getAllOffers() {
        return jobOfferDAO.findAllWithCompany();
    }

    public void deleteJobOffer(Long jobOfferId) throws Exception {
        long acceptedCount = applicationDAO.countAcceptedByJobOfferId(jobOfferId);
        if (acceptedCount == 0) {
            throw new Exception(
                    "Cannot delete job offer: No accepted candidates found. Business rule requires at least one accepted candidate.");
        }

        // We need to manage the transaction at the service level to ensure consistency
        // across DAOs
        // However, our generic DAOs manage their own transactions internally.
        // This is a design limitation. Ideally, we should pass an EntityManager or
        // handle TX here.
        // Given the constraints and current architecture (DAOs managing their own TX),
        // we might face partial failures if we don't unified them.
        // BUT, the prompt said "Use transaction management to ensure consistency."
        // So I should probably use a manual EntityManager here and pass it, OR wrap the
        // logic.
        // The current DAO pattern `getEntityManager()` creates a new one each time
        // unless we change it.
        // Let's stick to the cleanest possible approach with current DAOs:
        // We will execute deletions in order. If one fails, we can't easily rollback
        // previous ones without XA or shared EM.
        // REFACTOR: Modify this method to use a single EntityManager if possible, but
        // DAOs are hardcoded.
        // PROPOSAL: I will execute them sequentially. Consistency is "best effort"
        // without major refactor.
        // WAIT: The prompt explicitly asked for Transaction Management.
        // I'll try to use a shared transaction if I can, but `AbstractDAO` seems to
        // always `JPAUtil.getEntityManager()`.
        // If `JPAUtil` returns a thread-local EM, we are good. Let's assume JPAUtil
        // handles it or we accept sequential operations.
        // Actually, looking at `UserService.deleteUser`, it manually begins transaction
        // and calls queries directly.
        // I will follow that pattern: Use EntityManager directly here for the
        // transaction.

        jakarta.persistence.EntityManager em = com.recruitment.util.JPAUtil.getEntityManager();
        jakarta.persistence.EntityTransaction tx = em.getTransaction();

        try {
            tx.begin();

            // 1. Delete Messages
            em.createQuery("DELETE FROM Message m WHERE m.jobOffer.id = :jid").setParameter("jid", jobOfferId)
                    .executeUpdate();

            // 2. Delete Notifications
            em.createQuery("DELETE FROM Notification n WHERE n.jobOffer.id = :jid").setParameter("jid", jobOfferId)
                    .executeUpdate();

            // 3. Delete Applications
            em.createQuery("DELETE FROM Application a WHERE a.jobOffer.id = :jid").setParameter("jid", jobOfferId)
                    .executeUpdate();

            // 4. Delete Job Offer
            em.createQuery("DELETE FROM JobOffer j WHERE j.id = :jid").setParameter("jid", jobOfferId).executeUpdate();

            tx.commit();
        } catch (Exception e) {
            if (tx.isActive())
                tx.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public void createOffer(JobOffer offer) {
        jobOfferDAO.save(offer);
    }

    public List<JobOffer> getJobOffersByCompany(Long companyId) {
        return jobOfferDAO.findByCompanyId(companyId);
    }

    /**
     * Calculates a matching score (0-100%) between candidate skills and job
     * requirements.
     */
    public int calculateMatchScore(String candidateSkills, String jobSkills) {
        if (candidateSkills == null || jobSkills == null || jobSkills.isEmpty()) {
            return 0;
        }

        Set<String> cSkills = Arrays.stream(candidateSkills.toLowerCase().split(","))
                .map(String::trim)
                .collect(Collectors.toSet());

        Set<String> jSkills = Arrays.stream(jobSkills.toLowerCase().split(","))
                .map(String::trim)
                .collect(Collectors.toSet());

        if (jSkills.isEmpty())
            return 100;

        long matchCount = jSkills.stream().filter(cSkills::contains).count();

        return (int) ((double) matchCount / jSkills.size() * 100);
    }
}
