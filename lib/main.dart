import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scanbot_sdk/scanbot_sdk.dart';
import 'screens/phone_input_screen.dart';
import 'services/auth_service.dart';
import 'services/user_service.dart';
import 'services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Scanbot SDK
  await ScanbotSdk.initScanbotSdk(
    ScanbotSdkConfig(
      licenseKey: 'YOUR_SCANBOT_LICENSE_KEY', // <-- Replace with your actual key
      loggingEnabled: true,
    ),
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        Provider(create: (_) => UserService()),
        ChangeNotifierProvider(create: (_) => NotificationService()), // Add this line
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-MOKHTAR',
      theme: ThemeData(
        primaryColor: Color(0xFF075E54),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF075E54),
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
        ),
      ),
      home: PhoneInputScreen(),
    );
  }
}