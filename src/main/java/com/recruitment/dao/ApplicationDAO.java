package com.recruitment.dao;

import com.recruitment.entity.Application;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import java.util.List;

public class ApplicationDAO extends AbstractDAO<Application, Long> {

    public List<Application> findByCandidateId(Long candidateId) {
        EntityManager em = getEntityManager();
        try {
            TypedQuery<Application> query = em
                    .createQuery("SELECT a FROM Application a WHERE a.candidate.id = :candidateId", Application.class);
            query.setParameter("candidateId", candidateId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public List<Application> findByJobOfferId(Long jobOfferId) {
        EntityManager em = getEntityManager();
        try {
            TypedQuery<Application> query = em
                    .createQuery("SELECT a FROM Application a WHERE a.jobOffer.id = :jobOfferId", Application.class);
            query.setParameter("jobOfferId", jobOfferId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public boolean hasApplied(Long candidateId, Long jobOfferId) {
        EntityManager em = getEntityManager();
        try {
            Long count = em.createQuery(
                    "SELECT COUNT(a) FROM Application a WHERE a.candidate.id = :candidateId AND a.jobOffer.id = :jobOfferId",
                    Long.class)
                    .setParameter("candidateId", candidateId)
                    .setParameter("jobOfferId", jobOfferId)
                    .getSingleResult();
            return count > 0;
        } finally {
            em.close();
        }
    }

    public void deleteByCandidateId(Long candidateId) {
        EntityManager em = getEntityManager();
        em.getTransaction().begin();
        try {
            em.createQuery("DELETE FROM Application a WHERE a.candidate.id = :candidateId")
                    .setParameter("candidateId", candidateId)
                    .executeUpdate();
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public long countAcceptedByJobOfferId(Long jobOfferId) {
        EntityManager em = getEntityManager();
        try {
            Long count = em.createQuery(
                    "SELECT COUNT(a) FROM Application a WHERE a.jobOffer.id = :jobOfferId AND a.status = 'ACCEPTED'",
                    Long.class)
                    .setParameter("jobOfferId", jobOfferId)
                    .getSingleResult();
            return count;
        } finally {
            em.close();
        }
    }

    public void deleteByJobOfferId(Long jobOfferId) {
        EntityManager em = getEntityManager();
        em.getTransaction().begin();
        try {
            em.createQuery("DELETE FROM Application a WHERE a.jobOffer.id = :jobOfferId")
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
