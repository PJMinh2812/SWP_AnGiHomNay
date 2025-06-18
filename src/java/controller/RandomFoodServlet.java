package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.util.*;

@WebServlet(name = "RandomFoodServlet", urlPatterns = { "/random-food" })
public class RandomFoodServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check if it's a direct wheel spin request
        String action = request.getParameter("action");
        if ("spin".equals(action)) {
            handleSpinRequest(request, response);
            return;
        }
        
        // Default behavior - show the wheel page
        RequestDispatcher dispatcher = request.getRequestDispatcher("/view/random.jsp");
        dispatcher.forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        handleSpinRequest(request, response);
    }
    
    private void handleSpinRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Available food IDs
        int[] foodIds = { 1, 2, 3, 4, 5, 6, 7 };
        
        // Generate random food
        Random random = new Random();
        int randomIndex = random.nextInt(foodIds.length);
        int selectedFoodId = foodIds[randomIndex];
        
        // Get food details (you can expand this to use your database)
        Map<String, Object> selectedFood = getFoodDetails(selectedFoodId);
        
        // Return JSON response for AJAX requests
        String acceptHeader = request.getHeader("Accept");
        if (acceptHeader != null && acceptHeader.contains("application/json")) {
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            
            String jsonResponse = String.format(
                "{\"id\": %d, \"name\": \"%s\", \"description\": \"%s\"}",
                selectedFood.get("id"),
                selectedFood.get("name"),
                selectedFood.get("description")
            );
            
            response.getWriter().write(jsonResponse);
        } else {
            // Redirect to food detail page
            response.sendRedirect(request.getContextPath() + "/food-detail?foodID=" + selectedFoodId);
        }
    }
    
    private Map<String, Object> getFoodDetails(int foodId) {
        Map<String, Object> food = new HashMap<>();
        
        switch (foodId) {
            case 1:
                food.put("id", 1);
                food.put("name", "Phở Bò");
                food.put("description", "Món ăn truyền thống Việt Nam");
                break;
            case 2:
                food.put("id", 2);
                food.put("name", "Bánh Mì");
                food.put("description", "Bánh mì thịt thơm ngon");
                break;
            case 3:
                food.put("id", 3);
                food.put("name", "Bún Chả");
                food.put("description", "Đặc sản Hà Nội");
                break;
            case 4:
                food.put("id", 4);
                food.put("name", "Cơm Tấm");
                food.put("description", "Món ăn miền Nam");
                break;
            case 5:
                food.put("id", 5);
                food.put("name", "Trà Sữa");
                food.put("description", "Thức uống giải khát");
                break;
            case 6:
                food.put("id", 6);
                food.put("name", "Bánh Tráng");
                food.put("description", "Món ăn vặt hấp dẫn");
                break;
            case 7:
                food.put("id", 7);
                food.put("name", "Matcha");
                food.put("description", "Thức uống healthy");
                break;
            default:
                food.put("id", 1);
                food.put("name", "Phở Bò");
                food.put("description", "Món ăn truyền thống Việt Nam");
        }
        
        return food;
    }
}