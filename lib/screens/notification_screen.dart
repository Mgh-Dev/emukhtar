import 'package:flutter/material.dart';
import 'notification_model.dart';

class NotificationModel {
  final String id;
  final String title;
  final String message;
  final DateTime date;
  bool isRead;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.date,
    this.isRead = false,
  });
}

class NotificationService extends ChangeNotifier {
  List<NotificationModel> _notifications = [
    NotificationModel(
      id: '1',
      title: 'New Message',
      message: 'You have received a new message from support',
      date: DateTime.now().subtract(const Duration(minutes: 5)),
      isRead: false,
    ),
    NotificationModel(
      id: '2',
      title: 'Appointment Reminder',
      message: 'Your appointment is scheduled for tomorrow at 10:00 AM',
      date: DateTime.now().subtract(const Duration(hours: 2)),
      isRead: false,
    ),
    NotificationModel(
      id: '3',
      title: 'Profile Update',
      message: 'Your profile information has been updated successfully',
      date: DateTime.now().subtract(const Duration(days: 1)),
      isRead: true,
    ),
  ];

  // Get all notifications
  List<NotificationModel> get notifications => _notifications;

  // Get unread notifications count
  int get unreadCount => _notifications.where((n) => !n.isRead).length;

  // Mark notification as read
  void markAsRead(String id) {
    final index = _notifications.indexWhere((n) => n.id == id);
    if (index != -1) {
      _notifications[index].isRead = true;
      notifyListeners(); // This updates all listeners
    }
  }

  // Add new notification
  void addNotification(NotificationModel notification) {
    _notifications.insert(0, notification); // Add to beginning of list
    notifyListeners();
  }

  // Clear all notifications
  void clearAll() {
    _notifications.clear();
    notifyListeners();
  }

  // Mark all as read
  void markAllAsRead() {
    for (var notification in _notifications) {
      notification.isRead = true;
    }
    notifyListeners();
  }
}