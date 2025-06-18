package controller;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.*;

@WebServlet(name = "FoodDetailServlet", urlPatterns = { "/food-detail" })
public class FoodDetailServlet extends HttpServlet {
        @Override
        protected void doGet(HttpServletRequest request, HttpServletResponse response)
                        throws ServletException, IOException {
                String foodIdParam = request.getParameter("foodID");
                int foodID = 1;
                try {
                        foodID = Integer.parseInt(foodIdParam);
                } catch (Exception ignored) {
                }

                // Mock food data theo foodID
                Map<String, Object> food = new HashMap<>();
                if (foodID == 1) {
                        food.put("foodID", 1);
                        food.put("name", "Phở Bò");
                        food.put("image", request.getContextPath() + "/img/foods/pho-bo.jpg");
                        food.put("description",
                                        "Phở bò là món ăn truyền thống nổi tiếng của Việt Nam với nước dùng thơm ngon, thịt bò mềm và bánh phở dai.");
                        food.put("calories", 450);
                        food.put("instructions", List.of(
                                        "Chuẩn bị nguyên liệu: xương bò, thịt bò, bánh phở, hành, gừng, gia vị.",
                                        "Ninh xương lấy nước dùng trong 2-3 tiếng.",
                                        "Chần bánh phở, thái thịt bò mỏng.",
                                        "Xếp bánh phở và thịt vào bát, chan nước dùng, thêm hành và rau thơm."));
                        food.put("ingredients", List.of(
                                        Map.of("name", "Bánh phở", "quantity", 200, "unit", "g"),
                                        Map.of("name", "Thịt bò", "quantity", 150, "unit", "g"),
                                        Map.of("name", "Xương bò", "quantity", 300, "unit", "g"),
                                        Map.of("name", "Hành lá", "quantity", 20, "unit", "g"),
                                        Map.of("name", "Gừng", "quantity", 10, "unit", "g"),
                                        Map.of("name", "Gia vị", "quantity", 5, "unit", "g")));
                        food.put("protein", 25);
                        food.put("fat", 10);
                        food.put("carbs", 60);
                } else if (foodID == 2) {
                        food.put("foodID", 2);
                        food.put("name", "Bánh mì thịt");
                        food.put("image", request.getContextPath() + "/img/foods/banh-mi.jpg");
                        food.put("description",
                                        "Bánh mì thịt là món ăn đường phố nổi tiếng với lớp vỏ giòn, nhân thịt thơm ngon và rau sống tươi mát.");
                        food.put("calories", 380);
                        food.put("instructions", List.of(
                                        "Cắt bánh mì, phết pate và bơ.",
                                        "Thêm thịt nguội, chả lụa, dưa leo, rau thơm.",
                                        "Rưới nước sốt và thưởng thức."));
                        food.put("ingredients", List.of(
                                        Map.of("name", "Bánh mì", "quantity", 1, "unit", "ổ"),
                                        Map.of("name", "Thịt nguội", "quantity", 50, "unit", "g"),
                                        Map.of("name", "Chả lụa", "quantity", 30, "unit", "g"),
                                        Map.of("name", "Pate", "quantity", 20, "unit", "g"),
                                        Map.of("name", "Bơ", "quantity", 10, "unit", "g"),
                                        Map.of("name", "Dưa leo", "quantity", 20, "unit", "g"),
                                        Map.of("name", "Rau thơm", "quantity", 10, "unit", "g")));
                        food.put("protein", 15);
                        food.put("fat", 8);
                        food.put("carbs", 55);
                } else if (foodID == 3) {
                        food.put("foodID", 3);
                        food.put("name", "Bún chả Hà Nội");
                        food.put("image", request.getContextPath() + "/img/foods/bun-cha.jpg");
                        food.put("description", "Bún chả Hà Nội gồm bún tươi, chả nướng, nước mắm pha và rau sống.");
                        food.put("calories", 500);
                        food.put("instructions", List.of(
                                        "Ướp thịt heo xay với gia vị, nặn viên và nướng.",
                                        "Pha nước mắm chua ngọt.",
                                        "Bày bún, chả, rau sống ra đĩa, chan nước mắm và thưởng thức."));
                        food.put("ingredients", List.of(
                                        Map.of("name", "Bún tươi", "quantity", 200, "unit", "g"),
                                        Map.of("name", "Thịt heo xay", "quantity", 100, "unit", "g"),
                                        Map.of("name", "Nước mắm", "quantity", 30, "unit", "ml"),
                                        Map.of("name", "Rau sống", "quantity", 50, "unit", "g"),
                                        Map.of("name", "Đường", "quantity", 10, "unit", "g")));
                        food.put("protein", 20);
                        food.put("fat", 12);
                        food.put("carbs", 65);
                } else if (foodID == 4) {
                        food.put("foodID", 4);
                        food.put("name", "Cơm tấm sườn bì");
                        food.put("image", request.getContextPath() + "/img/foods/com-tam.jpg");
                        food.put("description",
                                        "Cơm tấm sườn bì là món ăn đặc trưng của miền Nam với cơm tấm, sườn nướng, bì, trứng và nước mắm.");
                        food.put("calories", 600);
                        food.put("instructions", List.of(
                                        "Nướng sườn heo đã ướp gia vị.",
                                        "Nấu cơm tấm.",
                                        "Bày cơm, sườn, bì, trứng, dưa leo ra đĩa, chan nước mắm và thưởng thức."));
                        food.put("ingredients", List.of(
                                        Map.of("name", "Cơm tấm", "quantity", 200, "unit", "g"),
                                        Map.of("name", "Sườn heo", "quantity", 120, "unit", "g"),
                                        Map.of("name", "Bì", "quantity", 30, "unit", "g"),
                                        Map.of("name", "Trứng", "quantity", 1, "unit", "quả"),
                                        Map.of("name", "Nước mắm", "quantity", 30, "unit", "ml")));
                        food.put("protein", 28);
                        food.put("fat", 18);
                        food.put("carbs", 70);
                } else if (foodID == 5) {
                        food.put("foodID", 5);
                        food.put("name", "Trà sữa trân châu");
                        food.put("image", request.getContextPath() + "/img/foods/tra-sua.jpg");
                        food.put("description",
                                        "Trà sữa trân châu là thức uống ngọt mát với trà, sữa và hạt trân châu dai ngon.");
                        food.put("calories", 350);
                        food.put("instructions", List.of(
                                        "Pha trà, thêm sữa và đường.",
                                        "Luộc trân châu cho mềm.",
                                        "Cho trân châu vào ly, rót trà sữa lên và thêm đá."));
                        food.put("ingredients", List.of(
                                        Map.of("name", "Trà đen", "quantity", 5, "unit", "g"),
                                        Map.of("name", "Sữa đặc", "quantity", 30, "unit", "ml"),
                                        Map.of("name", "Trân châu", "quantity", 40, "unit", "g"),
                                        Map.of("name", "Đường", "quantity", 20, "unit", "g"),
                                        Map.of("name", "Đá viên", "quantity", 100, "unit", "g")));
                        food.put("protein", 4);
                        food.put("fat", 6);
                        food.put("carbs", 70);
                } else if (foodID == 6) {
                        food.put("foodID", 6);
                        food.put("name", "Bánh tráng trộn");
                        food.put("image", request.getContextPath() + "/img/foods/banh-trang-tron.jpg");
                        food.put("description",
                                        "Bánh tráng trộn là món ăn vặt hấp dẫn với bánh tráng, khô bò, trứng cút, rau răm và nước sốt đặc biệt.");
                        food.put("calories", 320);
                        food.put("instructions", List.of(
                                        "Cắt bánh tráng thành sợi.",
                                        "Trộn bánh tráng với khô bò, trứng cút, rau răm, nước sốt.",
                                        "Thêm đậu phộng, hành phi và thưởng thức."));
                        food.put("ingredients", List.of(
                                        Map.of("name", "Bánh tráng", "quantity", 50, "unit", "g"),
                                        Map.of("name", "Khô bò", "quantity", 20, "unit", "g"),
                                        Map.of("name", "Trứng cút", "quantity", 2, "unit", "quả"),
                                        Map.of("name", "Rau răm", "quantity", 10, "unit", "g"),
                                        Map.of("name", "Đậu phộng", "quantity", 10, "unit", "g")));
                        food.put("protein", 7);
                        food.put("fat", 9);
                        food.put("carbs", 55);
                } else if (foodID == 7) {
                        food.put("foodID", 7);
                        food.put("name", "Matcha đá xay");
                        food.put("image", request.getContextPath() + "/img/foods/matcha.jpg");
                        food.put("description",
                                        "Matcha đá xay là thức uống mát lạnh với vị trà xanh thơm ngon, sữa và đá xay nhuyễn.");
                        food.put("calories", 220);
                        food.put("instructions", List.of(
                                        "Pha bột matcha với nước nóng.",
                                        "Cho matcha, sữa, đá vào máy xay nhuyễn.",
                                        "Rót ra ly, thêm kem tươi nếu thích."));
                        food.put("ingredients", List.of(
                                        Map.of("name", "Bột matcha", "quantity", 5, "unit", "g"),
                                        Map.of("name", "Sữa tươi", "quantity", 100, "unit", "ml"),
                                        Map.of("name", "Đá viên", "quantity", 100, "unit", "g"),
                                        Map.of("name", "Đường", "quantity", 15, "unit", "g")));
                        food.put("protein", 3);
                        food.put("fat", 4);
                        food.put("carbs", 40);
                } else {
                        // Mặc định là Phở bò
                        food.put("foodID", 1);
                        food.put("name", "Phở Bò");
                        food.put("image", request.getContextPath() + "/img/foods/pho-bo.jpg");
                        food.put("description",
                                        "Phở bò là món ăn truyền thống nổi tiếng của Việt Nam với nước dùng thơm ngon, thịt bò mềm và bánh phở dai.");
                        food.put("calories", 450);
                        food.put("instructions", List.of(
                                        "Chuẩn bị nguyên liệu: xương bò, thịt bò, bánh phở, hành, gừng, gia vị.",
                                        "Ninh xương lấy nước dùng trong 2-3 tiếng.",
                                        "Chần bánh phở, thái thịt bò mỏng.",
                                        "Xếp bánh phở và thịt vào bát, chan nước dùng, thêm hành và rau thơm."));
                        food.put("ingredients", List.of(
                                        Map.of("name", "Bánh phở", "quantity", 200, "unit", "g"),
                                        Map.of("name", "Thịt bò", "quantity", 150, "unit", "g"),
                                        Map.of("name", "Xương bò", "quantity", 300, "unit", "g"),
                                        Map.of("name", "Hành lá", "quantity", 20, "unit", "g"),
                                        Map.of("name", "Gừng", "quantity", 10, "unit", "g"),
                                        Map.of("name", "Gia vị", "quantity", 5, "unit", "g")));
                        food.put("protein", 25);
                        food.put("fat", 10);
                        food.put("carbs", 60);
                }

                // Chuyển List<String> instructions thành List<Map<String, Object>>
                List<String> rawInstructions = (List<String>) food.get("instructions");
                List<Map<String, Object>> stepList = new ArrayList<>();
                int i = 1;
                for (String s : rawInstructions) {
                        Map<String, Object> step = new HashMap<>();
                        step.put("title", "Bước " + i++);
                        step.put("description", s);
                        step.put("time", null);
                        stepList.add(step);
                }
                food.put("instructions", stepList);

                // Mock reviews
                List<Map<String, Object>> reviews = (List<Map<String, Object>>) request.getSession()
                                .getAttribute("reviews_" + foodID);
                if (reviews == null) {
                        reviews = new ArrayList<>();
                        reviews.add(Map.of("name", "Nguyen Van A", "rating", 5, "comment",
                                        "Rất ngon, nước dùng đậm đà!", "date", "2025-06-20"));
                        reviews.add(Map.of("name", "Tran Thi B", "rating", 4, "comment", "Thịt bò mềm, phục vụ nhanh.",
                                        "date", "2025-06-19"));
                        reviews.add(Map.of("name", "Le Van C", "rating", 5, "comment", "Món ăn tuyệt vời cho bữa sáng.",
                                        "date", "2025-06-18"));
                }
                double avgRating = reviews.stream().mapToInt(r -> (int) r.get("rating")).average().orElse(0);

                request.setAttribute("food", food);
                request.setAttribute("reviews", reviews);
                request.setAttribute("avgRating", avgRating);
                request.getRequestDispatcher("/view/food-detail.jsp").forward(request, response);
        }

        @Override
        protected void doPost(HttpServletRequest request, HttpServletResponse response)
                        throws ServletException, IOException {
                String foodIdParam = request.getParameter("foodID");
                int foodID = 1;
                try {
                        foodID = Integer.parseInt(foodIdParam);
                } catch (Exception ignored) {
                }

                String ratingStr = request.getParameter("rating");
                String comment = request.getParameter("comment");
                int rating = 0;
                try {
                        rating = Integer.parseInt(ratingStr);
                } catch (Exception ignored) {
                }

                // Lưu review mới vào session (theo foodID)
                List<Map<String, Object>> reviews = (List<Map<String, Object>>) request.getSession()
                                .getAttribute("reviews_" + foodID);
                if (reviews == null)
                        reviews = new ArrayList<>();
                Map<String, Object> newReview = new HashMap<>();
                newReview.put("name", "Bạn"); // Nếu có user đăng nhập thì lấy tên user
                newReview.put("rating", rating);
                newReview.put("comment", comment);
                newReview.put("date", java.time.LocalDate.now().toString());
                reviews.add(0, newReview); // Thêm lên đầu
                request.getSession().setAttribute("reviews_" + foodID, reviews);

                // Nếu user đã đăng nhập thì thêm vào lịch sử nấu ăn
                model.Users user = (model.Users) request.getSession().getAttribute("user");
                if (user != null) {
                        List<Map<String, Object>> history = (List<Map<String, Object>>) request.getSession()
                                        .getAttribute("history_" + user.getUserID());
                        if (history == null)
                                history = new ArrayList<>();
                        // Lấy tên món ăn
                        String foodName = "Món ăn";
                        Map<String, Object> food = (Map<String, Object>) request.getAttribute("food");
                        if (food == null) {
                                // Lấy lại mock data cho foodID này
                                food = new HashMap<>();
                                if (foodID == 1)
                                        foodName = "Phở Bò";
                                else if (foodID == 2)
                                        foodName = "Bánh mì thịt";
                                else if (foodID == 3)
                                        foodName = "Bún chả Hà Nội";
                                else if (foodID == 4)
                                        foodName = "Cơm tấm sườn bì";
                                else if (foodID == 5)
                                        foodName = "Trà sữa trân châu";
                                else if (foodID == 6)
                                        foodName = "Bánh tráng trộn";
                                else if (foodID == 7)
                                        foodName = "Matcha đá xay";
                        } else {
                                foodName = (String) food.get("name");
                        }
                        Map<String, Object> historyItem = new HashMap<>();
                        historyItem.put("foodID", foodID);
                        historyItem.put("foodName", foodName);
                        historyItem.put("date", java.time.LocalDate.now().toString());
                        historyItem.put("rating", rating);
                        historyItem.put("comment", comment);
                        history.add(0, historyItem);
                        request.getSession().setAttribute("history_" + user.getUserID(), history);
                }

                // Forward lại như doGet
                doGet(request, response);
        }
}