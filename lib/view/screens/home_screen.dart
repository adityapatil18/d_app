import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';
import 'package:d_app/utils/constant.dart';
import 'package:d_app/view/custom_widgets/custom_container.dart';
import 'package:d_app/view/custom_widgets/text_widget.dart';
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
              CustomContainer(
                  imagePath: 'images/1.png',
                  text: 'Add Entry',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SerachScreen(),
                        ));
                  }),
              SizedBox(
                width: 20,
              ),
              CustomContainer(
                  imagePath: 'images/2.png',
                  text: 'Search by Name',
                  onTap: () {})
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomContainer(
                  imagePath: 'images/3.png',
                  text: 'Search by Date',
                  onTap: () {}),
              SizedBox(
                width: 20,
              ),
              CustomContainer(
                  imagePath: 'images/4.png', text: 'List All', onTap: () {})
            ],
          ),
          SizedBox(
            height: 100,
          ),
          GestureDetector(
            child: Image.asset(
              'images/power.png',
              height: 152,
              width: 152,
            ),
            onTap: () {
              showUninstallConfirmationDialog(context);
            },
          )
        ],
      ),
    );
  }

  Future<void> showUninstallConfirmationDialog(BuildContext context) async {
    final bool confirmUninstall = await showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text("Uninstall App"),
          content: const Text("Are you sure you want to uninstall this app?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(false);
              },
              child: const Text("No"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(true);
              },
              child: const Text("Yes"),
            ),
          ],
        );
      },
    );

    if (confirmUninstall == true) {
      final packageName =
          'com.example.d_app'; // Replace with your app's package name
      final intent = AndroidIntent(
        action: 'android.intent.action.DELETE',
        data: 'package:$packageName',
        package: packageName,
        flags: <int>[Flag.FLAG_ACTIVITY_NEW_TASK],
      );
      await intent.launch();
    }
  }
}
