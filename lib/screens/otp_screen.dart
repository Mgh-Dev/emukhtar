import 'package:flutter/material.dart';

class OTPScreen extends StatelessWidget {
  final String phoneNumber;

  OTPScreen({required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    // In a real app, trigger Firebase OTP here
    return Scaffold(
      appBar: AppBar(title: Text("Verify OTP")),
      body: Center(
        child: Text("OTP sent to $phoneNumber"),
      ),
    );
  }
}
