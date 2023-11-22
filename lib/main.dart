import 'package:d_app/view/screens/home_screen.dart';
import 'package:d_app/view/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'utils/shared_functions.dart';

SharedPreferences? _sharedPreferences;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String? userId = await SharedPreferencesHelper.getUserId();

  runApp(DAPP(isLoggedIn: userId != null && userId.isNotEmpty));
}

class DAPP extends StatelessWidget {
  final bool isLoggedIn;

  const DAPP({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          appBarTheme: AppBarTheme(elevation: 0, color: Colors.white),
          textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme)),
      home: isLoggedIn ? SignupScreen() : HomeScreen(),
    );
  }
}
