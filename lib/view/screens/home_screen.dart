import 'package:d_app/utils/constant.dart';
import 'package:d_app/view/screens/search_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                child: Container(
                  width: 131,
                  height: 115,
                  color: MyAppColor.greyColor,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SerachScreen(),
                      ));
                },
              ),
              SizedBox(
                width: 20,
              ),
              Container(
                width: 131,
                height: 115,
                color: MyAppColor.greyColor,
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 131,
                height: 115,
                color: MyAppColor.greyColor,
              ),
              SizedBox(
                width: 20,
              ),
              Container(
                width: 131,
                height: 115,
                color: MyAppColor.greyColor,
              ),
            ],
          ),
          SizedBox(
            height: 90,
          ),
          Image.asset(
            'images/power.png',
            height: 152,
            width: 152,
          )
        ],
      ),
    );
  }
}
