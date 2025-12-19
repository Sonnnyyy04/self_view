import 'package:flutter/material.dart';
import 'package:selfview_app/app/app_shell.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selfview_app/pages/widget/custom_frostedBottomNavBar.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFDADEE1),
        textTheme: GoogleFonts.playfairDisplayTextTheme(),
        //useMaterial3: true,
        appBarTheme: AppBarTheme(
          elevation: 1.0,
          backgroundColor: Color(0xFFF6F8FC),
          toolbarHeight: 64,
          titleSpacing: 16,
          titleTextStyle: GoogleFonts.playfairDisplay(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Color(0xFF2D6CDF),
          ),
        ),
      ),
      home: const AppShell(),
    );
  }
}
