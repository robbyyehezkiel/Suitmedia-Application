import 'package:flutter/material.dart';

Widget buildButton({
  required BuildContext context,
  required VoidCallback onPressed,
  required String label,
}) {
  return SizedBox(
    width: double.infinity,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor,
          padding: const EdgeInsets.all(16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ),
  );
}

bool isPalindrome(String text) {
  String cleanText = text.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '');
  String reversedText = cleanText.split('').reversed.join('');
  return cleanText == reversedText;
}
