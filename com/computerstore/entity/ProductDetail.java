package com.computerstore.entity;

import javax.persistence.AssociationOverride;
import javax.persistence.AssociationOverrides;
import javax.persistence.Column;
import javax.persistence.Embedded;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "product_detail", catalog = "eStore")
@AssociationOverrides({
    @AssociationOverride(name = "product", joinColumns = @JoinColumn(name = "productID")),
    @AssociationOverride(name = "productOrder", joinColumns = @JoinColumn(name = "orderID"))
})
public class ProductDetail implements java.io.Serializable {
    
    private ProductDetailID id = new ProductDetailID();
    private Product product;
    private ProductOrder productOrder;
    private int quantity;
    private float subtotal;
    
    public ProductDetail() {}
    
    public ProductDetail(ProductDetailID id) {
        this.id = id;
    }

    @Embedded
    public ProductDetailID getId() {
        return id;
    }

    public void setId(ProductDetailID id) {
        this.id = id;
    }

    @Id
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "productID", nullable = false, updatable = false, insertable = false)
    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    @Id
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "orderID", nullable = false, updatable = false, insertable = false)
    public ProductOrder getProductOrder() {
        return productOrder;
    }

    public void setProductOrder(ProductOrder productOrder) {
        this.productOrder = productOrder;
    }

    @Column(name = "quantity", nullable = false)
    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    @Column(name = "subtotal", nullable = false, precision = 12, scale = 0)
    public float getSubtotal() {
        return subtotal;
    }

    public void setSubtotal(float subtotal) {
        this.subtotal = subtotal;
    }
    
    
}
