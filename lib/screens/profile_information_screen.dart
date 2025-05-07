import 'package:flutter/material.dart';

class ProfileInformationScreen extends StatelessWidget {
  const ProfileInformationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F5E9), // Light green background
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: const Color(0xFFE8F5E9), // Light green
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'معلومات الحساب',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: const Center(
        child: Text(
          'معلومات الحساب هنا',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}
