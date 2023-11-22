import 'dart:convert';

import 'package:d_app/utils/constant.dart';
import 'package:d_app/view/custom_widgets/text_widget.dart';
import 'package:d_app/view/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../utils/shared_functions.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController _userNameController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();
  @override
  void initState() {
    super.initState();
    checkAndNavigate();
  }

  Future<void> checkAndNavigate() async {
    String? userId = await SharedPreferencesHelper.getUserId();
    if (userId != null && userId.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
    }
  }

  Future<void> login(String email, String password) async {
    try {
      Response response = await post(
        Uri.parse('https://appapi.techgigs.in/api/admin/login'),
        body: {"email": email, "password": password},
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print('API response: ${response.body}');
        print(data['data']['_id']);

        print(data);
        final userId = data['data']['_id']; // Corrected

        // Save the user ID in SharedPreferences when login is successful
        await SharedPreferencesHelper.saveUserId(userId);
        await SharedPreferencesHelper.saveLoginState(true);
        await checkAndNavigate();

        print('User ID: $userId');
        print('Login successfully');
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => HomeScreen(),
        //   ),
        // );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Login failed. Please check your credentials.')),
        );
        print('Failed');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred. Please try again later.')),
      );
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    print('SignupScreen build called');

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(
                height: 60,
              ),
              Image.asset(
                'images/img.png',
                width: 218,
                height: 234,
                fit: BoxFit.contain,
              ),
              SizedBox(
                height: 30,
              ),
              const TextWidget(
                  text: 'Sign In',
                  textcolor: MyAppColor.mainblackColor,
                  textsize: 24,
                  textweight: FontWeight.w600),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: _userNameController,
                decoration: InputDecoration(
                  hintText: 'Username',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(hintText: 'Password'),
              ),
              SizedBox(
                height: 50,
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32))),
                      minimumSize: MaterialStateProperty.all(Size(312, 50)),
                      backgroundColor: MaterialStateProperty.all(
                          MyAppColor.loginButtonColor)),
                  onPressed: () {
                    final email = _userNameController.text.toString();
                    final password = _passwordController.text.toString();

                    if (email.isNotEmpty && password.isNotEmpty) {
                      setState(() {
                        login(email, password);
                      });
                    } else {
                      // Show an error message if fields are empty
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please fill in both fields.')),
                      );
                    }
                  },
                  child: const TextWidget(
                      text: 'LOGIN',
                      textcolor: MyAppColor.mainblackColor,
                      textsize: 14,
                      textweight: FontWeight.w500))
            ],
          ),
        ),
      ),
    );
  }
}
