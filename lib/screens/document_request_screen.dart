import 'package:flutter/material.dart';

class DocumentRequestScreen extends StatefulWidget {
  const DocumentRequestScreen({super.key});

  @override
  State<DocumentRequestScreen> createState() => _DocumentRequestScreenState();
}

class _DocumentRequestScreenState extends State<DocumentRequestScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String? _selectedDocumentType;
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isDropdownOpen = false;

  final List<String> _documentTypes = [
    'شهادة إقامة',
    'شهادة ميلاد',
    'مستند رسمي آخر',
    'تصريح عمل',
    'وثيقة هوية',
    'إفادة رسمية',
    'تأييد إقامة',
    'شهادة عدم محكومية',
    'وكالة رسمية',
    'تصريح سفر'
  ];

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _removeDropdown();
    super.dispose();
  }

  void _removeDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    _isDropdownOpen = false;
  }

  void _showDropdown() {
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, size.height + 5),
          child: Material(
            elevation: 4,
            child: Container(
              constraints: BoxConstraints(
                maxHeight: 200,
              ),
              child: ListView(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                children: _documentTypes.map((String value) {
                  return ListTile(
                    title: Text(value, textAlign: TextAlign.right),
                    onTap: () {
                      setState(() {
                        _selectedDocumentType = value;
                        _removeDropdown();
                      });
                    },
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
    _isDropdownOpen = true;
  }

  void _toggleDropdown() {
    if (_isDropdownOpen) {
      _removeDropdown();
    } else {
      _showDropdown();
    }
  }

  void _submitRequest() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('تم تقديم الطلب'),
          content: const Text('تم تقديم طلبك بنجاح'),
          actions: [
            TextButton(
              child: const Text('حسناً'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: const Color(0xFFE8F5E9),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'تقديم الطلب',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'يرجى التأكد من توفر جميع المستندات المطلوبة للمعاملة الرسمية التي يتم تقديم الطلب بشأنها',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color.fromARGB(255, 215, 82, 82),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: _fullNameController,
                decoration: const InputDecoration(
                  labelText: '* الاسم الكامل',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء إدخال الاسم الكامل';
                  }
                  return null;
                },
                textAlign: TextAlign.right,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: '* رقم الهاتف',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء إدخال رقم الهاتف';
                  }
                  return null;
                },
                textAlign: TextAlign.right,
              ),
              const SizedBox(height: 20),
              CompositedTransformTarget(
                link: _layerLink,
                child: GestureDetector(
                  onTap: _toggleDropdown,
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      labelText: '* نوعية المستند',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    ),
                    isEmpty: _selectedDocumentType == null,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _selectedDocumentType ?? 'اختر نوع المستند',
                          textAlign: TextAlign.right,
                        ),
                        Icon(
                          _isDropdownOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF075E54),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: _submitRequest,
                  child: const Text(
                    'قدم الطلب',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}