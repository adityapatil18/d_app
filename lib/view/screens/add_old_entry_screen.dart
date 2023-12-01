import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import the intl package

import '../../utils/constant.dart';
import '../custom_widgets/custom_gradientButton.dart';
import '../custom_widgets/dateSelection_container.dart';
import '../custom_widgets/text_widget.dart';
import 'given_entry_screen.dart';
import 'home_screen.dart';
import 'recieved_entry_screen.dart';

class AddOldEntryScreen extends StatefulWidget {
  const AddOldEntryScreen({Key? key}) : super(key: key);

  @override
  State<AddOldEntryScreen> createState() => _AddOldEntryScreenState();
}

class _AddOldEntryScreenState extends State<AddOldEntryScreen> {
  late DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ),
            );
          },
          icon: Image.asset(
            'images/back_arrow.png',
          ),
        ),
        leadingWidth: 50,
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: IconButton(
              onPressed: () {},
              icon: Image.asset('images/forward_arrow.png', width: 40),
            ),
          ),
        ],
        backgroundColor: Colors.white,
        centerTitle: true,
        title: ElevatedButton(
          onPressed: () async {
            final DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: selectedDate,
              firstDate: DateTime(2000),
              lastDate: DateTime(2101),
            );

            if (pickedDate != null && pickedDate != selectedDate) {
              setState(() {
                selectedDate = pickedDate;
              });
            }
          },
          child: Text(
            ' ${DateFormat('yyyy-MM-dd').format(selectedDate)}', // Format the date
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {
                showUninstallConfirmationDialog(context);
              },
              child: Center(
                child: Image.asset(
                  'images/power.png',
                  width: 53,
                  height: 53,
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              height: 50,
              width: MediaQuery.sizeOf(context).width,
              color: Colors.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    // flex: 1,
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.sizeOf(context).width * 0.25,
                      child: const TextWidget(
                          text: 'Date',
                          textcolor: Colors.white,
                          textsize: 12,
                          textweight: FontWeight.w600),
                    ),
                  ),
                  // VerticalDivider(
                  //   thickness: 1,
                  //   color: Colors.white,
                  // ),
                  Expanded(
                    // flex: 1,
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.sizeOf(context).width * 0.25,
                      child: const TextWidget(
                          text: 'Name',
                          textcolor: Colors.white,
                          textsize: 12,
                          textweight: FontWeight.w600),
                    ),
                  ),
                  Expanded(
                    // flex: 1,
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.sizeOf(context).width * 0.25,
                      child: const TextWidget(
                          text: 'Remark',
                          textcolor: Colors.white,
                          textsize: 12,
                          textweight: FontWeight.w600),
                    ),
                  ),
                  Expanded(
                    // flex: 1,
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.sizeOf(context).width * 0.25,
                      child: const TextWidget(
                          text: 'Received',
                          textcolor: Colors.white,
                          textsize: 12,
                          textweight: FontWeight.w600),
                    ),
                  ),
                  Expanded(
                    // flex: 1,
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.sizeOf(context).width * 0.25,
                      child: const TextWidget(
                          text: 'Given',
                          textcolor: Colors.white,
                          textsize: 12,
                          textweight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 119,
        width: MediaQuery.sizeOf(context).width,
        color: MyAppColor.bottomContainerColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CustomGradientButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RecivedEntryScreen()));
              },
              buttonText: 'Received',
              containerColor: Color(0xFFF0D963),
              gradientColors: [Color(0xFF1F9540), Color(0xFF61CC7F)],
            ),
            CustomGradientButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GivenEntryScreen()));
              },
              buttonText: 'Given',
              containerColor: Color(0xFFF0D963),
              gradientColors: [Color(0xFFD60000), Color(0xFFFF6E05)],
            )
          ],
        ),
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
