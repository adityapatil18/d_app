import 'dart:convert';
import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';
import 'package:d_app/view/screens/home_screen.dart';
import 'package:http/http.dart' as http;

import 'package:d_app/utils/constant.dart';
import 'package:d_app/view/custom_widgets/custom_gradientButton.dart';
import 'package:d_app/view/custom_widgets/dateSelection_container.dart';
import 'package:d_app/view/custom_widgets/text_widget.dart';
import 'package:d_app/view/screens/given_entry_screen.dart';
import 'package:d_app/view/screens/recieved_entry_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../model/date_model.dart';

class AddEntryScreen extends StatefulWidget {
  const AddEntryScreen({Key? key}) : super(key: key);

  @override
  _AddEntryScreenState createState() => _AddEntryScreenState();
}

class _AddEntryScreenState extends State<AddEntryScreen> {
  String openingBalance = '';
  String closingBalance = '';
  List<Datum> allData = []; // Create a list to store transaction data
  Date? date1;

  @override
  void initState() {
    super.initState();
    fetchDatafordate(DateTime
        .now()); // Fetch opening and closing balances for the current date
  }

  String selectedDate = DateFormat('dd/MM/yy').format(DateTime.now());
  final TextStyle customTextStyle = const TextStyle(
    color: MyAppColor.mainBlueColor, // Set the text color to #2C1BEF
    fontWeight: FontWeight.bold, // Customize the font weight
  );

  Future<void> fetchDatafordate(DateTime selectedDate) async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://appapi.techgigs.in/api/transaction/getall?date=$selectedDate'),
      );
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final date = Date.fromJson(jsonData);

        // Assuming the API response structure has opening and closing balance data

        // Update the UI with both balances and transaction data
        setState(() {
          openingBalance = date.total.openingBalance;
          closingBalance = date.total.closingBalance;

          date1 = dateFromJson(jsonEncode(jsonData));
        });
      } else {
        // Handle the error when the API request fails
        print('Failed to fetch data.');
      }
    } catch (error) {
      // Handle any exceptions that occur during the API request
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ));
              },
              icon: Image.asset(
                'images/back_arrow.png',
              )),
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
          title: CustomDateSelectionContainer(
              textColor: MyAppColor.mainBlueColor,
              iconColor: MyAppColor.mainBlueColor)),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            "$openingBalance",
                            style: const TextStyle(
                                color: MyAppColor.redColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                          const TextWidget(
                              text: 'Opening Balance',
                              textcolor: MyAppColor.textClor,
                              textsize: 12,
                              textweight: FontWeight.w600)
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          showUninstallConfirmationDialog(context);
                        },
                        child: Image.asset(
                          'images/power.png',
                          width: 53,
                          height: 53,
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            "$closingBalance",
                            style: const TextStyle(
                                color: MyAppColor.redColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                          const TextWidget(
                              text: 'Closing Balance',
                              textcolor: MyAppColor.textClor,
                              textsize: 12,
                              textweight: FontWeight.w600),
                        ],
                      ),
                    ],
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
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      // shrinkWrap: true,
                      itemCount: date1?.data.length ?? 0,
                      itemBuilder: (context, index) {
                        final transactionItem = date1!.data[index];
                        final transactionType = transactionItem.trnxType;
                        final amount = transactionItem.amount;
                        final remark = transactionItem.remark;

                        final name = transactionItem.userDetail[0].firstName +
                            " " +
                            transactionItem.userDetail[0].lastName;

                        return Container(
                          height: 50,
                          width: MediaQuery.sizeOf(context).width,
                          color: index.isEven
                              ? MyAppColor.grey2Color
                              : Colors.white,
                          child: Row(
                            children: [
                              Expanded(
                                // flex: 1,
                                child: Container(
                                  alignment: Alignment.center,
                                  width:
                                      MediaQuery.sizeOf(context).width * 0.25,
                                  child: TextWidget(
                                      text: selectedDate,
                                      textcolor: MyAppColor.textClor,
                                      textsize: 10,
                                      textweight: FontWeight.w700),
                                ),
                              ),
                              const VerticalDivider(
                                color: Colors.black,
                                thickness: 1,
                                // width: 10,
                              ),
                              Expanded(
                                // flex: 1,
                                child: Container(
                                  alignment: Alignment.center,
                                  width:
                                      MediaQuery.sizeOf(context).width * 0.25,
                                  child: TextWidget(
                                      text: name,
                                      textcolor: MyAppColor.textClor,
                                      textsize: 12,
                                      textweight: FontWeight.w600),
                                ),
                              ),
                              const VerticalDivider(
                                color: Colors.black,
                                thickness: 1,
                              ),
                              Expanded(
                                // flex: 1,
                                child: Container(
                                  alignment: Alignment.center,
                                  width:
                                      MediaQuery.sizeOf(context).width * 0.25,
                                  child: TextWidget(
                                      text:
                                          "$remark-(${transactionItem.adminDetail[0].identity})",
                                      textcolor: MyAppColor.textClor,
                                      textsize: 12,
                                      textweight: FontWeight.w600),
                                ),
                              ),
                              const VerticalDivider(
                                color: Colors.black,
                                thickness: 1,
                              ),
                              Expanded(
                                // flex: 1,
                                child: Container(
                                  alignment: Alignment.center,
                                  width:
                                      MediaQuery.sizeOf(context).width * 0.25,
                                  child: TextWidget(
                                      text: transactionType == "credit"
                                          ? amount
                                          : '',
                                      textcolor: MyAppColor.greenColor,
                                      textsize: 12,
                                      textweight: FontWeight.w600),
                                ),
                              ),
                              const VerticalDivider(
                                color: Colors.black,
                                thickness: 1,
                              ),
                              Expanded(
                                // flex: 1,
                                child: Container(
                                  alignment: Alignment.center,
                                  width:
                                      MediaQuery.sizeOf(context).width * 0.25,
                                  child: TextWidget(
                                      text: transactionType == 'debit'
                                          ? amount
                                          : '',
                                      textcolor: MyAppColor.redColor,
                                      textsize: 12,
                                      textweight: FontWeight.w600),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
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
