import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cards_screen.dart';
import 'mukhtar_screen.dart';
import 'consultation_screen.dart';
import 'document_request_screen.dart';
import 'appointment_screen.dart';
import 'user_profile_screen.dart';
import 'notification_screen.dart';
import '../services/notification_service.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final unreadCount = context.watch<NotificationService>().unreadCount;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: null,
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 1.0, left: 20.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Image.asset('assets/logo.png', width: 120, height: 120),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Text(
              'مرحباً',
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 20),
            child: Center(child: Image.asset('assets/flag.png', height: 90)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'هذا التطبيق الالكتروني\nلمختار مار ميخائيل بنابيل',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, height: 1.5),
            ),
          ),
          Expanded(
            child: GridView.count(
              padding: const EdgeInsets.all(20),
              crossAxisCount: 2,
              childAspectRatio: 1.5,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              children: [
                _buildMenuButton(context, 'طلب موعد', Icons.calendar_today),
                _buildMenuButton(context, 'تقديم طلب', Icons.edit_document),
                _buildMenuButton(
                  context,
                  'تعرف على المختار',
                  Icons.info_outline,
                ),
                _buildMenuButton(context, 'استشارات', Icons.chat),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home, color: Color(0xFF075E54)),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.credit_card, color: Colors.grey),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CardsScreen()),
                );
              },
            ),
            Stack(
              children: [
                IconButton(
                  icon: Icon(Icons.notifications, color: Colors.grey),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NotificationScreen(),
                      ),
                    );
                  },
                ),
                if (unreadCount > 0)
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 12,
                        minHeight: 12,
                      ),
                      child: Text(
                        unreadCount.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
            IconButton(
              icon: Icon(Icons.person, color: Colors.grey),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UserProfileScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuButton(BuildContext context, String text, IconData icon) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>((
          Set<MaterialState> states,
        ) {
          if (states.contains(MaterialState.pressed)) {
            return Color(0xFF4CAF50);
          }
          return Color(0xFF075E54);
        }),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: Color(0xFF075E54), width: 1),
          ),
        ),
        padding: MaterialStateProperty.all(EdgeInsets.all(12)),
      ),
      onPressed: () {
        if (text == 'تقديم طلب') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const DocumentRequestScreen(),
            ),
          );
        }
        const calendlyUrl = 'https://calendly.com/emokhtar-ai/30min';
        if (text == 'طلب موعد') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AppointmentScreen(calendlyUrl: calendlyUrl),
            ),
          );
        }

        if (text == 'استشارات') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ConsultationScreen()),
          );
        }
        if (text == 'تعرف على المختار') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MukhtarScreen()),
          );
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 30),
          SizedBox(height: 8),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
        ],
      ),
    );
  }
}