package com.recruitment.service;

import java.util.Properties;
import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

public class EmailService {

    private final String username = "your_email@gmail.com"; // Replace with real or env var
    private final String password = "your_app_password"; // Replace with real or env var

    public void sendEmail(String to, String subject, String body) {
        // For development/demo purposes, we'll log the email instead of failing if not
        // configured
        System.out.println("--------------------------------------------------");
        System.out.println("📧 MOCK EMAIL SERVICE (Real implementation provided below)");
        System.out.println("To: " + to);
        System.out.println("Subject: " + subject);
        System.out.println("Body: " + body);
        System.out.println("--------------------------------------------------");

        // UNCOMMENT THE FOLLOWING BLOCK TO ENABLE REAL EMAILS (Requires SMTP Config)
        
         Properties props = new Properties();
         props.put("mail.smtp.auth", "true");
         props.put("mail.smtp.starttls.enable", "true");
         props.put("mail.smtp.host", "smtp.gmail.com");
         props.put("mail.smtp.port", "587");
         
         Session session = Session.getInstance(props,
         new jakarta.mail.Authenticator() {
         protected PasswordAuthentication getPasswordAuthentication() {
         return new PasswordAuthentication(username, password);
         }
         });
         
         try {
         Message message = new MimeMessage(session);
         message.setFrom(new InternetAddress(username));
         message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
         message.setSubject(subject);
         message.setText(body);
         
         Transport.send(message);
         System.out.println("Email sent successfully!");
         
         } catch (MessagingException e) {
         e.printStackTrace();
         }
         
    }
}
