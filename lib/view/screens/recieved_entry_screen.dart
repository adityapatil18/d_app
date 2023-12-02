import 'dart:convert';

import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/all_data.dart';
import '../../model/recived_entry_model.dart';
import '../../utils/constant.dart';
import '../custom_widgets/dateSelection_container.dart';
import '../custom_widgets/text_field.dart';
import '../custom_widgets/text_widget.dart';
import 'add_entry.dart';

class RecivedEntryScreen extends StatefulWidget {
  const RecivedEntryScreen({super.key});

  @override
  State<RecivedEntryScreen> createState() => _RecivedEntryScreenState();
}

class _RecivedEntryScreenState extends State<RecivedEntryScreen> {
  TextEditingController _receivedFirstNameController = TextEditingController();
  TextEditingController _receivedLastNameController = TextEditingController();
  TextEditingController _amountController = TextEditingController();
  TextEditingController _searchNameController = TextEditingController();
  TextEditingController _receivedRemarkController = TextEditingController();

  String _selectedOption = "";
  List<Datum> allData = []; // List of data obtained from API
  List<Datum> searchResults = [];
  String selectedUserId = ''; // Variable to hold the selected user's ID
  String selectedName = ""; // Store the selected name
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    fetchData("");
    getStoredUserId(); // Fetch data from the API when the screen loads
  }

  Future<void> getStoredUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final storedUserId = prefs.getString("userId");
    if (storedUserId != null && storedUserId.isNotEmpty) {
      // Use the stored userId as needed
      print('Stored User ID: $storedUserId');
    } else {
      print('User ID not found in SharedPreferences');
    }
  }

  Future<REntry> createEntry(
    String firstName,
    String lastName,
    String amount,
    String remark,
    DateTime? dateTime,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final storedUserId = prefs.getString("userId");
    if (storedUserId == null || storedUserId.isEmpty) {
      throw Exception('User ID not found in SharedPreferences');
    }
    final response = await http.post(
        Uri.parse('https://appapi.techgigs.in/api/transaction/transfer'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "firstName": firstName,
          "lastName": lastName,
          "amount": amount,
          "type": "credit",
          "status": "1",
          "id": selectedUserId,
          "remark": remark,
          "date": selectedDate.toLocal().toString(),
          "createdId": storedUserId,
        }));
    print(selectedUserId);
    print('storedUserId:$storedUserId');
    print('create entry api response:${response.body}');

    if (response.statusCode == 200) {
      final entryResponse = REntry.fromJson(jsonDecode(response.body));
      if (entryResponse.id != null && entryResponse.id!.isNotEmpty) {
        // selectedUserId = entryResponse.id!;
        return entryResponse;
      } else {
        throw Exception('Failed to create entry. User ID not available.');
      }
    } else {
      throw Exception('Failed to create entry.');
    }
  }

  Future<REntry> oldEntry(
      {String selectedName = "",
      String remark = "",
      String amount = "",
      String selectedId = "",
      DateTime? selectedDate}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final storedUserId = prefs.getString("userId");
    if (storedUserId == null || storedUserId.isEmpty) {
      throw Exception('User ID not found in SharedPreferences');
    }
    final response = await http.post(
        Uri.parse('https://appapi.techgigs.in/api/transaction/transfer'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "firstName": selectedName,
          "lastName": "",
          "amount": amount,
          "type": "credit",
          "status": "0",
          "Id": selectedId,
          "remark": remark,
          "date": selectedDate!.toLocal().toString(),
          "createdId": storedUserId,
        }));
    print(amount);
    print(selectedId);
    print(selectedName);
    print(remark);
    print(selectedDate);
    print('api response: ${response.body}');

    if (response.statusCode == 200) {
      return REntry.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create entry.');
    }
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
      allData = allDataList;
      print('JSON DAT:$jsonData');
      print('api response:$allData');
    } else {
      throw Exception('Failed to fetch data.');
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

  void selectName(String fullName, String userId) {
    setState(() {
      _searchNameController.text = fullName;
      searchResults.clear(); // Clear the search results
      selectedUserId = userId; // Store the selected user's ID
    });
  }

  void clearText() {
    _amountController.clear();
    _receivedFirstNameController.clear();
    _receivedLastNameController.clear();
    _searchNameController.clear();
    _receivedRemarkController.clear();
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
                    builder: (context) => AddEntryScreen(),
                  ));
            },
            icon: Image.asset(
              'images/back_arrow.png',
            )),
        leadingWidth: 50,
        centerTitle: true,
        title: const TextWidget(
            text: 'RECEIVED ENTRY',
            textcolor: MyAppColor.greenColor,
            textsize: 22,
            textweight: FontWeight.w700),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                showUninstallConfirmationDialog(context);
              },
              child: Image.asset(
                'images/power.png',
                width: 40,
                height: 50,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
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
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Row(
                  children: [
                    Radio(
                      value: "New Entry",
                      groupValue: _selectedOption,
                      onChanged: (value) {
                        setState(() {
                          _selectedOption = value!;
                        });
                      },
                    ),
                    const Text(
                      'New Entry',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF202020)),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: "Old Entry",
                      groupValue: _selectedOption,
                      onChanged: (value) {
                        setState(() {
                          _selectedOption = value!;
                        });
                      },
                    ),
                    const Text(
                      'Old Entry',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF202020)),
                    ),
                  ],
                ),
              ],
            ),
            Visibility(
              visible: _selectedOption == "New Entry",
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const TextWidget(
                                  text: 'First name',
                                  textcolor: MyAppColor.textClor,
                                  textsize: 14,
                                  textweight: FontWeight.w600),
                              SizedBox(
                                height: 5,
                              ),
                              CustomTextField(
                                  hintText: 'Enter First Name',
                                  controller: _receivedFirstNameController,
                                  keyboardType: TextInputType.text,
                                  inputFormatters: [
                                    FilteringTextInputFormatter
                                        .singleLineFormatter
                                  ]),
                              SizedBox(
                                height: 15,
                              ),
                              const TextWidget(
                                  text: 'Last name',
                                  textcolor: MyAppColor.textClor,
                                  textsize: 14,
                                  textweight: FontWeight.w600),
                              SizedBox(
                                height: 5,
                              ),
                              CustomTextField(
                                  hintText: 'Enter Last Name',
                                  controller: _receivedLastNameController,
                                  keyboardType: TextInputType.text,
                                  inputFormatters: [
                                    FilteringTextInputFormatter
                                        .singleLineFormatter
                                  ]),
                              SizedBox(
                                height: 15,
                              ),
                              const TextWidget(
                                  text: 'Remark',
                                  textcolor: MyAppColor.textClor,
                                  textsize: 14,
                                  textweight: FontWeight.w600),
                              SizedBox(
                                height: 5,
                              ),
                              CustomTextField(
                                  hintText: 'Enter Remark',
                                  controller: _receivedRemarkController,
                                  keyboardType: TextInputType.text,
                                  inputFormatters: [
                                    FilteringTextInputFormatter
                                        .singleLineFormatter
                                  ]),
                              SizedBox(
                                height: 15,
                              ),
                              const TextWidget(
                                  text: 'Amount',
                                  textcolor: MyAppColor.textClor,
                                  textsize: 14,
                                  textweight: FontWeight.w600),
                              SizedBox(
                                height: 5,
                              ),
                              TextField(
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'\d+')),
                                ],
                                controller: _amountController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    hintText: 'Enter Amount',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Visibility(
              visible: _selectedOption == "Old Entry",
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    if (searchResults.isNotEmpty)
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: searchResults.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            tileColor: index.isEven
                                ? MyAppColor.grey2Color
                                : Colors.white,
                            title: Text(searchResults[index].firstName +
                                " " +
                                searchResults[index].lastName),
                            onTap: () {
                              // Handle the selection of the name here

                              // Clear the search results and hide the ListView
                              setState(() {
                                _searchNameController.text =
                                    searchResults[index].firstName +
                                        " " +
                                        searchResults[index].lastName;
                                selectedName = searchResults[index].firstName +
                                    " " +
                                    searchResults[index].lastName;
                                selectedUserId = searchResults[index].id;
                                searchResults.clear();
                              });
                            },
                          );
                        },
                      ),
                    SizedBox(
                      height: 150,
                    ),
                    const TextWidget(
                        text: 'Remark',
                        textcolor: MyAppColor.textClor,
                        textsize: 14,
                        textweight: FontWeight.w600),
                    SizedBox(
                      height: 5,
                    ),
                    CustomTextField(
                        hintText: 'Enter Remark',
                        controller: _receivedRemarkController,
                        keyboardType: TextInputType.text,
                        inputFormatters: [
                          FilteringTextInputFormatter.singleLineFormatter
                        ]),
                    SizedBox(
                      height: 15,
                    ),
                    const TextWidget(
                        text: 'Amount',
                        textcolor: MyAppColor.textClor,
                        textsize: 14,
                        textweight: FontWeight.w600),
                    SizedBox(
                      height: 5,
                    ),
                    TextField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'\d+')),
                      ],
                      decoration: InputDecoration(
                          hintText: 'Enter Amount',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: GestureDetector(
          child: Container(
            alignment: Alignment.center,
            height: 70,
            width: MediaQuery.sizeOf(context).width,
            color: MyAppColor.mainBlueColor,
            child: const TextWidget(
                text: 'Add Entry',
                textcolor: Colors.white,
                textsize: 16,
                textweight: FontWeight.w600),
          ),
          onTap: () {
            final firstName = _receivedFirstNameController.text;
            final lastName = _receivedLastNameController.text;
            final amount = _amountController.text;
            final remark = _receivedRemarkController.text;

            if (isValidAmount(amount)) {
              if (_selectedOption == "New Entry" &&
                  firstName.isNotEmpty &&
                  lastName.isNotEmpty &&
                  remark.isNotEmpty &&
                  amount.isNotEmpty) {
                // Check if the user already exists
                if (_checkUserExists(firstName, lastName)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content:
                          Text('User already exists. Please create a new one.'),
                    ),
                  );
                } else {
                  // Call the createEntry function to post the data
                  createEntry(firstName, lastName, amount, remark, selectedDate)
                      .then((entryResponse) {
                    // Handle the response as needed
                    // Navigate to AddEntryScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddEntryScreen(),
                      ),
                    );
                  }).catchError((error) {
                    // Handle errors
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddEntryScreen(),
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Entry added successfully')),
                    );
                  });
                }
              } else if (_selectedOption == "Old Entry" &&
                  selectedName.isNotEmpty &&
                  remark.isNotEmpty &&
                  amount.isNotEmpty) {
                oldEntry(
                  amount: _amountController.text,
                  remark: _receivedRemarkController.text,
                  selectedName: selectedName,
                  selectedId: selectedUserId,
                  selectedDate: selectedDate,
                ).then((entryResponse) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddEntryScreen(),
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Entry Added Successfully.')),
                  );
                }).catchError((error) {
                  // Handle errors
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Failed to add entry.')),
                  );
                });
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Add all required fields.')),
                );
              }

              clearText();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Please enter a valid amount.')),
              );
            }
          }),
    );
  }

  // bool _checkUserExists(String firstName, String lastName) {
  //   for (Datum datum in allData) {
  //     if (datum.firstName == firstName && datum.lastName == lastName) {
  //       return true; // User already exists
  //     }
  //   }
  //   return false; // User does not exist
  // }

  bool isValidAmount(String amount) {
    // Check if the amount contains only digits
    return RegExp(r'^\d+$').hasMatch(amount);
  }

  bool _checkUserExists(String firstName, String lastName) {
    // Convert names to lowercase for case-insensitive comparison
    String lowerCaseFirstName = firstName.toLowerCase();
    String lowerCaseLastName = lastName.toLowerCase();

    for (Datum datum in allData) {
      if (datum.firstName.toLowerCase() == lowerCaseFirstName &&
          datum.lastName.toLowerCase() == lowerCaseLastName) {
        return true; // User already exists
      }
    }
    return false; // User does not exist
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
