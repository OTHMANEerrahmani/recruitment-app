package com.recruitment.dao;

import com.recruitment.entity.User;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import java.util.Optional;

public class UserDAO extends AbstractDAO<User, Long> {

    public Optional<User> findByEmail(String email) {
        EntityManager em = getEntityManager();
        try {
            TypedQuery<User> query = em.createQuery("SELECT u FROM User u WHERE u.email = :email", User.class);
            query.setParameter("email", email);
            return query.getResultStream().findFirst();
        } finally {
            em.close();
        }
    }
}
