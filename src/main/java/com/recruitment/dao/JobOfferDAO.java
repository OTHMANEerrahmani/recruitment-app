package com.recruitment.dao;

import com.recruitment.entity.JobOffer;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import java.util.List;

public class JobOfferDAO extends AbstractDAO<JobOffer, Long> {

    public List<JobOffer> findByCompanyId(Long companyId) {
        EntityManager em = getEntityManager();
        try {
            TypedQuery<JobOffer> query = em.createQuery("SELECT j FROM JobOffer j WHERE j.company.id = :companyId",
                    JobOffer.class);
            query.setParameter("companyId", companyId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
}
