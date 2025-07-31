package Util;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

import java.io.UnsupportedEncodingException;
import java.util.Properties;

/*
 * FLOW: Gửi thông báo (email) cho các sự kiện đặt bàn/đơn hàng
 * 1. Khi có sự kiện quan trọng (đặt bàn, thanh toán thành công, quên mật khẩu, đăng ký tài khoản...).
 * 2. Controller gọi hàm gửi email (Mail.send(...)) với nội dung phù hợp.
 * 3. Mail.java thiết lập SMTP, tạo email và gửi đi.
 * 4. Người dùng nhận được email thông báo.
 *
 * File chính: Mail.java, gọi từ các controller như PaymentController, UserController...
 */
public class Mail {
    // Gửi email thông báo cho người dùng
    public static boolean send(String mail_to, String subject, String html) {
        // Thiết lập cấu hình SMTP
        // Tạo session gửi mail
        // Tạo nội dung email (subject, body, recipient)
        // Gửi email qua SMTP
        // Trả về true nếu gửi thành công, false nếu có lỗi
        System.out.println("in send mail func");
        Properties properties = new Properties();
        properties.put("mail.smtp.host", "smtp.gmail.com");
        properties.put("mail.smtp.port", "587");
        properties.put("mail.smtp.auth", "true"); // if authentication is required
        properties.put("mail.smtp.starttls.enable", "true"); // if using TLS
        Session session = Session.getInstance(properties, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(Config.email_address, Config.email_password);
            }
        });
        try {
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(Config.email_address, Config.app_name));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(mail_to));
            message.setSubject(subject);
            message.setContent(html, "text/html; charset=UTF-8");
            Transport.send(message);
            return true;
        } catch (MessagingException | UnsupportedEncodingException e) {
            e.printStackTrace();
            return false;
        }
    }
}
