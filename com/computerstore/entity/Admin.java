package com.computerstore.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name = "admin", catalog = "eStore")
@NamedQueries({
    @NamedQuery(name = "Admin.showAll", query = "SELECT a FROM Admin a ORDER BY a.email"),
    @NamedQuery(name = "Admin.findByEmail", query = "SELECT a FROM Admin a WHERE a.email = :email"),
    @NamedQuery(name = "Admin.adminLogin", query = "SELECT a FROM Admin a WHERE a.email =:email AND a.password =:password")
})
public class Admin {
    
    private int adminID;
    
    private String email;
    
    private String password;
    
    private String fullname;

    public Admin() {
    }

    public Admin(String email, String password, String fullname) {
        this.email = email;
        this.password = password;
        this.fullname = fullname;
    }

    public Admin(int adminID, String email, String password, String fullname) {
        this.adminID = adminID;
        this.email = email;
        this.password = password;
        this.fullname = fullname;
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "adminID", unique = true, nullable = false)
    public int getAdminID() {
        return adminID;
    }

    public void setAdminID(int adminID) {
        this.adminID = adminID;
    }

    @Column(name = "email", length = 30, nullable = false)
    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    @Column(name = "password", nullable = false, length = 16)
    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @Column(name = "fullname", nullable = false, length = 30)
    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }
    
    
}
