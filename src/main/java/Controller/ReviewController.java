/*
 * FLOW: Hệ thống đánh giá/phản hồi người dùng
 * 1. Khách hàng truy cập trang đánh giá đơn hàng (/customer/review?bookingId=...).
 * 2. Controller kiểm tra đã đánh giá chưa, nếu chưa thì lấy thông tin booking và render form đánh giá.
 * 3. Người dùng gửi đánh giá (tổng thể và từng món).
 * 4. Controller nhận dữ liệu, tạo đối tượng Review và ReviewDetail, lưu vào database.
 * 5. Thông báo thành công và chuyển hướng về lịch sử booking.
 *
 * File chính: ReviewController.java
 */
package Controller;

import Dao.BookingDao;
import Dao.ReviewDao;
import Dao.ReviewDetailDao;
import Model.Booking;
import Model.BookingDetail;
import Model.Review;
import Model.ReviewDetail;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class ReviewController {
    @WebServlet("/customer/review")
    public static class CustomerReviewServlet extends HttpServlet {
        @Override
        protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            // Kiểm tra đã đánh giá chưa, nếu chưa thì lấy thông tin booking và chuyển sang
            // trang review
            req.getRequestDispatcher("/views/customer/review.jsp").forward(req, resp);
        }

        @Override
        protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            // Lấy thông tin đánh giá tổng thể và chi tiết từng món
            // Tạo đối tượng Review và ReviewDetail, lưu vào database
            // Thông báo thành công và chuyển hướng về lịch sử booking
            resp.sendRedirect(req.getContextPath() + "/customer/bookings");
        }
    }
}
