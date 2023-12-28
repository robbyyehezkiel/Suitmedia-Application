import 'package:flutter/material.dart';
import 'package:suitmedia/ui/second_screen.dart';
import 'package:suitmedia/utils/alert_dialog.dart';
import 'package:suitmedia/utils/constants.dart';
import 'package:suitmedia/utils/utility.dart';
import 'package:logger/logger.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final Logger _logger = Logger();
  late TextEditingController _nameController;
  late TextEditingController _palindromeController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _palindromeController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _palindromeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(232, 70, 157, 173),
              Color(0xFF8E96AD),
              Color.fromARGB(195, 0, 109, 172),
            ],
          ),
        ),
        padding: const EdgeInsets.all(kSpacing16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildCircleAvatar(),
            const SizedBox(height: kSpacing64),
            _buildTextField(_nameController, 'Name'),
            const SizedBox(height: kSpacing16),
            _buildTextField(_palindromeController, 'Palindrome'),
            const SizedBox(height: kSpacing32),
            _buildButton(onPressed: _handleCheckPress, label: 'CHECK'),
            _buildButton(onPressed: _handleNextPress, label: 'NEXT'),
          ],
        ),
      ),
    );
  }

  Widget _buildCircleAvatar() {
    return Container(
      width: 116,
      height: 116,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFF93C7CD),
      ),
      padding: const EdgeInsets.all(8.0),
      child: const Icon(
        Icons.person_add_alt_1_sharp,
        size: 40.0,
        color: Colors.white,
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText) {
    String hint = controller.text.isEmpty ? labelText : '';

    const TextStyle inputTextStyle = TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
    );

    return TextField(
      controller: controller,
      style: inputTextStyle.copyWith(color: Colors.black),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: inputTextStyle.copyWith(color: Colors.grey),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildButton(
      {required VoidCallback onPressed, required String label}) {
    return buildButton(context: context, onPressed: onPressed, label: label);
  }

  void _handleCheckPress() {
    _logger.d('CHECK Pressed');
    String inputText = _palindromeController.text;

    if (inputText.trim().isEmpty) {
      _showDialog(kPalindromeWarningTitle, kPalindromeWarningMessage);
    } else {
      _showDialog(
        kPalindromeCheckResultTitle,
        isPalindrome(inputText)
            ? kPalindromeMessagePalindrome
            : kPalindromeMessageNotPalindrome,
      );
    }
  }

  void _handleNextPress() {
    _logger.d('NEXT Pressed');
    String name = _nameController.text;

    if (name.trim().isEmpty) {
      _showDialog(kNameWarningTitle, kNameWarningMessage);
    } else {
      _navigateToSecondScreen(name);
    }
  }

  void _navigateToSecondScreen(String userName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SecondScreen(userName: userName),
      ),
    ).catchError((error) {
      _logger.e('Navigation error: $error');
    });
  }

  void _showDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(title: title, message: message);
      },
    );
  }
}
