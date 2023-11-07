import 'dart:convert';

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

  void selectName(String fullName, String userId) {
    setState(() {
      _searchNameController.text = fullName;
      searchResults.clear(); // Clear the search results
      selectedUserId = userId; // Store the selected user's ID
      selectedName = fullName;
      fetchTransactionsForUser(userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: Image.asset(
          'images/back_arrow.png',
        ),
        leadingWidth: 40,
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
        child: Column(
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
                scrollDirection: Axis.vertical,
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
                          selectedUserId = searchResults[index].id;
                          fetchTransactionsForUser(selectedUserId);
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
            Container(
              height: 50,
              width: MediaQuery.sizeOf(context).width,
              color: Colors.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const TextWidget(
                      text: 'Date',
                      textcolor: Colors.white,
                      textsize: 12,
                      textweight: FontWeight.w600),
                  const TextWidget(
                      text: 'Name',
                      textcolor: Colors.white,
                      textsize: 12,
                      textweight: FontWeight.w600),
                  const TextWidget(
                      text: 'Received',
                      textcolor: Colors.white,
                      textsize: 12,
                      textweight: FontWeight.w600),
                  const TextWidget(
                      text: 'Given',
                      textcolor: Colors.white,
                      textsize: 12,
                      textweight: FontWeight.w600)
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                // shrinkWrap: true,
                itemCount: transaction?.data.length ?? 0,
                itemBuilder: (context, index) {
                  final transactionItem = transaction!.data[index];
                  final date =
                      transactionItem.createdAt.toString().substring(0, 10);
                  final transactionType = transactionItem.trnxType;
                  final amount = transactionItem.amount.numberDecimal;

                  return Container(
                    height: 50,
                    width: MediaQuery.sizeOf(context).width,
                    color: index.isEven ? MyAppColor.grey2Color : Colors.white,
                    child: Row(
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  width: MediaQuery.sizeOf(context).width / 6.5,
                                  child: TextWidget(
                                      text: '${date}',
                                      textcolor: MyAppColor.textClor,
                                      textsize: 12,
                                      textweight: FontWeight.w600),
                                ),
                              ),
                              VerticalDivider(
                                color: Colors.black,
                                thickness: 1,
                                // width: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  width: MediaQuery.sizeOf(context).width / 6.5,
                                  child: TextWidget(
                                      text: 'aditya patil',
                                      textcolor: MyAppColor.textClor,
                                      textsize: 12,
                                      textweight: FontWeight.w600),
                                ),
                              ),
                              VerticalDivider(
                                color: Colors.black,
                                thickness: 1,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  width: MediaQuery.sizeOf(context).width / 6.5,
                                  child: TextWidget(
                                      text: transactionType == "credit"
                                          ? amount
                                          : '',
                                      textcolor: MyAppColor.greenColor,
                                      textsize: 12,
                                      textweight: FontWeight.w600),
                                ),
                              ),
                              VerticalDivider(
                                color: Colors.black,
                                thickness: 1,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  width: MediaQuery.sizeOf(context).width / 6,
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
      bottomNavigationBar: Container(
        height: 60,
        width: MediaQuery.sizeOf(context).width,
        color: MyAppColor.yellowColor,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                TextWidget(
                    text: 'Total \nReceived',
                    textcolor: MyAppColor.textClor,
                    textsize: 13,
                    textweight: FontWeight.w600),
                SizedBox(
                  width: 20,
                ),
                TextWidget(
                    text: '50000',
                    textcolor: MyAppColor.textClor,
                    textsize: 14,
                    textweight: FontWeight.w800)
              ],
            ),
            VerticalDivider(
              thickness: 1,
              color: MyAppColor.mainblackColor,
            ),
            Row(
              children: [
                TextWidget(
                    text: 'Total \nGiven',
                    textcolor: MyAppColor.textClor,
                    textsize: 13,
                    textweight: FontWeight.w600),
                SizedBox(
                  width: 20,
                ),
                TextWidget(
                    text: '50000',
                    textcolor: MyAppColor.textClor,
                    textsize: 14,
                    textweight: FontWeight.w800)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
