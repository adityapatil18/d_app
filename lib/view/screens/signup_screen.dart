import 'package:d_app/utils/constant.dart';
import 'package:d_app/view/custom_widgets/text_widget.dart';
import 'package:d_app/view/screens/home_screen.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              ),
              SizedBox(
                height: 30,
              ),
              TextWidget(
                  text: 'Sign In',
                  textcolor: MyAppColor.mainblackColor,
                  textsize: 24,
                  textweight: FontWeight.w600),
              SizedBox(
                height: 10,
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Username',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ));
                  },
                  child: TextWidget(
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
