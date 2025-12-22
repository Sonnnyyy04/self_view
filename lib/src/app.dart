import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selfview_app/src/pages/discover/discover.dart';
import 'package:selfview_app/src/pages/ootd/ootd.dart';
import 'package:selfview_app/src/pages/trend/trend.dart';
import 'package:selfview_app/src/pages/try_it_on/try_it_on.dart';
import 'package:selfview_app/src/widgets/custom_appbar.dart';
import 'package:selfview_app/src/widgets/custom_frostedBottomNavBar.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme:GoogleFonts.robotoTextTheme(
          TextTheme(
            titleMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
            displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            displayMedium: TextStyle(fontSize: 28),
          )
        ),
        scaffoldBackgroundColor: Color(0xE5FFFFFF),
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.white,
          toolbarHeight: 64,
          titleSpacing: 0.0,
          titleTextStyle: GoogleFonts.roboto(
            fontSize: 25,
            fontWeight: FontWeight.w700,
            color: Color(0xFF2D6CDF),
          ),
        ),
      ),
      home: const AppShell(),
    );
  }
}