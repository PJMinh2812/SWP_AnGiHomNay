package model;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

public class Foods {
    private int foodID;
    private String name;
    private String category;
    private String description;
    private String image;
    private int calories;
    private double Protein;
    private double Fat;
    private double Cabonhydrates;
    private String Ingredients;
    private String PreparationMethod;
    private String Status;
    private java.util.Date createdAt;
     private List<Categories> categories;

    public Foods(int aInt, String string, String string0, String string1, int aInt0, double aDouble, double aDouble0, double aDouble1, String string2, String string3, String string4, Timestamp timestamp) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
     
    // Getters and Setters
    public List<Categories> getCategories() {
        return categories;
    }
    
    public void setCategories(List<Categories> categories) {     
        this.categories = categories;
    }

    public int getFoodID() {
        return foodID;
    }

    public void setFoodID(int foodID) {
        this.foodID = foodID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public int getCalories() {
        return calories;
    }

    public void setCalories(int calories) {
        this.calories = calories;
    }

    public double getProtein() {
        return Protein;
    }

    public void setProtein(double Protein) {
        this.Protein = Protein;
    }

    public double getFat() {
        return Fat;
    }

    public void setFat(double Fat) {
        this.Fat = Fat;
    }

    public double getCabonhydrates() {
        return Cabonhydrates;
    }

    public void setCabonhydrates(double Cabonhydrates) {
        this.Cabonhydrates = Cabonhydrates;
    }

    public String getIngredients() {
        return Ingredients;
    }

    public void setIngredients(String Ingredients) {
        this.Ingredients = Ingredients;
    }

    public String getStatus() {
        return Status;
    }

    public void setStatus(String Status) {
        this.Status = Status;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public String getPreparationMethod() {
        return PreparationMethod;
    }

    public void setPreparationMethod(String PreparationMethod) {
        this.PreparationMethod = PreparationMethod;
    }
    
}
