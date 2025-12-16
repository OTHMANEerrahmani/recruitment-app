package com.recruitment.service;

import com.recruitment.dao.NotificationDAO;
import com.recruitment.entity.Notification;
import com.recruitment.entity.User;
import java.util.List;

public class NotificationService {

    private final NotificationDAO notificationDAO = new NotificationDAO();
    private final EmailService emailService = new EmailService();
    private final SmsService smsService = new SmsService();

    public void createNotification(User user, String message, Notification.NotificationType type) {
        Notification notification = new Notification(user, message, type);
        notificationDAO.save(notification);
    }

    public List<Notification> getUserNotifications(User user) {
        return notificationDAO.findByUser(user);
    }

    public long getUnreadCount(User user) {
        return notificationDAO.countUnread(user);
    }

    public void markAllSameRead(User user) {
        notificationDAO.markAllAsRead(user);
    }

    // Integration Helpers

    public void notifyApplication(User companyUser, User candidateUser, String jobTitle) {
        // 1. Notify Company (In-App)
        createNotification(companyUser, "New application received for " + jobTitle,
                Notification.NotificationType.APPLICATION);

        // 2. Email Company (Mock)
        emailService.sendEmail(companyUser.getEmail(), "New Application: " + jobTitle,
                "Hello, \n\nYou have received a new application for " + jobTitle + ". Check your dashboard.");

        // 3. Email Candidate (Confirmation)
        emailService.sendEmail(candidateUser.getEmail(), "Application Received",
                "Hi " + candidateUser.getEmail() + ",\n\nWe have received your application for " + jobTitle + ".");
    }

    public void notifyStatusChange(User candidateUser, String jobTitle, String status) {
        // 1. Notify Candidate (In-App)
        createNotification(candidateUser, "Status update: Your application for " + jobTitle + " is now " + status,
                Notification.NotificationType.STATUS_CHANGE);

        // 2. Email Candidate
        emailService.sendEmail(candidateUser.getEmail(), "Application Status Update",
                "Hi,\n\nYour application for " + jobTitle + " has been updated to: " + status + ".");

        // 3. SMS Candidate
        smsService.sendSms("+212600000000", "RecruttAnty: Application for " + jobTitle + " is now " + status);
    }
}
