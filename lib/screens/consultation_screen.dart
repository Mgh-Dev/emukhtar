import 'package:flutter/material.dart';

class ConsultationScreen extends StatefulWidget {
  const ConsultationScreen({super.key});

  @override
  State<ConsultationScreen> createState() => _ConsultationScreenState();
}

class _ConsultationScreenState extends State<ConsultationScreen> {
  String _selectedFilter = 'all';
  final Map<String, List<Map<String, dynamic>>> _questions = {
    'all': [
      {
        'question': 'كيف يمكنني تقديم طلب مستند رسمي؟',
        'answer': 'يمكنك تقديم طلب المستندات الرسمية من خلال قسم "تقديم طلب" في التطبيق.',
        'expanded': false
      },
      {
        'question': 'ما هي مواعيد استقبال المختار؟',
        'answer': 'يستقبل المختار من الساعة 9 صباحاً حتى 2 ظهراً من الأحد إلى الخميس.',
        'expanded': false
      },
    ],
    'documents': [
      {
        'question': 'ما هي المستندات المطلوبة لطلب شهادة إقامة؟',
        'answer': 'تحتاج إلى صورة الهوية وصورة عقد الإيجار أو الملكية.',
        'expanded': false
      },
    ],
    'frequent': [
      {
        'question': 'كم تستغرق معالجة الطلب؟',
        'answer': 'تستغرق معالجة الطلبات عادةً من 3 إلى 5 أيام عمل.',
        'expanded': false
      },
    ]
  };

  void _toggleQuestion(int index) {
    setState(() {
      _questions[_selectedFilter]![index]['expanded'] = 
          !_questions[_selectedFilter]![index]['expanded'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F5E9),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: const Color(0xFFE8F5E9), // Light green background
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'أسئلة واستشارات',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Filter Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildFilterButton('الكل', 'all'),
                _buildFilterButton('المستندات', 'documents'),
                _buildFilterButton('الأسئلة الشائعة', 'frequent'),
              ],
            ),
            const SizedBox(height: 20),
            
            // Questions List
            Expanded(
              child: ListView.builder(
                itemCount: _questions[_selectedFilter]!.length,
                itemBuilder: (context, index) {
                  final question = _questions[_selectedFilter]![index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 2,
                    margin: const EdgeInsets.only(bottom: 15),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: question['expanded'] 
                            ? null 
                            : const LinearGradient(
                                colors: [
                                  Color(0xFF075E54),
                                  Color(0xFF4CAF50),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                        color: question['expanded'] 
                            ? const Color(0xFF075E54)
                            : null,
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                            title: Text(
                              question['question'],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: question['expanded'] 
                                    ? Colors.white 
                                    : Colors.white,
                              ),
                              textAlign: TextAlign.right,
                            ),
                            trailing: Icon(
                              question['expanded'] 
                                  ? Icons.keyboard_arrow_up 
                                  : Icons.keyboard_arrow_down,
                              color: Colors.white,
                            ),
                            onTap: () => _toggleQuestion(index),
                          ),
                          if (question['expanded'])
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                              ),
                              child: Text(
                                question['answer'],
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[700],
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: Container(
        margin: const EdgeInsets.only(left: 20, bottom: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Ask AI-Mokhtar',
              style: TextStyle(
                color: const Color(0xFF075E54),
                fontWeight: FontWeight.bold,
                shadows: const [
                  Shadow(
                    blurRadius: 2,
                    color: Colors.black12,
                    offset: Offset(1, 1),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            FloatingActionButton(
              onPressed: () {
                // Add AI assistant functionality
              },
              backgroundColor: const Color(0xFF075E54),
              elevation: 5,
              child: const Icon(Icons.assistant, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterButton(String text, String value) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: _selectedFilter == value 
            ? const Color(0xFF075E54) 
            : Colors.grey[300],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      ),
      onPressed: () {
        setState(() {
          _selectedFilter = value;
        });
      },
      child: Text(
        text,
        style: TextStyle(
          color: _selectedFilter == value ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}