package com.recruitment.dao;

import com.recruitment.entity.Message;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import java.util.List;

public class MessageDAO extends AbstractDAO<Message, Long> {

    public List<Message> findByJobOfferAndCandidate(Long jobOfferId, Long candidateId) {
        EntityManager em = getEntityManager();
        try {
            TypedQuery<Message> query = em.createQuery(
                    "SELECT m FROM Message m WHERE m.jobOffer.id = :jobOfferId AND m.candidate.id = :candidateId ORDER BY m.sentAt ASC",
                    Message.class);
            query.setParameter("jobOfferId", jobOfferId);
            query.setParameter("candidateId", candidateId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public void deleteByJobOfferId(Long jobOfferId) {
        EntityManager em = getEntityManager();
        em.getTransaction().begin();
        try {
            em.createQuery("DELETE FROM Message m WHERE m.jobOffer.id = :jobOfferId")
                    .setParameter("jobOfferId", jobOfferId)
                    .executeUpdate();
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }
}
