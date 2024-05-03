package com.computerstore.entity;

import java.io.Serializable;
import javax.persistence.Embeddable;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

@Embeddable
public class ProductDetailID implements Serializable {
    
    private Product product;
    private ProductOrder productOrder;
    
    public ProductDetailID() {}

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "productID", nullable = false, updatable = false, insertable = false)
    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "orderID", nullable = false, updatable = false, insertable = false)
    public ProductOrder getProductOrder() {
        return productOrder;
    }

    public void setProductOrder(ProductOrder productOrder) {
        this.productOrder = productOrder;
    }
    
    
}
