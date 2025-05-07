import 'package:flutter/material.dart';

class CardsScreen extends StatelessWidget {
  final List<String> documents = [
    'الهوية الوطنية',
    'رخصة القيادة',
    'جواز السفر',
    'شهادة الميلاد'
  ];
  String? selectedDocument;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE8F5E9), // Light green background
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Image.asset('assets/logo.png', height: 40), // Smaller logo
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'المستندات',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              decoration: BoxDecoration(
                color: Color(0xFF075E54),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(Icons.add, color: Colors.white),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: documents.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      selectedDocument = documents[index];
                    },
                    child: Column(
                      children: [
                        if (selectedDocument == documents[index])
                          Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              selectedDocument!,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        Card(
                          margin: EdgeInsets.only(bottom: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 3,
                          child: Container(
                            height: 180,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color(0xFF075E54),
                                  Color(0xFF4CAF50),
                                ],
                              ),
                            ),
                            child: Center(
                              child: Text(
                                documents[index],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}