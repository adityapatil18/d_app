import 'dart:convert';
import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../model/date_model.dart';
import '../../model/get_all_data.dart'; // Ensure that this import is correct
import '../../utils/constant.dart';
import '../custom_widgets/text_widget.dart';

class SearchDateScreen extends StatefulWidget {
  const SearchDateScreen({Key? key}) : super(key: key);

  @override
  State<SearchDateScreen> createState() => _SearchDateScreenState();
}

class _SearchDateScreenState extends State<SearchDateScreen> {
  String buttonText = 'Choose Date';
  DateTime? selectedDate;
  List<Dataitem> transactions = [];
  Transaction? transaction;
  Date? date1;

  Future<List<Dataitem>> _fetchTransactionsByDate(DateTime date) async {
    // Replace this URL with your actual API endpoint
    final apiUrl =
        'https://appapi.techgigs.in/api/transaction/getall?date=$date';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        date1 = dateFromJson(jsonEncode(jsonData));
        final transactions = List<Dataitem>.from(
            jsonData['data'].map((x) => Dataitem.fromJson(x)));

        return transactions;
      } else {
        throw Exception('Failed to fetch transactions');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }

  void _searchTransactionsByDate() async {
    if (selectedDate != null) {
      try {
        List<Dataitem> filteredTransactions =
            await _fetchTransactionsByDate(selectedDate!);

        setState(() {
          transactions = filteredTransactions;
        });
      } catch (error) {
        print("Error fetching transactions: $error");
      }
    } else {
      print("No date selected");
    }
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

  // Helper method to remove 'r' suffix and 'Rupees' symbol
  String removeCrSuffixAndRupeesSymbol(String value) {
    // Remove 'r' suffix
    value = value.replaceAll('r', '');

    // Remove 'Rupees' symbol
    value = value.replaceAll('₹', '');

    return value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image.asset('images/back_arrow.png'),
        ),
        leadingWidth: 50,
        centerTitle: true,
        title: InkWell(
          onTap: () {
            showUninstallConfirmationDialog(context);
          },
          child: Image.asset(
            'images/power.png',
            width: 40,
            height: 40,
          ),
        ),
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
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            children: [
              ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(MyAppColor.greyColor)),
                onPressed: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      selectedDate = pickedDate;
                      buttonText =
                          DateFormat('yyyy-MM-dd').format(selectedDate!);
                    });
                    _searchTransactionsByDate();
                    print("Selected date: $pickedDate");
                  }
                },
                child: TextWidget(
                    text: buttonText,
                    textcolor: MyAppColor.mainBlueColor,
                    textsize: 16,
                    textweight: FontWeight.w700),
              ),
              SizedBox(height: 30),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                color: Colors.black,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: const TextWidget(
                          text: 'Date',
                          textcolor: Colors.white,
                          textsize: 12,
                          textweight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: const TextWidget(
                          text: 'Name',
                          textcolor: Colors.white,
                          textsize: 12,
                          textweight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: const TextWidget(
                          text: 'Remark',
                          textcolor: Colors.white,
                          textsize: 12,
                          textweight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: const TextWidget(
                          text: 'Received',
                          textcolor: Colors.white,
                          textsize: 12,
                          textweight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: const TextWidget(
                          text: 'Given',
                          textcolor: Colors.white,
                          textsize: 12,
                          textweight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: transactions.isEmpty
                    ? const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextWidget(
                              text:
                                  'No data for selected date. Select another date',
                              textcolor: MyAppColor.textClor,
                              textsize: 14,
                              textweight: FontWeight.w600),
                        ],
                      )
                    : ListView.builder(
                        itemCount: transactions.length,
                        itemBuilder: (context, index) {
                          // final transactionItem = transactions[index];
                          final transactionItem = date1!.data[index];

                          final transactionType = transactionItem.trnxType;
                          final amount = removeCrSuffixAndRupeesSymbol(
                              transactionItem.amount);
                          final remark = transactionItem.remark;
                          final name = transactionItem.userDetail[0].firstName +
                              " " +
                              transactionItem.userDetail[0].lastName;
                          return Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            color: index.isEven
                                ? MyAppColor.grey2Color
                                : Colors.white,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: MediaQuery.of(context).size.width *
                                        0.30,
                                    child: TextWidget(
                                      text: DateFormat('yyyy-MM-dd')
                                          .format(transactionItem.trnxDate),
                                      textcolor: MyAppColor.textClor,
                                      textsize: 10,
                                      textweight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                const VerticalDivider(
                                  color: Colors.black,
                                  thickness: 1,
                                ),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: MediaQuery.of(context).size.width *
                                        0.25,
                                    child: TextWidget(
                                      // Replace 'Name' with the actual property you want to display
                                      // text: transactionItem.userDetail[0].firstName,
                                      text: name,
                                      textcolor: MyAppColor.textClor,
                                      textsize: 12,
                                      textweight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                const VerticalDivider(
                                  color: Colors.black,
                                  thickness: 1,
                                ),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: MediaQuery.of(context).size.width *
                                        0.25,
                                    child: TextWidget(
                                      // Replace 'Name' with the actual property you want to display
                                      // text: transactionItem.userDetail[0].firstName,
                                      text:
                                          "$remark-(${transactionItem.adminDetail[0].identity})",
                                      textcolor: MyAppColor.textClor,
                                      textsize: 12,
                                      textweight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                const VerticalDivider(
                                  color: Colors.black,
                                  thickness: 1,
                                ),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: MediaQuery.of(context).size.width *
                                        0.25,
                                    child: TextWidget(
                                      // Replace 'Received' with the actual property you want to display
                                      text: transactionType == "credit"
                                          ? amount
                                          : '',
                                      textcolor: MyAppColor.greenColor,
                                      textsize: 12,
                                      textweight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                const VerticalDivider(
                                  color: Colors.black,
                                  thickness: 1,
                                ),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: MediaQuery.of(context).size.width *
                                        0.25,
                                    child: TextWidget(
                                      // Replace 'Given' with the actual property you want to display
                                      text: transactionType == 'debit'
                                          ? amount
                                          : '',
                                      textcolor: MyAppColor.redColor,
                                      textsize: 12,
                                      textweight: FontWeight.w600,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
