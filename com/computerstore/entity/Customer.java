package com.computerstore.entity;

import java.io.Serializable;
import java.util.Date;
import java.util.HashSet;
import java.util.Locale;
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
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;
import javax.persistence.UniqueConstraint;

@Entity
@Table(name = "customer", catalog = "eStore", uniqueConstraints = @UniqueConstraint(columnNames = "email"))
@NamedQueries({
    @NamedQuery(name = "Customer.showAllCustomers", query = "SELECT c FROM Customer c ORDER BY c.registerDate DESC"),
    @NamedQuery(name = "Customer.countAll", query = "SELECT COUNT(c) FROM Customer c"),
    @NamedQuery(name = "Customer.findCustomerByEmail", query = "SELECT c FROM Customer c WHERE c.email = :em"),
    @NamedQuery(name = "Customer.checkLogin", query = "SELECT c FROM Customer c WHERE c.email = :em AND c.password = :pass")
})
public class Customer implements Serializable {
    
    private Integer customerID;
    private String email;
    private String firstname;
    private String lastname;
    private String addressLine1;
    private String addressLine2;
    private String phoneNumber;
    private String city;
    private String state;
    private String country;
    private String zipCode;
    private String password;
    private Date registerDate;
    private Set<Review> reviews = new HashSet<>();
    private Set<ProductOrder> orders = new HashSet<>();
    
    public Customer() {}

    public Customer(String email, String firstname, String lastname, String addressLine1, String addressLine2, String phoneNumber, String city, String state, String country, String zipCode, String password, Date registerDate) {
        this.email = email;
        this.firstname = firstname;
        this.lastname = lastname;
        this.addressLine1 = addressLine1;
        this.addressLine2 = addressLine2;
        this.phoneNumber = phoneNumber;
        this.city = city;
        this.state = state;
        this.country = country;
        this.zipCode = zipCode;
        this.password = password;
        this.registerDate = registerDate;
    }
    
    public Customer(String email, String firstname, String lastname, String addressLine1, String addressLine2, String phoneNumber, 
            String city, String state, String country, String zipCode, String password, Date registerDate, Set reviews, Set orders) {
        this(email, firstname, lastname, addressLine1, addressLine2, phoneNumber, city, state, country, zipCode, password, registerDate);
        this.reviews = reviews;
        this.orders = orders;
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "customerID", nullable = false, unique = true)
    public Integer getCustomerID() {
        return customerID;
    }

    public void setCustomerID(Integer customerID) {
        this.customerID = customerID;
    }

    @Column(name = "email", nullable = false, length = 64)
    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    @Column(name = "firstname", nullable = false, length = 30)
    public String getFirstname() {
        return firstname;
    }

    public void setFirstname(String firstname) {
        this.firstname = firstname;
    }

    @Column(name = "lastname", nullable = false, length = 30)
    public String getLastname() {
        return lastname;
    }

    public void setLastname(String lastname) {
        this.lastname = lastname;
    }
    
    @Transient
    public String getFullname() {
        return firstname + " " + lastname;
    }

    @Column(name = "address1", nullable = false, length = 128)
    public String getAddressLine1() {
        return addressLine1;
    }

    public void setAddressLine1(String addressLine1) {
        this.addressLine1 = addressLine1;
    }

    @Column(name = "address2", nullable = false, length = 128)
    public String getAddressLine2() {
        return addressLine2;
    }

    public void setAddressLine2(String addressLine2) {
        this.addressLine2 = addressLine2;
    }

    @Column(name = "phone_number", nullable = false, length = 15)
    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    @Column(name = "city", nullable = false, length = 32)
    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    @Column(name = "state", nullable = false, length = 45)
    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    @Column(name = "country", nullable = false, length = 64)
    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }
    
    @Transient
    public String getCountryName() {
        return new Locale("", this.country).getDisplayCountry();
    }

    @Column(name = "zip_code", nullable = false, length = 24)
    public String getZipCode() {
        return zipCode;
    }

    public void setZipCode(String zipCode) {
        this.zipCode = zipCode;
    }

    @Column(name = "password", nullable = false, length = 16)
    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "register_date", nullable = false)
    public Date getRegisterDate() {
        return registerDate;
    }

    public void setRegisterDate(Date registerDate) {
        this.registerDate = registerDate;
    }

    @OneToMany(fetch = FetchType.LAZY, targetEntity = Review.class, mappedBy = "customer")
    public Set<Review> getReviews() {
        return reviews;
    }

    public void setReviews(Set<Review> reviews) {
        this.reviews = reviews;
    }

    @OneToMany(fetch = FetchType.LAZY, targetEntity = ProductOrder.class, mappedBy = "customer")
    public Set<ProductOrder> getOrders() {
        return orders;
    }

    public void setOrders(Set<ProductOrder> orders) {
        this.orders = orders;
    }
    
    
    
}
