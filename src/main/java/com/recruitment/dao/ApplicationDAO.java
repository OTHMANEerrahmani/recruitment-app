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
}
