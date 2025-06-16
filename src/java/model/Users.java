package model;

import java.io.Serializable;
import java.util.Date;

public class Users implements Serializable{
    private int userID;
    private String email;
    private String password;
    private String fullName;
    private String phoneNumber;
    private String status;
    private java.util.Date createdAt;
    private String roleName;
    
    public Users(int userID, String email, String password, String fullName, String phoneNumber, String status, Date createdAt) {
        this.userID = userID;
        this.email = email;
        this.password = password;
        this.fullName = fullName;
        this.phoneNumber = phoneNumber;
        this.status = status;
        this.createdAt = createdAt;
    }

    public Users(int userID, String email, String password, String fullName, String phoneNumber, String status, Date createdAt, String roleName) {
        this.userID = userID;
        this.email = email;
        this.password = password;
        this.fullName = fullName;
        this.phoneNumber = phoneNumber;
        this.status = status;
        this.createdAt = createdAt;
        this.roleName = roleName;
    }
    
    

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }
    
    
    public Users(int aInt, String string, String string0) {
    }

    public Users() {
    }

    // Getters and Setters

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }
    
}