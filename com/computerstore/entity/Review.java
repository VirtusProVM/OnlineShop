package com.computerstore.entity;

import java.util.Date;
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
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

@Entity
@Table(name = "review", catalog = "eStore")
@NamedQueries({
    @NamedQuery(name = "Review.listAll", query = "SELECT r FROM Review r ORDER BY r.reviewTime DESC"),
    @NamedQuery(name = "Review.countAll", query = "SELECT COUNT(r) FROM Review r"),
    @NamedQuery(name = "Review.findByCustomerAndProduct", query = "SELECT r FROM Review r WHERE r.customer.customerID =:customerID"
            + " AND r.product.productID =:productID"),
   /* @NamedQuery(name = "Review.mostFavoredBooks", query = "SELECT r.product, COUNT(r.product.productID) AS ReviewCount, AVG(r.rating) AS AvgRating "
            + "FROM Review r GROUP BY r.product.productID HAVING AVG(r.rating) >= 4.0 ORDER BY ReviewCount DESC, AvgRating DESC")*/
})
public class Review implements java.io.Serializable {
    
    private int reviewID;
    private Customer customer;
    private Product product;
    private int rating;
    private String headline;
    private String comment;
    private Date reviewTime;
    
    public Review() {}

    public Review(Customer customer, Product product, int rating, String headline, String comment, Date reviewTime) {
        this.customer = customer;
        this.product = product;
        this.rating = rating;
        this.headline = headline;
        this.comment = comment;
        this.reviewTime = reviewTime;
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "reviewID", unique = true, nullable = false)
    public int getReviewID() {
        return reviewID;
    }

    public void setReviewID(int reviewID) {
        this.reviewID = reviewID;
    }

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "customerID", nullable = false)
    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "productID", nullable = false)
    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    @Column(name = "rating", nullable = false)
    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    @Column(name = "headline", nullable = false)
    public String getHeadline() {
        return headline;
    }

    public void setHeadline(String headline) {
        this.headline = headline;
    }

    @Column(name = "comment", nullable = false)
    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "review_time", nullable = false, length = 19)
    public Date getReviewTime() {
        return reviewTime;
    }

    public void setReviewTime(Date reviewTime) {
        this.reviewTime = reviewTime;
    }
    
    @Transient
    public String getStars() {
        String result = "";
            int numberOfStarsOn = (int) rating;
            for(int i=1;i<=numberOfStarsOn; i++) {
                result += "on,";
            }
            
            int next = numberOfStarsOn + 1;
            
            for(int j=next; j<=5; j++) {
                result += "off,";
            }
            
        return result.substring(0,result.length() - 1 );
    }
    
}
