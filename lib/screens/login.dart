import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:flutter/gestures.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import 'otp_screen.dart';
import 'signup.dart';
import 'home_screen.dart'; // Add this import

class PhoneInputScreen extends StatefulWidget {
  @override
  _PhoneInputScreenState createState() => _PhoneInputScreenState();
}

class _PhoneInputScreenState extends State<PhoneInputScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                Image.asset(
                  'assets/logo.png',
                  height: 320,
                ),
                const SizedBox(height: 40),
                IntlPhoneField(
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(),
                  ),
                  initialCountryCode: 'LB',
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: isLoading ? null : () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF075E54),
                    minimumSize: const Size(double.infinity, 48),
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          "Continue", 
                          style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
                const SizedBox(height: 12),
                RichText(
                  text: TextSpan(
                    text: 'Click here to ',
                    style: const TextStyle(color: Colors.black87),
                    children: [
                      TextSpan(
                        text: 'Register',
                        style: const TextStyle(
                          color: Color(0xFF075E54),
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => RequestScreen(),
                              ),
                            );
                          },
                      ),
                    ],
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
          // Skip button in bottom left corner
          Positioned(
            left: 20,
            bottom: 20,
            child: TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => HomeScreen()),
                );
              },
              child: const Text(
                'Skip',
                style: TextStyle(
                  color: Color(0xFF075E54),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}