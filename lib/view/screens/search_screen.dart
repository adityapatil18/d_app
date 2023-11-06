import 'dart:convert';

import 'package:d_app/utils/constant.dart';
import 'package:d_app/view/custom_widgets/custom_gradientButton.dart';
import 'package:d_app/view/custom_widgets/dateSelection_container.dart';
import 'package:d_app/view/custom_widgets/text_widget.dart';
import 'package:d_app/view/screens/given_entry_screen.dart';
import 'package:d_app/view/screens/recieved_entry_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class SerachScreen extends StatefulWidget {
  const SerachScreen({Key? key}) : super(key: key);

  @override
  _SerachScreenState createState() => _SerachScreenState();
}

class _SerachScreenState extends State<SerachScreen> {
  String selectedDate = DateFormat('dd/MM/yy').format(DateTime.now());
  final TextStyle customTextStyle = TextStyle(
    color: MyAppColor.mainBlueColor, // Set the text color to #2C1BEF
    fontWeight: FontWeight.bold, // Customize the font weight
  );
  TextEditingController _searchController = TextEditingController();

  var Loader;

  void _recivedPopUp() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
            height: MediaQuery.sizeOf(context).height / 1.5,
            width: MediaQuery.sizeOf(context).width,
            child: RecivedEntryScreen());
      },
    );
  }

  void _givenPopUp() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height / 1.5,
            child: GivenEntryScreen());
      },
    );
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
          centerTitle: true,
          title: CustomDateSelectionContainer(
              textColor: MyAppColor.mainBlueColor,
              iconColor: MyAppColor.mainBlueColor)),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
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
                            "3/71 C",
                            style: TextStyle(
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
                      Image.asset(
                        'images/power.png',
                        width: 53,
                        height: 53,
                      ),
                      Column(
                        children: [
                          Text(
                            "3/71 C",
                            style: TextStyle(
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
                    height: 15,
                  ),
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
                    child: Container(
                      height: 100,
                      child: TextField(
                        textInputAction: TextInputAction.search,
                        controller: _searchController,
                        onSubmitted: (value) {
                          setState(() {
                            Loader = true;
                          });
                        },
                        keyboardType: TextInputType.name,
                        style: new TextStyle(
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "  Search by name, or amount",
                          hintStyle: new TextStyle(
                            color: Colors.black.withOpacity(0.54),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: MediaQuery.sizeOf(context).width,
                    color: Colors.black,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const TextWidget(
                            text: 'Date  ',
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
                      itemCount: 20,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 50,
                          width: MediaQuery.sizeOf(context).width,
                          color: index.isEven
                              ? MyAppColor.grey2Color
                              : Colors.white,
                          child: Row(
                            children: [
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: TextWidget(
                                          text: selectedDate,
                                          textcolor: MyAppColor.textClor,
                                          textsize: 12,
                                          textweight: FontWeight.w600),
                                    ),
                                    VerticalDivider(
                                      color: Colors.black,
                                      thickness: 1,
                                      width: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: TextWidget(
                                          text: 'Adesh',
                                          textcolor: MyAppColor.textClor,
                                          textsize: 12,
                                          textweight: FontWeight.w600),
                                    ),
                                    VerticalDivider(
                                      color: Colors.black,
                                      thickness: 1,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: TextWidget(
                                          text: '+10000',
                                          textcolor: MyAppColor.greenColor,
                                          textsize: 12,
                                          textweight: FontWeight.w600),
                                    ),
                                    VerticalDivider(
                                      color: Colors.black,
                                      thickness: 1,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: TextWidget(
                                          text: '-5000',
                                          textcolor: MyAppColor.redColor,
                                          textsize: 12,
                                          textweight: FontWeight.w600),
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
                _recivedPopUp();
              },
              buttonText: 'Recived',
              containerColor: Color(0xFFF0D963),
              gradientColors: [Color(0xFF1F9540), Color(0xFF61CC7F)],
            ),
            CustomGradientButton(
              onPressed: () {
                _givenPopUp();
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
}
