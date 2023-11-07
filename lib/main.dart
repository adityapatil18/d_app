import 'package:d_app/view/screens/search_name_screen.dart';
import 'package:d_app/view/screens/search_screen.dart';
import 'package:d_app/view/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? _sharedPreferences;

void main() {
  runApp(DAPP());
}

class DAPP extends StatelessWidget {
  const DAPP({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          appBarTheme: AppBarTheme(elevation: 0, color: Colors.white),
          textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme)),
      home: SearchNameScreen(),
    );
  }
}
