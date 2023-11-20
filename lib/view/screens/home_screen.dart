import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';
import 'package:d_app/view/custom_widgets/custom_container.dart';
import 'package:d_app/view/screens/search_date_screen.dart';
import 'package:d_app/view/screens/search_name_screen.dart';
import 'package:d_app/view/screens/add_entry.dart';
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
                  imagePath: 'images/add_entry4.png',
                  text: 'Add Entry',
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.red),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddEntryScreen(),
                        ));
                  }),
              SizedBox(
                width: 40,
              ),
              CustomContainer(
                  borderRadius: BorderRadius.circular(15),
                  imagePath: 'images/search.png',
                  text: 'Search by Name',
                  border: Border.all(color: Colors.red),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SearchNameScreen(),
                        ));
                  })
            ],
          ),
          SizedBox(
            height: 40,
          ),
          CustomContainer(
              borderRadius: BorderRadius.circular(15),
              imagePath: 'images/search_date.png',
              text: 'Search by Date',
              border: Border.all(color: Colors.red),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchDateScreen(),
                    ));
              }),
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
