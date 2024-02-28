import 'package:clapsies/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const Clapsies());
}

class Clapsies extends StatelessWidget {
  const Clapsies({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFFF9AB00), brightness: Brightness.light),
          useMaterial3: true,
          fontFamily: GoogleFonts.poppins.call().fontFamily),
      darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFFF9AB00), brightness: Brightness.dark),
          useMaterial3: true,
          fontFamily: GoogleFonts.poppins.call().fontFamily),
      home: const HomeScreen(),
    );
  }
}
