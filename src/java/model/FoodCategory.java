/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package model;

public class FoodCategory {
private int foodId;
private int categoryId;

public FoodCategory(int foodId, int categoryId) {
    this.foodId = foodId;
    this.categoryId = categoryId;
}

public int getFoodId() {
    return foodId;
}

public void setFoodId(int foodId) {
    this.foodId = foodId;
}

public int getCategoryId() {
    return categoryId;
}

public void setCategoryId(int categoryId) {
    this.categoryId = categoryId;
}
}