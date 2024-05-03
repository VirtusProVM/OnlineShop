package com.computerstore.entity;

import java.util.HashSet;
import java.util.Set;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "category", catalog = "eStore")
@NamedQueries({
    @NamedQuery(name = "Category.showAll", query = "SELECT c FROM Category c ORDER BY c.name"),
    @NamedQuery(name = "Category.isValidName", query = "SELECT c FROM Category c WHERE c.name= :name")
})
public class Category implements java.io.Serializable {
    
    private int categoryID;
    
    private String name;
    
    private Set<Product> products = new HashSet<Product>();
    
    public Category() {}

    public Category(String name) {
        this.name = name;
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "categoryID", unique = true, nullable = false)
    public int getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(int categoryID) {
        this.categoryID = categoryID;
    }

    @Column(name = "name", nullable = false, length = 30)
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @OneToMany(mappedBy = "category", fetch = FetchType.LAZY, targetEntity = Product.class)
    public Set<Product> getProducts() {
        return products;
    }

    public void setProducts(Set<Product> products) {
        this.products = products;
    }
    
    
}
