import 'package:flutter/material.dart';

enum PhoneApprovalStatus {
  approved,
  pendingOrRejected,
  blocked,
}

class AuthService with ChangeNotifier {
  Future<PhoneApprovalStatus> checkPhoneApproval(String phone) async {
    // Dummy logic simulating Firestore check
    if (phone == "+1234567890") {
      return PhoneApprovalStatus.approved;
    }

    // Simulate checking last request timestamp (blocked < 90 days)
    final now = DateTime.now();
    final lastRequest = DateTime.now().subtract(Duration(days: 30)); // Dummy

    if (now.difference(lastRequest).inDays < 90) {
      return PhoneApprovalStatus.blocked;
    }

    return PhoneApprovalStatus.pendingOrRejected;
  }
}
