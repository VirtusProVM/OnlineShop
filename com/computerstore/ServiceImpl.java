
package com.computerstore;

import com.computerstore.entity.Admin;
import com.computerstore.entity.Product;
import com.computerstore.entity.ProductOrder;
import com.computerstore.entity.Review;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;

public class ServiceImpl<E> {
    
    private static EntityManagerFactory emf = Persistence.createEntityManagerFactory("ComputerStore");
    
    public ServiceImpl() {}
    
    public E create(E e) {
        EntityManager manager = emf.createEntityManager();
        manager.getTransaction().begin();
        
        manager.persist(e);
        manager.flush();
        manager.refresh(e);
        
        manager.getTransaction().commit();
        
        manager.close();
        
        return e;
    }
    
    public E update(E e) {
        EntityManager em = emf.createEntityManager();
        
        em.getTransaction().begin();
        
        e = em.merge(e);
        
        em.getTransaction().commit();
        
        em.close();
        
        return e;
    }
    
    public E get(Class<E> type, Object id) {
        EntityManager entityManager = emf.createEntityManager();
        E entity = entityManager.find(type, id);
        
        if(entity != null) {
            entityManager.refresh(entity);
        }
        entityManager.close();
        return entity;
    }
    
    public void delete(Class<E> type, Object id) {
        EntityManager entityManager = emf.createEntityManager();
        entityManager.getTransaction().begin();
        Object o = entityManager.getReference(type, id);
        entityManager.remove(o);
        entityManager.getTransaction().commit();
        entityManager.close();
    }
    
    public List<E> createNamedQuery(String queryName) {
        EntityManager entityManager = emf.createEntityManager();
        Query query = entityManager.createNamedQuery(queryName);
        
        List<E> result = query.getResultList();
        entityManager.close();
        return result;
    }

    public List<E> findWithNamedQueries(String queryName, String emailName, String emailValue) {
        EntityManager entityManager = emf.createEntityManager();
        Query query = entityManager.createNamedQuery(queryName);
        
        query.setParameter(emailName, emailValue);
        
        List<E> result = query.getResultList();
        entityManager.close();
        return result;
    }

    public List<E> adminLogin(String queryName, Map<String, Object> parameters) {
        EntityManager entityManager = emf.createEntityManager();
        Query query = entityManager.createNamedQuery(queryName);
        
        Set<Entry<String, Object>> setParameters = parameters.entrySet();
        
        for(Entry<String, Object> entry : setParameters) {
            query.setParameter(entry.getKey(), entry.getValue());
        }
        
        List<E> result = query.getResultList();
        entityManager.close();
        return result;
    }
    
    public List<E> findWithNamedQuery(String queryName, Map<String, Object> parameters) {
        EntityManager entityManager = emf.createEntityManager();
        Query query = entityManager.createNamedQuery(queryName);
        Set<Entry<String, Object>> setParameters = parameters.entrySet();
        for(Entry<String, Object > entry: setParameters) {
            query.setParameter(entry.getKey(), entry.getValue());
        }
        List<E> result = query.getResultList();
        entityManager.close();
        return result;
    }

    public List<E> findWithNamedQueries(String queryName, Map<String, Object> parameters) {
        EntityManager entityManager = emf.createEntityManager();
        Query query = entityManager.createNamedQuery(queryName);
        
        Set<Entry<String, Object>> setParameters = parameters.entrySet();
        
        for(Entry<String, Object> entry : setParameters) {
            query.setParameter(entry.getKey(), entry.getValue());
        }
        
        List<E> result = query.getResultList();
        entityManager.close();
        return result;
    }

    public List<E> findWithNamedQueries(String queryName, String paramName, Object paramValue) {
        EntityManager entityManager = emf.createEntityManager();
        Query query = entityManager.createNamedQuery(queryName);
        
        query.setParameter(paramName, paramValue);
        
        List<E> result = query.getResultList();
        entityManager.close();
        return result;
    }

    public List<E> findWithNamedQueries(String queryName, int firstResult, int maxResult) {
        EntityManager entityManager = emf.createEntityManager();
        Query query = entityManager.createNamedQuery(queryName);
        query.setFirstResult(firstResult);
        query.setMaxResults(maxResult);
        List<E> result = query.getResultList();
        entityManager.close();
        return result;
    }

    public long countWithNamedQuery(String queryName) {
        EntityManager entityManager = emf.createEntityManager();
        Query query = entityManager.createNamedQuery(queryName);
        long result = (long) query.getSingleResult();
        entityManager.close();
        return result;
    }
}
