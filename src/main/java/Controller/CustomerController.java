package Controller;

import Dao.AllergyTypeDao;
import Dao.CustomerDao;
import Dao.TasteDao;
import Dao.UserDao;
import Model.AllergyType;
import Model.Constant.Gender;
import Model.Customer;
import Model.Taste;
import Model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDate;
import java.util.*;
import java.util.function.Function;
import java.util.stream.Collectors;

public class CustomerController {

    private static final UserDao userDao = new UserDao();
    private static final TasteDao tasteDao = new TasteDao();
    private static final AllergyTypeDao allergyTypeDao = new AllergyTypeDao();
    private static final CustomerDao customerDao = new CustomerDao();

    private static <E> Set<E> fetchEntities(String param, HttpServletRequest req, Function<List<Long>, List<E>> fetcher) {
        String[] values = req.getParameterValues(param);
        if (values == null) {
            return Collections.emptySet();
        }
        List<Long> ids = Arrays.stream(values)
                .map(Long::parseLong)
                .collect(Collectors.toList());
        return new HashSet<>(fetcher.apply(ids));
    }

    private static User getSessionUser(HttpServletRequest req) {
        return (User) req.getSession().getAttribute("user");
    }

    @WebServlet("/customer/profile")
    public static class ProfileServlet extends HttpServlet {
        @Override
        protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            User user = getSessionUser(req);
            Customer customer = customerDao.getById(user.getId());
            req.setAttribute("customer", customer);
            req.getRequestDispatcher("/views/customer/profile.jsp").forward(req, resp);
        }

        @Override
        protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            User user = getSessionUser(req);
            Customer customer = customerDao.getById(user.getId());
            customer.setFirstName(req.getParameter("firstName"));
            customer.setLastName(req.getParameter("lastName"));
            customer.setDateOfBirth(LocalDate.parse(req.getParameter("dateOfBirth")));
            customer.setGender(Gender.valueOf(req.getParameter("gender")));
            customerDao.update(customer);
            req.getSession().setAttribute("flash_success", "Cập nhật người dùng thành công.");
            resp.sendRedirect(req.getContextPath() + "/customer/profile");
        }
    }

    @WebServlet("/customer/tastes")
    public static class TastesServlet extends HttpServlet {
        @Override
        protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            User user = userDao.getById(getSessionUser(req).getId());
            user.setFavoriteTastes(fetchEntities("tastes", req, tasteDao::getByIds));
            userDao.update(user);
            req.getSession().setAttribute("user", user);
            resp.sendRedirect(req.getHeader("referer"));
        }
    }

    @WebServlet("/customer/allergies")
    public static class AllergiesServlet extends HttpServlet {
        @Override
        protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            User user = userDao.getById(getSessionUser(req).getId());
            user.setAllergies(fetchEntities("allergies", req, allergyTypeDao::getByIds));
            userDao.update(user);
            req.getSession().setAttribute("user", user);
            resp.sendRedirect(req.getHeader("referer"));
        }
    }
}
