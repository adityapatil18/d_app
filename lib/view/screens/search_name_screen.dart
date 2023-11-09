import 'dart:convert';

import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../../model/all_data.dart';
import '../../model/transaction_by_user_model.dart';
import '../../utils/constant.dart';
import '../custom_widgets/text_widget.dart';

class SearchNameScreen extends StatefulWidget {
  const SearchNameScreen({super.key});

  @override
  State<SearchNameScreen> createState() => _SearchNameScreenState();
}

class _SearchNameScreenState extends State<SearchNameScreen> {
  TextEditingController _searchNameController = TextEditingController();
  List<Datum> allData = []; // List of data obtained from API
  List<Datum> searchResults = [];
  String selectedUserId = ''; // Variable to hold the selected user's ID
  String selectedName = ""; // Store the selected name
  Transaction? transaction;

  @override
  void initState() {
    super.initState();
    fetchData(""); // Fetch data from the API when the screen loads
  }

  Future<void> fetchData(String name) async {
    final response = await http.get(
      Uri.parse(
          'https://appapi.techgigs.in/api/user/list?userName=$name'), // Replace with the actual API endpoint
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final allDataList =
          List<Datum>.from(jsonData['data'].map((x) => Datum.fromJson(x)));
      setState(() {
        allData = allDataList;
      });
    } else {
      throw Exception('Failed to fetch data.');
    }
  }

  Future<void> fetchTransactionsForUser(String userId) async {
    final response = await http.post(
      Uri.parse('https://appapi.techgigs.in/api/transaction/getbyuser'),
      body: {
        'userId': userId,
      },
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      setState(() {
        transaction = transactionFromJson(jsonEncode(jsonData));
      });
    } else {
      throw Exception('Failed to fetch transaction data.');
    }
  }

  List<Datum> searchNames(String query) {
    query = query.toLowerCase();
    List<Datum> matchingNames = [];

    for (Datum datum in allData) {
      String fullName = datum.fullName.toLowerCase();
      if (fullName.contains(query)) {
        matchingNames.add(datum);
      }
    }

    return matchingNames;
  }

  // void selectName(String fullName, String userId) {
  //   print('Selecting Name: $fullName'); // Add this line to check

  //   setState(() {
  //     _searchNameController.text = fullName;
  //     selectedName = fullName; // Set the selected name
  //     print('Selected Name: $selectedName'); // Add this line to check
  //     searchResults.clear();

  //     selectedUserId = userId;
  //     // fetchTransactionsForUser(userId);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Image.asset(
                'images/back_arrow.png',
              )),
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
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Stack(
            children: [
              Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                        hintText: 'Search by name',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                    controller: _searchNameController,
                    keyboardType: TextInputType.text,
                    inputFormatters: [
                      FilteringTextInputFormatter.singleLineFormatter
                    ],
                    onChanged: (query) {
                      setState(() {
                        searchResults = searchNames(query);
                      });
                    },
                  ),
                  SizedBox(
                    height: 30,
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
                  if (searchResults.isNotEmpty)
                    Container(
                      height: MediaQuery.sizeOf(context).height * 0.25,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: searchResults.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            textColor: Colors.black,
                            tileColor: index.isEven
                                ? MyAppColor.grey2Color
                                : Colors.white,
                            title: Text(searchResults[index].fullName),
                            onTap: () {
                              // Handle the selection of the name here

                              // Clear the search results and hide the ListView
                              setState(() {
                                _searchNameController.text =
                                    searchResults[index].fullName;
                                selectedName = searchResults[index].firstName;
                                selectedUserId = searchResults[index].id;
                                fetchTransactionsForUser(selectedUserId);
                                searchResults.clear();
                              });
                            },
                          );
                        },
                      ),
                    ),
                  Expanded(
                    child: ListView.builder(
                      // shrinkWrap: true,

                      itemCount: transaction?.data.length ?? 0,
                      itemBuilder: (context, index) {
                        final transactionItem = transaction!.data[index];
                        final date = transactionItem.createdAt
                            .toString()
                            .substring(0, 10);
                        final transactionType = transactionItem.trnxType;
                        final amount = transactionItem.amount;

                        return Container(
                          height: 50,
                          width: MediaQuery.sizeOf(context).width,
                          color: index.isEven
                              ? MyAppColor.grey2Color
                              : Colors.white,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.center,
                                  width:
                                      MediaQuery.sizeOf(context).width * 0.25,
                                  child: TextWidget(
                                      text: '${date}',
                                      textcolor: MyAppColor.textClor,
                                      textsize: 12,
                                      textweight: FontWeight.w600),
                                ),
                              ),
                              const VerticalDivider(
                                color: Colors.black,
                                thickness: 1,
                                // width: 10,
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.center,
                                  width:
                                      MediaQuery.sizeOf(context).width * 0.25,
                                  child: TextWidget(
                                      text: selectedName,
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
                                flex: 1,
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
                                flex: 1,
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
            ],
          ),
        ),
        bottomNavigationBar: Row(
          children: [
            Container(
              alignment: Alignment.center,
              color: MyAppColor.yellowColor,
              width: MediaQuery.sizeOf(context).width / 2.01,
              height: 60,
              child: TextWidget(
                  text:
                      "Total Received: ${transaction?.total.totalReceived ?? 0}",
                  textcolor: MyAppColor.textClor,
                  textsize: 13,
                  textweight: FontWeight.w600),
            ),
            Container(
              width: 1,
              height: 60,
              color: Colors.black,
            ),
            Container(
              alignment: Alignment.center,
              color: MyAppColor.yellowColor,
              width: MediaQuery.sizeOf(context).width / 2.01,
              height: 60,
              child: TextWidget(
                  text: "Total Given: ${transaction?.total.totalGiven ?? 0}",
                  textcolor: MyAppColor.textClor,
                  textsize: 13,
                  textweight: FontWeight.w600),
            ),
          ],
        )
        // Container(
        //   height: 60,
        //   color: MyAppColor.yellowColor,
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceAround,
        //     children: [
        //       Container(
        //         width: MediaQuery.sizeOf(context).width / 2,
        //         child: Row(
        //           children: [
        //             const TextWidget(
        //                 text: 'Total \nReceived',
        //                 textcolor: MyAppColor.textClor,
        //                 textsize: 13,
        //                 textweight: FontWeight.w600),
        //             SizedBox(
        //               width: 20,
        //             ),
        //             TextWidget(
        //                 text: ' ${transaction?.total.totalReceived ?? 0}',
        //                 textcolor: MyAppColor.textClor,
        //                 textsize: 14,
        //                 textweight: FontWeight.w800)
        //           ],
        //         ),
        //       ),

        //       Container(
        //         width: MediaQuery.sizeOf(context).width / 2,
        //         child: Row(
        //           children: [
        //             const TextWidget(
        //                 text: 'Total \nGiven',
        //                 textcolor: MyAppColor.textClor,
        //                 textsize: 13,
        //                 textweight: FontWeight.w600),
        //             SizedBox(
        //               width: 20,
        //             ),
        //             TextWidget(
        //                 text: '${transaction?.total.totalGiven ?? 0}',
        //                 textcolor: MyAppColor.textClor,
        //                 textsize: 14,
        //                 textweight: FontWeight.w800)
        //           ],
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
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
