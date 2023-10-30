import 'package:d_app/utils/constant.dart';
import 'package:d_app/view/custom_widgets/custom_gradientButton.dart';
import 'package:d_app/view/custom_widgets/dateSelection_container.dart';
import 'package:d_app/view/custom_widgets/text_widget.dart';
import 'package:flutter/material.dart';
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        selectedDate = DateFormat('dd/MM/yy').format(picked);
      });
    }
  }

  void _showGivenPopup() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          height: MediaQuery.sizeOf(context).height / 2,
          width: MediaQuery.sizeOf(context).width,
          child: CustomDateSelectionContainer(
              selectedDate: selectedDate,
              containerColor: MyAppColor.greyColor,
              textColor: MyAppColor.grey3Color,
              onTap: () {
                _selectDate(context);
              },
              iconColor: MyAppColor.grey3Color),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          leading: Image.asset('images/back_arrow.png'),
          leadingWidth: 40,
          actions: [
            IconButton(
              onPressed: () {},
              icon: Image.asset('images/forward_arrow.png', width: 40),
            ),
          ],
          backgroundColor: Colors.white,
          centerTitle: true,
          title: CustomDateSelectionContainer(
            containerColor: Colors.grey.shade300,
            selectedDate: selectedDate,
            textColor: MyAppColor.mainBlueColor,
            iconColor: MyAppColor.mainBlueColor,
            onTap: () {
              _selectDate(context);
            },
          )),
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
                          TextWidget(
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
                          TextWidget(
                              text: 'Closing Balance',
                              textcolor: MyAppColor.textClor,
                              textsize: 12,
                              textweight: FontWeight.w600)
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
                          // prefixIcon: IconButton(
                          //   icon: Icon(
                          //     Icons.search,
                          //     color: Colors.black.withOpacity(0.54),
                          //   ),
                          //   onPressed: () {},
                          // ),
                          // suffixIcon: GestureDetector(
                          //   onTap: () {
                          //     _searchController.text = "";
                          //   },
                          //   child: Icon(
                          //     Icons.clear,
                          //     color: Colors.black,
                          //   ),
                          // ),
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
                        TextWidget(
                            text: 'Date  ',
                            textcolor: Colors.white,
                            textsize: 12,
                            textweight: FontWeight.w600),
                        TextWidget(
                            text: 'Name',
                            textcolor: Colors.white,
                            textsize: 12,
                            textweight: FontWeight.w600),
                        TextWidget(
                            text: 'Received',
                            textcolor: Colors.white,
                            textsize: 12,
                            textweight: FontWeight.w600),
                        TextWidget(
                            text: 'Given',
                            textcolor: Colors.white,
                            textsize: 12,
                            textweight: FontWeight.w600)
                      ],
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 50,
                        width: MediaQuery.sizeOf(context).width,
                        color:
                            index.isEven ? MyAppColor.grey2Color : Colors.white,
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
                                    thickness: 2,
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
                                    thickness: 2,
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
                                    thickness: 2,
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
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 25,
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
                _showGivenPopup();
              },
              buttonText: 'Recived',
              containerColor: Color(0xFFF0D963),
              gradientColors: [Color(0xFF1F9540), Color(0xFF61CC7F)],
            ),
            CustomGradientButton(
              onPressed: () {},
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
