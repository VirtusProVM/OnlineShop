package com.computerstore.entity;

import java.util.Date;
import java.util.HashSet;
import java.util.Locale;
import java.util.Set;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

@Entity
@Table(name = "product_order", catalog = "eStore")
@NamedQueries({
    @NamedQuery(name = "ProductOrder.showAll", query = "SELECT po FROM ProductOrder po ORDER BY po.orderDate DESC"),
    @NamedQuery(name = "ProductOrder.countAll", query = "SELECT COUNT(po) FROM ProductOrder po"),
    @NamedQuery(name = "ProductOrder.findByCustomer", query = "SELECT po FROM ProductOrder po WHERE po.customer.customerID =:customerId ORDER By po.orderDate DESC"),
    @NamedQuery(name = "ProductOrder.findByIdAndCustomer", query = "SELECT po FROM ProductOrder po WHERE po.orderID =:orderId AND po.customer.customerID =:customerId "),
    @NamedQuery(name = "ProductOrder.count", query = "SELECT COUNT(po) FROM ProductOrder po")
})
public class ProductOrder implements java.io.Serializable {
    
    private int orderID;
    private Customer customer;
    private Date orderDate;
    private String recipientAddress;
    private String recipientAddress2;
    private String recipientFirstname;
    private String recipientLastname;
    private String recipientPhone;
    private String recipientCountry;
    private String recipientCity;
    private String recipientState;
    private String recipientZipcode;
    private String paymentMethod;
    private float shippingFee;
    private float tax;
    private float subtotal;
    private float total;
    private String status;
    private Set<ProductDetail> details = new HashSet<ProductDetail>(0);

    public ProductOrder() {
    }

    public ProductOrder(Customer customer, Date orderDate, String recipientAddress, String recipientAddress2, String recipientFirstname, 
            String recipientLastname, String recipientPhone, String recipientCountry, String recipientCity, String recipientState, 
            String recipientZipcode, String paymentMethod, float shippingFee, float tax, float subtotal, float total, String status) {
        this.customer = customer;
        this.orderDate = orderDate;
        this.recipientAddress = recipientAddress;
        this.recipientAddress2 = recipientAddress2;
        this.recipientFirstname = recipientFirstname;
        this.recipientLastname = recipientLastname;
        this.recipientPhone = recipientPhone;
        this.recipientCountry = recipientCountry;
        this.recipientCity = recipientCity;
        this.recipientState = recipientState;
        this.recipientZipcode = recipientZipcode;
        this.paymentMethod = paymentMethod;
        this.shippingFee = shippingFee;
        this.tax = tax;
        this.subtotal = subtotal;
        this.total = total;
        this.status = status;
    }
    
    public ProductOrder(Customer customer, Date orderDate, String recipientAddress, String recipientAddress2, String recipientFirstname, 
            String recipientLastname, String recipientPhone, String recipientCountry, String recipientCity, String recipientState, 
            String recipientZipcode, String paymentMethod, float shippingFee, float tax, float subtotal, float total, String status, Set details) {
        
        this(customer, orderDate, recipientAddress, recipientAddress2, recipientFirstname, recipientLastname, recipientPhone, recipientCountry, recipientCity, recipientState, recipientZipcode, paymentMethod, shippingFee, tax, subtotal, total, status);
        this.details = details;
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "orderID", nullable = false, unique = true)
    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "customerID", nullable = false)
    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "order_date", nullable = false)
    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    @Column(name = "recipient_address", nullable = false, length = 256)
    public String getRecipientAddress() {
        return recipientAddress;
    }

    public void setRecipientAddress(String recipientAddress) {
        this.recipientAddress = recipientAddress;
    }

    @Column(name = "recipient_address2", nullable = false, length = 256)
    public String getRecipientAddress2() {
        return recipientAddress2;
    }

    public void setRecipientAddress2(String recipientAddress2) {
        this.recipientAddress2 = recipientAddress2;
    }

    @Column(name = "recipient_firstname", nullable = false, length = 30)
    public String getRecipientFirstname() {
        return recipientFirstname;
    }

    public void setRecipientFirstname(String recipientFirstname) {
        this.recipientFirstname = recipientFirstname;
    }

    @Column(name = "recipient_lastname", nullable = false, length = 30)
    public String getRecipientLastname() {
        return recipientLastname;
    }

    public void setRecipientLastname(String recipientLastname) {
        this.recipientLastname = recipientLastname;
    }

    @Column(name = "recipient_phone", nullable = false, length = 15)
    public String getRecipientPhone() {
        return recipientPhone;
    }

    public void setRecipientPhone(String recipientPhone) {
        this.recipientPhone = recipientPhone;
    }

    @Column(name = "recipient_country", nullable = false, length = 4)
    public String getRecipientCountry() {
        return recipientCountry;
    }

    public void setRecipientCountry(String recipientCountry) {
        this.recipientCountry = recipientCountry;
    }

    @Column(name = "recipient_city", nullable = false, length = 32)
    public String getRecipientCity() {
        return recipientCity;
    }

    public void setRecipientCity(String recipientCity) {
        this.recipientCity = recipientCity;
    }

    @Column(name = "recipient_state", nullable = false, length = 45)
    public String getRecipientState() {
        return recipientState;
    }

    public void setRecipientState(String recipientState) {
        this.recipientState = recipientState;
    }

    @Column(name = "recipient_zipcode", nullable = false, length = 24)
    public String getRecipientZipcode() {
        return recipientZipcode;
    }

    public void setRecipientZipcode(String recipientZipcode) {
        this.recipientZipcode = recipientZipcode;
    }

    @Column(name = "payment_method", nullable = false, length = 20)
    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    @Column(name = "shipping_fee")
    public float getShippingFee() {
        return shippingFee;
    }

    public void setShippingFee(float shippingFee) {
        this.shippingFee = shippingFee;
    }

    @Column(name = "tax")
    public float getTax() {
        return tax;
    }

    public void setTax(float tax) {
        this.tax = tax;
    }

    @Column(name = "subtotal")
    public float getSubtotal() {
        return subtotal;
    }

    public void setSubtotal(float subtotal) {
        this.subtotal = subtotal;
    }

    @Column(name = "total", nullable = false, precision = 12, scale = 0)
    public float getTotal() {
        return total;
    }

    public void setTotal(float total) {
        this.total = total;
    }

    @Column(name = "status", nullable = false, length = 20)
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    
    @Transient
    public String getCountryName() {
        return new Locale("", this.recipientCountry).getDisplayCountry();
    }
    
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "productOrder", cascade = CascadeType.ALL, orphanRemoval = true)
    public Set<ProductDetail> getProductDetails() {
        return this.details;
    }

    public void setProductDetails(Set<ProductDetail> details) {
        this.details = details;
    }
    
    @Transient
    public int getProductCopies() {
        int total = 0;
        
        for(ProductDetail detail : details) {
            total += detail.getQuantity();
        }
        
        return total;
    }
    
    @Override
    public int hashCode() {
        int hash = 7;
        hash = 37 * hash + this.orderID;
        return hash;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final ProductOrder other = (ProductOrder) obj;
        if (this.orderID != other.orderID) {
            return false;
        }
        return true;
    }
}
