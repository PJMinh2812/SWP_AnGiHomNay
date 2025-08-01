/*
 * FLOW: Quản lý phân loại món ăn (Food Categorization)
 * 1. Nhà hàng đăng nhập vào hệ thống.
 * 2. Truy cập trang quản lý món ăn (/restaurant/foods).
 * 3. Controller lấy danh sách category, taste, allergy, food từ DB và render ra view.
 * 4. Khi thêm/sửa món ăn, controller nhận dữ liệu từ form, tạo đối tượng Food với các category/taste/allergy liên quan.
 * 5. Lưu món ăn vào database.
 * 6. Người dùng tìm kiếm món ăn có thể lọc theo category, taste, allergy, price...
 *
 * File chính: FoodController.java
 */
package Controller;

import Dao.*;
import Model.*;

import Util.UploadImage;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.json.JSONArray;
import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.*;

public class FoodController {
    @WebServlet("/restaurant/foods")
    @MultipartConfig
    public static class RestaurantFoodServlet extends HttpServlet {
        @Override
        protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            // Lấy danh sách category, taste, allergy, food của nhà hàng
            // Đưa dữ liệu lên view để render giao diện quản lý món ăn
            req.getRequestDispatcher("/views/restaurant/food.jsp").forward(req, resp);
        }

        @Override
        protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            // Lấy thông tin món ăn từ form
            // Lấy danh sách category, taste, allergy từ form
            // Tạo đối tượng Food và lưu vào database
            // Chuyển hướng về trang quản lý món ăn
            resp.sendRedirect(req.getContextPath() + "/restaurant/foods");
        }
    }

    @WebServlet("/restaurant/edit-food")
    @MultipartConfig
    public static class RestaurantEditFood extends HttpServlet {
        @Override
        protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            RestaurantDao restaurantDao = new RestaurantDao();
            FoodDao foodDao = new FoodDao();
            CategoryDao categoryDao = new CategoryDao();

            User user = (User) req.getSession().getAttribute("user");
            Restaurant restaurant = restaurantDao.getById(user.getId());
            long id = Long.parseLong(req.getParameter("id"));
            Food food = foodDao.getFoodOfRestaurant(restaurant, id);
            if (food == null) {
                req.getSession().setAttribute("flash_error", "Không tìm thấy món ăn này.");
                resp.sendRedirect(req.getContextPath() + "/restaurant/foods");
                return;
            }
            String name = req.getParameter("name");
            String description = req.getParameter("description");
            double price = Double.parseDouble(req.getParameter("price"));
            List<Long> categoryIds = Optional.ofNullable(req.getParameterValues("categoryIds")).stream()
                    .flatMap(Arrays::stream)
                    .map(Long::parseLong)
                    .toList();
            Set<Category> categories = new HashSet<>(categoryDao.getByIds(categoryIds));
            boolean isAvailable = Boolean.parseBoolean(req.getParameter("available"));
            if (req.getPart("image") != null && req.getPart("image").getSize() > 0) {
                food.setImage(UploadImage.saveImage(req, "image"));
            }

            List<Long> tasteIds = Optional.ofNullable(req.getParameterValues("tasteIds"))
                    .stream().flatMap(Arrays::stream).map(Long::parseLong).toList();
            Set<Taste> tastes = new HashSet<>(new TasteDao().getByIds(tasteIds));

            List<Long> allergyIds = Optional.ofNullable(req.getParameterValues("allergyIds"))
                    .stream().flatMap(Arrays::stream).map(Long::parseLong).toList();
            Set<AllergyType> allergies = new HashSet<>(new AllergyTypeDao().getByIds(allergyIds));

            food.setName(name);
            food.setDescription(description);
            food.setPrice(price);
            food.setCategories(categories);
            food.setAvailable(isAvailable);
            food.setTastes(tastes);
            food.setAllergyContents(allergies);
            foodDao.update(food);
            req.getSession().setAttribute("flash_success", "Cập nhật thành công.");
            resp.sendRedirect(req.getContextPath() + "/restaurant/foods");
        }
    }

    @WebServlet("/search")
    public static class SearchFoodServlet extends HttpServlet {
        @Override
        protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            // Lấy các tham số tìm kiếm từ form
            // Tìm kiếm món ăn theo keyword, category, allergy, taste, price
            // Đưa kết quả tìm kiếm và review lên view

            boolean hasParams = req.getParameterMap().keySet().stream()
                    .anyMatch(key -> req.getParameter(key) != null && !req.getParameter(key).trim().isEmpty());

            if (!hasParams) {
                req.getRequestDispatcher("/views/public/search.jsp").forward(req, resp);
                return;
            }
            FoodDao foodDao = new FoodDao();
            String searchString = req.getParameter("searchString");
            String[] categoryIds = req.getParameterValues("categories");
            String[] allergyIds = req.getParameterValues("allergyContents");
            String[] tasteIds = req.getParameterValues("tastes");

            Double priceFrom = parseDouble(req.getParameter("priceFrom"));
            Double priceTo = parseDouble(req.getParameter("priceTo"));

            List<Food> result = foodDao.searchFoods(searchString, priceFrom, priceTo, categoryIds, allergyIds,
                    tasteIds);
            // System.out.println("debug in servlet");
            // for (int i = 0; i < result.size(); i++) {
            // System.out.println(result.get(i).getId());
            // System.out.println(result.get(i).getCategories());
            // System.out.println(result.get(i).getAllergyContents());
            // System.out.println(result.get(i).getTastes());
            // }
            // System.out.println("debug in servlet");
            List<Long> foodIds = new ArrayList<>();
            for (Food food : result) {
                foodIds.add(food.getId());
            }
            List<List<ReviewDetail>> details = new ReviewDetailDao().findReviewDetailsByFoodIdsInOrder(foodIds);
            req.setAttribute("foodList", result);
            req.setAttribute("details", details);
            req.getRequestDispatcher("/views/public/search.jsp").forward(req, resp);
        }

        private Double parseDouble(String s) {
            try {
                return (s != null && !s.trim().isEmpty()) ? Double.parseDouble(s) : null;
            } catch (NumberFormatException e) {
                return null;
            }
        }
    }

    @WebServlet("/food-detail")
    public static class FoodDetailServlet extends HttpServlet {
        @Override
        protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            // Lấy id món ăn từ request
            // Lấy thông tin món ăn và review từ database
            // Đưa dữ liệu lên view chi tiết món ăn
            long id = Long.parseLong(req.getParameter("id"));
            FoodDao foodDao = new FoodDao();
            ReviewDetailDao reviewDetailDao = new ReviewDetailDao();
            Food food = foodDao.getById(id);
            if (food == null) {
                req.getSession().setAttribute("flash_success", "Không tìm thấy món ăn này.");
                resp.sendRedirect(req.getContextPath() + "/");
                return;
            }
            List<ReviewDetail> reviewDetails = reviewDetailDao.getDetailsByFoodId(food.getId());
            req.setAttribute("reviewDetails", reviewDetails);
            req.setAttribute("food", food);
            req.getRequestDispatcher("/views/public/food-detail.jsp").forward(req, resp);
        }
    }

    @WebServlet("/api/ask-ai")
    public static class AskAI extends HttpServlet {

        @Override
        protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            String emotion = req.getParameter("emotion");
            String hunger = req.getParameter("hunger");
            String time = req.getParameter("time");
            String tastes = req.getParameter("tastes");
            String allergies = req.getParameter("allergies");

            List<Food> foods = new FoodDao().getFoodsWithAllProperties();
            JSONArray foodArray = convertFoodsToJson(foods);

            // Chuẩn bị prompt gửi lên AI
            StringBuilder userInfo = new StringBuilder("Thông tin người dùng:\n");

            if (emotion != null && !emotion.isBlank()) {
                userInfo.append("- Cảm xúc: ").append(emotion).append("\n");
            }
            if (hunger != null && !hunger.isBlank()) {
                userInfo.append("- Mức độ đói: ").append(hunger).append("\n");
            }
            if (time != null && !time.isBlank()) {
                userInfo.append("- Thời điểm ăn: ").append(time).append("\n");
            }
            if (tastes != null && !tastes.isBlank()) {
                userInfo.append("- Sở thích: ").append(tastes).append("\n");
            }
            if (allergies != null && !allergies.isBlank()) {
                userInfo.append("- Dị ứng: ").append(allergies).append("\n");
            }

            // Nếu không có dòng nào, thì ghi là "Không có thông tin"
            if (userInfo.toString().trim().equals("Thông tin người dùng:")) {
                userInfo = new StringBuilder("Thông tin người dùng: Không có thông tin cụ thể.\n");
            }

            String prompt = String.format(
                    """
                            Dưới đây là danh sách món ăn, mỗi món bao gồm: id, name, price:

                            %s

                            %s

                            Nhiệm vụ:
                            1. Phân tích tình trạng người dùng hiện tại, nên ăn món có đặc điểm như thế nào.
                            2. Trả về danh sách `id` của các món ăn phù hợp từ danh sách trên (tối đa 3, nếu không có món ăn nào thì trả về recommendedIds rỗng).

                            Yêu cầu kết quả:
                            {
                              "analysis": "Phân tích bằng tiếng Việt...",
                              "recommendedIds": [1, 5, 7]
                            }
                            """,
                    foodArray.toString(2),
                    userInfo.toString().trim());

            resp.setCharacterEncoding("UTF-8");
            resp.setContentType("application/json");

            try {
                String aiResponse = askAI(prompt);
                System.out.println(aiResponse);
                resp.getWriter().write(aiResponse);
            } catch (Exception e) {
                e.printStackTrace();
                resp.getWriter().write("{\"error\":\"Lỗi khi sử dụng AI\"}");
            }
        }

        public static JSONArray convertFoodsToJson(List<Food> foods) {
            JSONArray jsonArray = new JSONArray();
            for (Food food : foods) {
                JSONObject foodJson = new JSONObject();
                foodJson.put("id", food.getId());
                foodJson.put("name", food.getName());
                foodJson.put("price", food.getPrice());
                jsonArray.put(foodJson);
            }
            return jsonArray;
        }

        public String askAI(String promptText) throws Exception {
            String apiKey = "AIzaSyAbobxuRAYZy7bfBTqgsLqUMRDsL12FDbc"; // Đổi API key tại đây
            // String apiKey = "AIzaSyAHM3svzVsDVpvocf9r7glnk8sgaP6eXLY"; // Đổi API key tại
            // đây
            JSONObject payload = new JSONObject();
            JSONArray contents = new JSONArray();
            JSONArray parts = new JSONArray();
            JSONObject textPart = new JSONObject();
            textPart.put("text", promptText);
            parts.put(textPart);
            JSONObject content = new JSONObject();
            content.put("parts", parts);
            contents.put(content);
            payload.put("contents", contents);

            // String urlString =
            // "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent";
            String urlString = "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-8b-latest:generateContent";
            URL url = new URL(urlString);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            conn.setRequestProperty("X-goog-api-key", apiKey);
            conn.setDoOutput(true);

            try (OutputStream os = conn.getOutputStream()) {
                byte[] input = payload.toString().getBytes("utf-8");
                os.write(input, 0, input.length);
            }

            int responseCode = conn.getResponseCode();
            if (responseCode != 200) {
                throw new RuntimeException("Request failed: HTTP code " + responseCode);
            }

            StringBuilder responseStr = new StringBuilder();
            try (BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"))) {
                String responseLine;
                while ((responseLine = br.readLine()) != null) {
                    responseStr.append(responseLine.trim());
                }
            }

            JSONObject responseBody = new JSONObject(responseStr.toString());
            JSONArray candidates = responseBody.getJSONArray("candidates");
            if (!candidates.isEmpty()) {
                JSONObject firstCandidate = candidates.getJSONObject(0);
                JSONObject contentObj = firstCandidate.getJSONObject("content");
                JSONArray partsArray = contentObj.getJSONArray("parts");
                String rawText = partsArray.getJSONObject(0).getString("text");

                // Loại bỏ markdown nếu có
                rawText = rawText.replace("```json", "").replace("```", "").trim();

                return rawText;
            }

            return "{\"analysis\":\"Không có phản hồi từ AI\",\"recommendedIds\":[]}";
        }
    }

    @WebServlet("/api/get-all-food")
    public static class GetAllFoodServlet extends HttpServlet {
        @Override
        protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            List<Food> foods = new FoodDao().getAll();
            JSONArray jsonArray = new JSONArray();

            for (Food food : foods) {
                JSONObject jsonFood = new JSONObject();
                jsonFood.put("id", food.getId());
                jsonFood.put("name", food.getName());
                jsonFood.put("description", food.getDescription());
                jsonFood.put("price", food.getPrice());
                jsonFood.put("image", food.getImage());
                jsonFood.put("isAvailable", food.isAvailable());

                // Add categories
                JSONArray jsonCategories = new JSONArray();
                if (food.getCategories() != null) {
                    for (Category category : food.getCategories()) {
                        JSONObject jsonCategory = new JSONObject();
                        jsonCategory.put("id", category.getId());
                        jsonCategory.put("name", category.getName());
                        jsonCategories.put(jsonCategory);
                    }
                }
                jsonFood.put("categories", jsonCategories);

                jsonArray.put(jsonFood);
            }
            resp.getWriter().write(jsonArray.toString());
        }
    }
}
