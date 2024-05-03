
package com.computerstore.entity;

import java.util.Base64;
import java.util.Comparator;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;
import java.util.TreeSet;
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
import javax.persistence.UniqueConstraint;

@Entity
@Table(name = "product", catalog = "eStore", uniqueConstraints = @UniqueConstraint(columnNames = "title"))
@NamedQueries({
    @NamedQuery(name = "Product.showProducts", query = "SELECT p FROM Product p ORDER BY p.title"),
    @NamedQuery(name = "Product.findProductByTitle", query = "SELECT p FROM Product p WHERE p.title = :title"),
    @NamedQuery(name = "Product.productByCategory", query = "SELECT p FROM Product p JOIN Category c WHERE p.category.categoryID = c.categoryID AND c.categoryID = :productId"),
    @NamedQuery(name = "Product.search", query = "SELECT p FROM Product p WHERE p.title LIKE :keyword OR p.description LIKE :keyword"),
    @NamedQuery(name = "Product.latestProducts", query = "SELECT p FROM Product p ORDER BY p.publishDate"),
    @NamedQuery(name = "Product.countAll", query = "SELECT COUNT(p) FROM Product p")
})
public class Product implements java.io.Serializable {
    
    private int productID;
    private String title;
    private Category category;
    private String description;
    private byte[] image;
    private String base64Image;
    private float price;
    private Date publishDate;
    private Date updateProductDate;
    private Set<Review> reviews = new HashSet<Review>(0);
    private Set<ProductDetail> orderDetails = new HashSet<ProductDetail>(0);
    
    public Product() {}
    
    public Product(int productID) {
        this.productID = productID;
    }

    public Product(String title) {
        this.title = title;
    }

    public Product(String title, Category category, String description, byte[] image, float price, Date publishDate, Date updateProductDate) {
        this.title = title;
        this.category = category;
        this.description = description;
        this.image = image;
        this.price = price;
        this.publishDate = publishDate;
        this.updateProductDate = updateProductDate;
    }
    
    public Product(String title, Category category, String description, byte[] image, float price, Date publishDate, Date updateProductDate,
            Set reviews, Set orderDetails) {
        this(title, category, description, image, price, publishDate, updateProductDate);
        this.reviews = reviews;
        this.orderDetails = orderDetails;
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "productID", nullable = false, unique = true)
    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    @Column(name = "title", nullable = false, length = 128)
    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "categoryID", nullable = false)
    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    @Column(name = "description", nullable = false, length = 16777215)
    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Column(name = "image", nullable = false, length = 65555)
    public byte[] getImage() {
        return image;
    }

    public void setImage(byte[] image) {
        this.image = image;
    }

    @Column(name = "price", nullable = false, precision = 12, scale = 0)
    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    @Temporal(TemporalType.DATE)
    @Column(name = "publish_date", nullable = false, length = 10)
    public Date getPublishDate() {
        return publishDate;
    }

    public void setPublishDate(Date publishDate) {
        this.publishDate = publishDate;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "last_update_time", nullable = false, length = 19)
    public Date getUpdateProductDate() {
        return updateProductDate;
    }

    public void setUpdateProductDate(Date updateProductDate) {
        this.updateProductDate = updateProductDate;
    }
    
    @Transient
    public String getBase64Image() {
        return Base64.getEncoder().encodeToString(this.image);
    }
    
    public void setBase64Image(String base64) {
        this.base64Image = base64;
    }

    @OneToMany(fetch = FetchType.EAGER, targetEntity = Review.class, mappedBy = "product")
    public Set<Review> getReviews() {
        TreeSet<Review> rs = new TreeSet<Review>(new Comparator<Review>() {
            @Override
            public int compare(Review o1, Review o2) {
                return o2.getReviewTime().compareTo(o1.getReviewTime());
            }
            
        });
        
        rs.addAll(reviews);
        
        return reviews;
    }

    public void setReviews(Set<Review> reviews) {
        this.reviews = reviews;
    }

    @OneToMany(fetch = FetchType.EAGER, targetEntity = ProductDetail.class, mappedBy = "product")
    public Set<ProductDetail> getOrderDetails() {
        return orderDetails;
    }

    public void setOrderDetails(Set<ProductDetail> orderDetails) {
        this.orderDetails = orderDetails;
    }
    
    @Transient
    public float getAverageRating() {
        float averageRating = 0.0f;
        float sum = 0.0f;
        
        if(reviews.isEmpty()) {
            return 0.0f;
        }
        
        for(Review review : reviews) {
            sum += review.getRating();
        }
        
        averageRating = sum / reviews.size();
        
        return averageRating;
    }
    
    public String getRatingString(float averageRating) {
        String result = "";
        int numberOfStarsOn = (int) averageRating;
        
        for(int i = 1; i <= numberOfStarsOn; i++) {
            result += "on,";
        }
        
        int next = numberOfStarsOn + 1;
        
        if(averageRating > numberOfStarsOn) {
            result += "half,";
            next++;
        }
        
        for(int j = next; j <= 5; j++) {
            result += "off,";
        }
        
        return result.substring(0, result.length() - 1);
    }
    
    @Transient
    public String getRatingStars() {
        float averageRating = getAverageRating();
        
        return getRatingString(averageRating);
    }
    
    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + productID;
        return result;
    }

    @Override
    public boolean equals(Object obj) {
        if(this == obj) 
            return true;
        
        if(obj == null) 
            return false;
        
        if(getClass() != obj.getClass()) 
            return false;
        
        Product other = (Product) obj;
        
        if(productID != other.productID) 
            return false;
        
        return true;
    }
}
