package com.recruitment.dao;

import com.recruitment.util.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import java.lang.reflect.ParameterizedType;
import java.util.List;
import java.util.Optional;

public abstract class AbstractDAO<T, ID> implements GenericDAO<T, ID> {

    private final Class<T> entityClass;

    @SuppressWarnings("unchecked")
    public AbstractDAO() {
        this.entityClass = (Class<T>) ((ParameterizedType) getClass()
                .getGenericSuperclass()).getActualTypeArguments()[0];
    }

    protected EntityManager getEntityManager() {
        return JPAUtil.getEntityManager();
    }

    @Override
    public T save(T entity) {
        EntityManager em = getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.persist(entity);
            tx.commit();
            return entity;
        } catch (Exception e) {
            if (tx.isActive())
                tx.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public T update(T entity) {
        EntityManager em = getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            T merged = em.merge(entity);
            tx.commit();
            return merged;
        } catch (Exception e) {
            if (tx.isActive())
                tx.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public void delete(T entity) {
        EntityManager em = getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.remove(em.contains(entity) ? entity : em.merge(entity));
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive())
                tx.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public Optional<T> findById(ID id) {
        EntityManager em = getEntityManager();
        try {
            return Optional.ofNullable(em.find(entityClass, id));
        } finally {
            em.close();
        }
    }

    @Override
    public List<T> findAll() {
        EntityManager em = getEntityManager();
        try {
            TypedQuery<T> query = em.createQuery("SELECT e FROM " + entityClass.getSimpleName() + " e", entityClass);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
}
