import 'package:d_app/view/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';


SharedPreferences? _sharedPreferences;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(DAPP());
}

class DAPP extends StatelessWidget {

  const DAPP({super.key, });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          appBarTheme: AppBarTheme(elevation: 0, color: Colors.white),
          textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme)),
      home: SignupScreen(),
    );
  }
}
