package com.computerstore;

import java.util.List;

public interface Service<E> {
    
    public List<E> showAll();
    
    public E create(E e);
    
    public E update(E e);
    
    public E get(Object id);
    
    public void delete(Object id);
}
