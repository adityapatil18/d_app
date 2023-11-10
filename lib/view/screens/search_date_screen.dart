// import 'dart:convert';
// import 'package:http/http.dart' as http;

// import 'package:android_intent_plus/android_intent.dart';
// import 'package:android_intent_plus/flag.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// import '../../model/get_all_data.dart';
// import '../../utils/constant.dart';
// import '../custom_widgets/text_widget.dart';

// class SearchDateScreen extends StatefulWidget {
//   const SearchDateScreen({super.key});

//   @override
//   State<SearchDateScreen> createState() => _SearchDateScreenState();
// }

// class _SearchDateScreenState extends State<SearchDateScreen> {
//   TextEditingController _searchDateController = TextEditingController();
//   DateTime? selectedDate;
//   List<Dataitem> transactions = [];

//   Future<List<Dataitem>> _fetchTransactionsByDate(DateTime date) async {
//     try {
//       // Format the date to the desired format for the API request
//       String formattedDate = "${date.year}-${date.month}-${date.day}";

//       // Make the API call
//       final response = await http.get(
//         Uri.parse(
//             'https://appapi.techgigs.in/api/transaction/getall?date=$formattedDate'),
//       );

//       if (response.statusCode == 200) {
//         final jsonData = jsonDecode(response.body);
//         final transactions = List<Dataitem>.from(
//             jsonData['data'].map((x) => Dataitem.fromJson(x)));

//         return transactions;
//       } else {
//         throw Exception('Failed to fetch transactions');
//       }
//     } catch (error) {
//       throw Exception('Error: $error');
//     }
//   }

//   void _searchTransactionsByDate(DateTime? date) async {
//     if (date != null) {
//       try {
//         List<Dataitem> filteredTransactions =
//             await _fetchTransactionsByDate(date);

//         setState(() {
//           transactions = filteredTransactions;
//           selectedDate = date;
//         });
//       } catch (error) {
//         // Handle errors
//         print("Error fetching transactions: $error");
//       }
//     } else {
//       // Handle the case where no date is selected
//       print("No date selected");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           elevation: 0,
//           leading: IconButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               icon: Image.asset(
//                 'images/back_arrow.png',
//               )),
//           leadingWidth: 50,
//           centerTitle: true,
//           title: InkWell(
//             onTap: () {
//               showUninstallConfirmationDialog(context);
//             },
//             child: Image.asset(
//               'images/power.png',
//               width: 40,
//               height: 40,
//             ),
//           ),
//           actions: [
//             Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: IconButton(
//                 onPressed: () {},
//                 icon: Image.asset('images/forward_arrow.png', width: 40),
//               ),
//             ),
//           ],
//           backgroundColor: Colors.white,
//         ),
//         backgroundColor: Colors.white,
//         body: Padding(
//           padding: const EdgeInsets.all(12.0),
//           child: Stack(
//             children: [
//               Column(
//                 children: [
//                   TextField(
//                     decoration: InputDecoration(
//                         hintText: 'Search by date',
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10))),
//                     controller: _searchDateController,
//                     keyboardType: TextInputType.text,
//                     inputFormatters: [
//                       FilteringTextInputFormatter.singleLineFormatter
//                     ],
//                     onChanged: (query) {
//                       setState(() {
//                         // searchResults = searchNames(query);

//                       });
//                     },
//                   ),
//                   SizedBox(
//                     height: 30,
//                   ),
//                   Container(
//                     height: 50,
//                     width: MediaQuery.sizeOf(context).width,
//                     color: Colors.black,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Expanded(
//                           // flex: 1,
//                           child: Container(
//                             alignment: Alignment.center,
//                             width: MediaQuery.sizeOf(context).width * 0.25,
//                             child: const TextWidget(
//                                 text: 'Date',
//                                 textcolor: Colors.white,
//                                 textsize: 12,
//                                 textweight: FontWeight.w600),
//                           ),
//                         ),
//                         // VerticalDivider(
//                         //   thickness: 1,
//                         //   color: Colors.white,
//                         // ),
//                         Expanded(
//                           // flex: 1,
//                           child: Container(
//                             alignment: Alignment.center,
//                             width: MediaQuery.sizeOf(context).width * 0.25,
//                             child: const TextWidget(
//                                 text: 'Name',
//                                 textcolor: Colors.white,
//                                 textsize: 12,
//                                 textweight: FontWeight.w600),
//                           ),
//                         ),
//                         Expanded(
//                           // flex: 1,
//                           child: Container(
//                             alignment: Alignment.center,
//                             width: MediaQuery.sizeOf(context).width * 0.25,
//                             child: const TextWidget(
//                                 text: 'Received',
//                                 textcolor: Colors.white,
//                                 textsize: 12,
//                                 textweight: FontWeight.w600),
//                           ),
//                         ),
//                         Expanded(
//                           // flex: 1,
//                           child: Container(
//                             alignment: Alignment.center,
//                             width: MediaQuery.sizeOf(context).width * 0.25,
//                             child: const TextWidget(
//                                 text: 'Given',
//                                 textcolor: Colors.white,
//                                 textsize: 12,
//                                 textweight: FontWeight.w600),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                   Expanded(
//                     child: ListView.builder(
//                       // shrinkWrap: true,

//                       itemCount: 10,
//                       itemBuilder: (context, index) {
//                         return Container(
//                           height: 50,
//                           width: MediaQuery.sizeOf(context).width,
//                           color: index.isEven
//                               ? MyAppColor.grey2Color
//                               : Colors.white,
//                           child: Row(
//                             children: [
//                               Expanded(
//                                 // flex: 1,
//                                 child: Container(
//                                   alignment: Alignment.center,
//                                   width:
//                                       MediaQuery.sizeOf(context).width * 0.25,
//                                   child: TextWidget(
//                                       text: 'date',
//                                       textcolor: MyAppColor.textClor,
//                                       textsize: 12,
//                                       textweight: FontWeight.w600),
//                                 ),
//                               ),
//                               const VerticalDivider(
//                                 color: Colors.black,
//                                 thickness: 1,
//                                 // width: 10,
//                               ),
//                               Expanded(
//                                 // flex: 1,
//                                 child: Container(
//                                   alignment: Alignment.center,
//                                   width:
//                                       MediaQuery.sizeOf(context).width * 0.25,
//                                   child: TextWidget(
//                                       text: 'name',
//                                       textcolor: MyAppColor.textClor,
//                                       textsize: 14,
//                                       textweight: FontWeight.w600),
//                                 ),
//                               ),
//                               const VerticalDivider(
//                                 color: Colors.black,
//                                 thickness: 1,
//                               ),
//                               Expanded(
//                                 // flex: 1,
//                                 child: Container(
//                                   alignment: Alignment.center,
//                                   width:
//                                       MediaQuery.sizeOf(context).width * 0.25,
//                                   child: TextWidget(
//                                       // text: transactionType == "credit"
//                                       //     ? amount
//                                       //     : '',
//                                       text: '+amount',
//                                       textcolor: MyAppColor.greenColor,
//                                       textsize: 14,
//                                       textweight: FontWeight.w600),
//                                 ),
//                               ),
//                               const VerticalDivider(
//                                 color: Colors.black,
//                                 thickness: 1,
//                               ),
//                               Expanded(
//                                 // flex: 1,
//                                 child: Container(
//                                   alignment: Alignment.center,
//                                   width:
//                                       MediaQuery.sizeOf(context).width * 0.25,
//                                   child: TextWidget(
//                                       // text: transactionType == 'debit'
//                                       //     ? amount
//                                       //     : '',
//                                       text: '-amount',
//                                       textcolor: MyAppColor.redColor,
//                                       textsize: 14,
//                                       textweight: FontWeight.w600),
//                                 ),
//                               )
//                             ],
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ));
//   }

//   Future<void> showUninstallConfirmationDialog(BuildContext context) async {
//     final bool confirmUninstall = await showDialog(
//       context: context,
//       builder: (BuildContext dialogContext) {
//         return AlertDialog(
//           title: const Text("Uninstall App"),
//           content: const Text("Are you sure you want to uninstall this app?"),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(dialogContext).pop(false);
//               },
//               child: const Text("No"),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.of(dialogContext).pop(true);
//               },
//               child: const Text("Yes"),
//             ),
//           ],
//         );
//       },
//     );

//     if (confirmUninstall == true) {
//       final packageName =
//           'com.example.d_app'; // Replace with your app's package name
//       final intent = AndroidIntent(
//         action: 'android.intent.action.DELETE',
//         data: 'package:$packageName',
//         package: packageName,
//         flags: <int>[Flag.FLAG_ACTIVITY_NEW_TASK],
//       );
//       await intent.launch();
//     }
//   }
// }

// search_date_screen.dart

// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:intl/intl.dart';

// import '../../model/get_all_data.dart';
// import '../../utils/constant.dart';
// import '../custom_widgets/text_widget.dart';

// class SearchDateScreen extends StatefulWidget {
//   const SearchDateScreen({Key? key}) : super(key: key);

//   @override
//   State<SearchDateScreen> createState() => _SearchDateScreenState();
// }

// class _SearchDateScreenState extends State<SearchDateScreen> {
//   TextEditingController _searchDateController = TextEditingController();
//   DateTime? selectedDate;
//   List<Dataitem> transactions = [];
//   Transaction? transaction;

//   Future<List<Dataitem>> _fetchTransactionsByDate(DateTime date) async {
//     // Replace this URL with your actual API endpoint
//     final apiUrl = 'https://your-api-endpoint.com/transactions?date=$date';

//     try {
//       final response = await http.get(Uri.parse(apiUrl));
//       if (response.statusCode == 200) {
//         final jsonData = jsonDecode(response.body);
//         final transactions = List<Dataitem>.from(
//             jsonData['data'].map((x) => Dataitem.fromJson(x)));

//         return transactions;
//       } else {
//         throw Exception('Failed to fetch transactions');
//       }
//     } catch (error) {
//       throw Exception('Error: $error');
//     }
//   }

//   void _searchTransactionsByDate(DateTime? date) async {
//     if (date != null) {
//       try {
//         List<Dataitem> filteredTransactions =
//             await _fetchTransactionsByDate(date);

//         setState(() {
//           transactions = filteredTransactions;
//           selectedDate = date;
//         });
//       } catch (error) {
//         print("Error fetching transactions: $error");
//       }
//     } else {
//       print("No date selected");
//     }
//   }

//   Future<void> showUninstallConfirmationDialog(BuildContext context) async {
//     // Your existing code for the uninstall confirmation dialog
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: Image.asset('images/back_arrow.png'),
//         ),
//         leadingWidth: 50,
//         centerTitle: true,
//         title: InkWell(
//           onTap: () {
//             showUninstallConfirmationDialog(context);
//           },
//           child: Image.asset(
//             'images/power.png',
//             width: 40,
//             height: 40,
//           ),
//         ),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: IconButton(
//               onPressed: () {},
//               icon: Image.asset('images/forward_arrow.png', width: 40),
//             ),
//           ),
//         ],
//         backgroundColor: Colors.white,
//       ),
//       backgroundColor: Colors.white,
//       body: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Stack(
//           children: [
//             Column(
//               children: [
//                 TextField(
//                   decoration: InputDecoration(
//                     hintText: 'Search by date',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   controller: _searchDateController,
//                   keyboardType: TextInputType.text,
//                   inputFormatters: [
//                     FilteringTextInputFormatter.singleLineFormatter
//                   ],
//                   onTap: () async {
//                     DateTime? pickedDate = await showDatePicker(
//                       context: context,
//                       initialDate: DateTime.now(),
//                       firstDate: DateTime(2000),
//                       lastDate: DateTime(2101),
//                     );
//                     if (pickedDate != null) {
//                       _searchTransactionsByDate(pickedDate);
//                       print("Selcted date :$pickedDate");
//                     }
//                   },
//                 ),
//                 SizedBox(height: 30),
//                 Container(
//                   height: 50,
//                   width: MediaQuery.sizeOf(context).width,
//                   color: Colors.black,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Expanded(
//                         child: Container(
//                           alignment: Alignment.center,
//                           width: MediaQuery.sizeOf(context).width * 0.25,
//                           child: const TextWidget(
//                             text: 'Date',
//                             textcolor: Colors.white,
//                             textsize: 12,
//                             textweight: FontWeight.w600,
//                           ),
//                         ),
//                       ),
//                       Expanded(
//                         child: Container(
//                           alignment: Alignment.center,
//                           width: MediaQuery.sizeOf(context).width * 0.25,
//                           child: const TextWidget(
//                             text: 'Name',
//                             textcolor: Colors.white,
//                             textsize: 12,
//                             textweight: FontWeight.w600,
//                           ),
//                         ),
//                       ),
//                       Expanded(
//                         child: Container(
//                           alignment: Alignment.center,
//                           width: MediaQuery.sizeOf(context).width * 0.25,
//                           child: const TextWidget(
//                             text: 'Received',
//                             textcolor: Colors.white,
//                             textsize: 12,
//                             textweight: FontWeight.w600,
//                           ),
//                         ),
//                       ),
//                       Expanded(
//                         child: Container(
//                           alignment: Alignment.center,
//                           width: MediaQuery.sizeOf(context).width * 0.25,
//                           child: const TextWidget(
//                             text: 'Given',
//                             textcolor: Colors.white,
//                             textsize: 12,
//                             textweight: FontWeight.w600,
//                           ),
//                         ),
//                       ),
//                       // Add other headers (Name, Received, Given) similarly
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   child: ListView.builder(
//                     // shrinkWrap: true,

//                     itemCount: transaction?.data.length ?? 0,
//                     itemBuilder: (context, index) {
//                       final transactionItem = transaction!.data[index];

//                       final transactionType = transactionItem.trnxType;
//                       final amount = transactionItem.amount;

//                       return Container(
//                         height: 50,
//                         width: MediaQuery.sizeOf(context).width,
//                         color:
//                             index.isEven ? MyAppColor.grey2Color : Colors.white,
//                         child: Row(
//                           children: [
//                             Expanded(
//                               // flex: 1,
//                               child: Container(
//                                 alignment: Alignment.center,
//                                 width: MediaQuery.sizeOf(context).width * 0.25,
//                                 child: TextWidget(
//                                     text: '$selectedDate',
//                                     textcolor: MyAppColor.textClor,
//                                     textsize: 12,
//                                     textweight: FontWeight.w600),
//                               ),
//                             ),
//                             const VerticalDivider(
//                               color: Colors.black,
//                               thickness: 1,
//                               // width: 10,
//                             ),
//                             Expanded(
//                               // flex: 1,
//                               child: Container(
//                                 alignment: Alignment.center,
//                                 width: MediaQuery.sizeOf(context).width * 0.25,
//                                 child: TextWidget(
//                                     text: 'name',
//                                     textcolor: MyAppColor.textClor,
//                                     textsize: 14,
//                                     textweight: FontWeight.w600),
//                               ),
//                             ),
//                             const VerticalDivider(
//                               color: Colors.black,
//                               thickness: 1,
//                             ),
//                             Expanded(
//                               // flex: 1,
//                               child: Container(
//                                 alignment: Alignment.center,
//                                 width: MediaQuery.sizeOf(context).width * 0.25,
//                                 child: TextWidget(
//                                     text: transactionType == "credit"
//                                         ? amount
//                                         : '',
//                                     textcolor: MyAppColor.greenColor,
//                                     textsize: 14,
//                                     textweight: FontWeight.w600),
//                               ),
//                             ),
//                             const VerticalDivider(
//                               color: Colors.black,
//                               thickness: 1,
//                             ),
//                             Expanded(
//                               // flex: 1,
//                               child: Container(
//                                 alignment: Alignment.center,
//                                 width: MediaQuery.sizeOf(context).width * 0.25,
//                                 child: TextWidget(
//                                     text: transactionType == 'debit'
//                                         ? amount
//                                         : '',
//                                     textcolor: MyAppColor.redColor,
//                                     textsize: 14,
//                                     textweight: FontWeight.w600),
//                               ),
//                             )
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:convert';
import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';
import 'package:d_app/view/custom_widgets/dateSelection_container.dart';
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
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Stack(
          children: [
            Column(
              children: [
                ElevatedButton(
                  style: ButtonStyle(
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
                      });
                      _searchTransactionsByDate();
                      print("Selected date: $pickedDate");
                    }
                  },
                  child: TextWidget(
                      text: 'Choose Date',
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
                  child: ListView.builder(
                    itemCount: transactions.length,
                    itemBuilder: (context, index) {
                      // final transactionItem = transactions[index];
                      final transactionItem = date1!.data[index];

                      final transactionType = transactionItem.trnxType;
                      final amount = transactionItem.amount;

                      final name = transactionItem.userDetail[0].firstName +
                          " " +
                          transactionItem.userDetail[0].lastName;
                      return Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        color:
                            index.isEven ? MyAppColor.grey2Color : Colors.white,
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width * 0.25,
                                child: TextWidget(
                                  text: DateFormat('yyyy-MM-dd')
                                      .format(transactionItem.createdAt),
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
                                width: MediaQuery.of(context).size.width * 0.25,
                                child: TextWidget(
                                  // Replace 'Name' with the actual property you want to display
                                  // text: transactionItem.userDetail[0].firstName,
                                  text: name,
                                  textcolor: MyAppColor.textClor,
                                  textsize: 14,
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
                                width: MediaQuery.of(context).size.width * 0.25,
                                child: TextWidget(
                                  // Replace 'Received' with the actual property you want to display
                                  text:
                                      transactionType == "credit" ? amount : '',
                                  textcolor: MyAppColor.greenColor,
                                  textsize: 14,
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
                                width: MediaQuery.of(context).size.width * 0.25,
                                child: TextWidget(
                                  // Replace 'Given' with the actual property you want to display
                                  text:
                                      transactionType == 'debit' ? amount : '',
                                  textcolor: MyAppColor.redColor,
                                  textsize: 14,
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
      ),
    );
  }
}
