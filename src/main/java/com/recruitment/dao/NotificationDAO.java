package com.recruitment.dao;

import com.recruitment.entity.Notification;
import com.recruitment.entity.User;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import java.util.List;

public class NotificationDAO extends AbstractDAO<Notification, Long> {

    public List<Notification> findByUser(User user) {
        EntityManager em = getEntityManager();
        try {
            TypedQuery<Notification> query = em.createQuery(
                    "SELECT n FROM Notification n WHERE n.user = :user ORDER BY n.createdAt DESC",
                    Notification.class);
            query.setParameter("user", user);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public long countUnread(User user) {
        EntityManager em = getEntityManager();
        try {
            TypedQuery<Long> query = em.createQuery(
                    "SELECT COUNT(n) FROM Notification n WHERE n.user = :user AND n.isRead = false",
                    Long.class);
            query.setParameter("user", user);
            return query.getSingleResult();
        } finally {
            em.close();
        }
    }

    public void markAllAsRead(User user) {
        EntityManager em = getEntityManager();
        em.getTransaction().begin();
        try {
            em.createQuery("UPDATE Notification n SET n.isRead = true WHERE n.user = :user")
                    .setParameter("user", user)
                    .executeUpdate();
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public void deleteByUserId(Long userId) {
        EntityManager em = getEntityManager();
        em.getTransaction().begin();
        try {
            em.createQuery("DELETE FROM Notification n WHERE n.user.id = :userId")
                    .setParameter("userId", userId)
                    .executeUpdate();
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public void deleteByJobOfferId(Long jobOfferId) {
        EntityManager em = getEntityManager();
        em.getTransaction().begin();
        try {
            em.createQuery("DELETE FROM Notification n WHERE n.jobOffer.id = :jobOfferId")
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
