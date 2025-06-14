package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;

public class caloriesServlet extends HttpServlet {
    private static final String API_KEY = "oFhLgK1SqJwBPqAQAxwW/Q==zBLT9z62e26Wo8GB"; // replace with your key

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String foodName = request.getParameter("food");
        if (foodName == null || foodName.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing food name");
            return;
        }

        String apiUrl = "https://api.calorieninjas.com/v1/nutrition?query=" + 
                        java.net.URLEncoder.encode(foodName, "UTF-8");

        URL url = new URL(apiUrl);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("X-Api-Key", API_KEY);

        response.setContentType("application/json");
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream(), StandardCharsets.UTF_8));
             PrintWriter out = response.getWriter()) {

            String line;
            while ((line = reader.readLine()) != null) {
                out.println(line);
            }
        } catch (IOException e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error calling API");
        }
    }
}
