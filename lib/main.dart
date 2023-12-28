import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suitmedia/ui/first_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: const Color(0xFF2B637B),
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const FirstScreen(),
      },
    );
  }
}
