import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/constant.dart';
import '../custom_widgets/dateSelection_container.dart';
import '../custom_widgets/text_field.dart';
import '../custom_widgets/text_widget.dart';

class GivenEntryScreen extends StatefulWidget {
  const GivenEntryScreen({super.key});

  @override
  State<GivenEntryScreen> createState() => _GivenEntryScreenState();
}

class _GivenEntryScreenState extends State<GivenEntryScreen> {
  TextEditingController _givenFirstNameController = TextEditingController();
  TextEditingController _givenLastNameController = TextEditingController();
  TextEditingController _givenAmountController = TextEditingController();
  TextEditingController _searchController = TextEditingController();
  String _selectedOption = "";

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
            TextWidget(
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
                    Text(
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
                    Text(
                      'Old Entry',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF202020)),
                    ),
                  ],
                ),
                // Container(
                //   width: 200,
                //   height: 30,
                //   child: RadioListTile(
                //     title: Text('old'),
                //     value: 'old',
                //     groupValue: _selectedOption,
                //     onChanged: (value) {},
                //   ),
                // ),
                // Container(
                //   width: 200,
                //   height: 30,
                //   child: RadioListTile(
                //     title: Text('old'),
                //     value: 'old',
                //     groupValue: _selectedOption,
                //     onChanged: (value) {},
                //   ),
                // )
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
                              TextWidget(
                                  text: 'First name',
                                  textcolor: MyAppColor.textClor,
                                  textsize: 14,
                                  textweight: FontWeight.w600),
                              SizedBox(
                                height: 5,
                              ),
                              CustomTextField(
                                  hintText: 'Enter First Name',
                                  controller: _givenFirstNameController,
                                  keyboardType: TextInputType.text,
                                  inputFormatters: [
                                    FilteringTextInputFormatter
                                        .singleLineFormatter
                                  ]),
                              SizedBox(
                                height: 15,
                              ),
                              TextWidget(
                                  text: 'Last name',
                                  textcolor: MyAppColor.textClor,
                                  textsize: 14,
                                  textweight: FontWeight.w600),
                              SizedBox(
                                height: 5,
                              ),
                              CustomTextField(
                                  hintText: 'Enter Last Name',
                                  controller: _givenLastNameController,
                                  keyboardType: TextInputType.text,
                                  inputFormatters: [
                                    FilteringTextInputFormatter
                                        .singleLineFormatter
                                  ]),
                              SizedBox(
                                height: 15,
                              ),
                              TextWidget(
                                  text: 'Amount',
                                  textcolor: MyAppColor.textClor,
                                  textsize: 14,
                                  textweight: FontWeight.w600),
                              SizedBox(
                                height: 5,
                              ),
                              CustomTextField(
                                hintText: 'Enter Amount',
                                controller: _givenAmountController,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  CommaSeparatorInputFormatter(),
                                ],
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
                    Container(
                      margin: EdgeInsets.only(top: 15, bottom: 15),
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: TextField(
                        textInputAction: TextInputAction.search,
                        controller: _searchController,
                        onSubmitted: (value) {
                          setState(() {
                            var Loader = true;
                          });
                        },
                        keyboardType: TextInputType.name,
                        style: new TextStyle(
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search_sharp),
                          border: InputBorder.none,
                          hintText: "Search by name",
                          hintStyle: new TextStyle(
                            color: Colors.black.withOpacity(0.54),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextWidget(
                        text: 'Amount',
                        textcolor: MyAppColor.textClor,
                        textsize: 14,
                        textweight: FontWeight.w600),
                    SizedBox(
                      height: 5,
                    ),
                    CustomTextField(
                      hintText: 'Enter Amount',
                      controller: _givenAmountController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        CommaSeparatorInputFormatter(),
                      ],
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
          child: TextWidget(
              text: 'Add Entry',
              textcolor: Colors.white,
              textsize: 16,
              textweight: FontWeight.w600),
        ),
        onTap: () {},
      ),
    );
  }
}
