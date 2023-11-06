import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../../model/all_data.dart';
import '../../model/recived_entry_model.dart';
import '../../utils/constant.dart';
import '../custom_widgets/dateSelection_container.dart';
import '../custom_widgets/text_field.dart';
import '../custom_widgets/text_widget.dart';

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
  String _selectedOption = "";
  List<Datum> allData = []; // List of data obtained from API
  List<Datum> searchResults = [];
  String selectedUserId = ''; // Variable to hold the selected user's ID
  String selectedName = ""; // Store the selected name

  @override
  void initState() {
    super.initState();
    fetchData(""); // Fetch data from the API when the screen loads
  }

  Future<REntry> createEntry(
    String firstName,
    String lastName,
    String amount,
  ) async {
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
          // "id": generatedId ?? "",
          "id": selectedUserId
        }));
    print(selectedUserId);
    print('api response:${response.body}');

    if (response.statusCode == 200) {
      final entryResponse = REntry.fromJson(jsonDecode(response.body));
      if (entryResponse.id != null && entryResponse.id!.isNotEmpty) {
        selectedUserId = entryResponse.id!;
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
      String amount = "",
      String selectedId = ""}) async {
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
        }));
    print(amount);
    print(selectedId);
    print(selectedName);
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
      setState(() {
        allData = allDataList;
      });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Image.asset(
        'images/question.png',
        height: 30,
        width: 30,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            const TextWidget(
                text: 'RECEIVED ENTRY',
                textcolor: MyAppColor.greenColor,
                textsize: 22,
                textweight: FontWeight.w700),
            SizedBox(
              height: 20,
            ),
            CustomDateSelectionContainer(
                textColor: MyAppColor.grey3Color,
                iconColor: MyAppColor.grey3Color),
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
                                  text: 'Amount',
                                  textcolor: MyAppColor.textClor,
                                  textsize: 14,
                                  textweight: FontWeight.w600),
                              SizedBox(
                                height: 5,
                              ),
                              TextField(
                                controller: _amountController,
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
                        searchResults = searchNames(query);
                      },
                    ),
                    if (searchResults.isNotEmpty)
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: searchResults.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              title: Text(searchResults[index].fullName),
                              onTap: () {
                                // Handle the selection of the name here
                                _searchNameController.text =
                                    searchResults[index].fullName;
                                // Clear the search results and hide the ListView
                                setState(() {
                                  selectedName = searchResults[index].fullName;
                                  selectedUserId = searchResults[index].id;
                                  searchResults.clear();
                                });
                              },
                            ),
                          );
                        },
                      ),
                    SizedBox(
                      height: 100,
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
          // // setState(() {
          // //   createEntry(_receivedFirstNameController.text,
          // //       _receivedLastNameController.text, _amountController.text);
          // // });
          // final firstName = _receivedFirstNameController.text;
          // final lastName = _receivedLastNameController.text;
          // final amount = _amountController.text;

          // // Check if required fields are not empty
          // if (firstName.isNotEmpty &&
          //     lastName.isNotEmpty &&
          //     amount.isNotEmpty) {
          //   // You can set the "status" based on the selected option here
          //   String status;
          //   if (_selectedOption == "New Entry") {
          //     status = "1";
          //   } else if (_selectedOption == "Old Entry") {
          //     status = "0";
          //   } else {
          //     // Provide a default value if no valid option is selected
          //     status = "0";
          //   }

          //   // Call the createEntry function to post the data
          //   createEntry(
          //     firstName,
          //     lastName,
          //     amount,
          //   );
          // } else {
          //   // Show an error message if any of the required fields are empty
          //   ScaffoldMessenger.of(context).showSnackBar(
          //     SnackBar(content: Text('Please fill in all required fields.')),
          //   );
          // }
          final firstName = _receivedFirstNameController.text;
          final lastName = _receivedLastNameController.text;
          final amount = _amountController.text;

          if (_selectedOption == "New Entry") {
            // Call the createEntry function to post the data
            createEntry(
              firstName,
              lastName,
              amount,
            ).then((entryResponse) {
              // Handle the response as needed
            }).catchError((error) {
              // Handle errors
            });
          } else if (_selectedOption == "Old Entry") {
            // Call the oldEntry function
            oldEntry(
                    amount: _amountController.text,
                    selectedName: selectedName,
                    selectedId: selectedUserId)
                .then((entryResponse) {
              // Handle the response as needed
            }).catchError((error) {
              // Handle errors
            });
          } else {
            // Handle other cases or show an error message
          }
        },
      ),
    );
  }
}
