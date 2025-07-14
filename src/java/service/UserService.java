package service;

import DAO.UserDAO;
import model.User;

public class UserService {

    private UserDAO userDAO = new UserDAO();

    public User login(String email, String password) {
        return userDAO.getUserByEmailAndPassword(email, password);
    }

    public void register(User user) {
        userDAO.addUser(user);
    }

    public boolean isEmailExists(String email) {
        return userDAO.isEmailExists(email);
    }

    public boolean updatePassword(String email, String newPassword) {
        return userDAO.updatePassword(email, newPassword);
    }

    public User getUserByEmail(String email) {
        return userDAO.getUserByEmail(email);
    }
}
