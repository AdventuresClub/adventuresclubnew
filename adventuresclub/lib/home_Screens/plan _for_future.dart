import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/home_Screens/navigation_screens/requests.dart';
import 'package:adventuresclub/widgets/buttons/button_icon_less.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:adventuresclub/widgets/text_fields/multiline_field.dart';
import 'package:flutter/material.dart';

class PlanForFuture extends StatefulWidget {
  const PlanForFuture({super.key});

  @override
  State<PlanForFuture> createState() => _PlanForFutureState();
}

class _PlanForFutureState extends State<PlanForFuture> {
  TextEditingController mainController = TextEditingController();
  int _n = 0;
  int _m = 0;
  bool value = false;
  var cont = false;
  var formattedDate;
  DateTime? pickedDate;
  var currentIndex;
  String selectedGender = "";
  int index = 0;
  abc() {}

  @override
  void initState() {
    super.initState();
    formattedDate = 'Birthday';
  }

  void goToRequests() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return const Requests();
    }));
  }

  DateTime currentDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(DateTime.now().day - 1),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != currentDate) {
      setState(() {
        var date = DateTime.parse(pickedDate.toString());
        formattedDate = "${date.day}-${date.month}-${date.year}";
        currentDate = pickedDate!;
      });
    }
  }

  void add() {
    setState(() {
      _n++;
    });
  }

  void minus() {
    setState(() {
      if (_n != 0) _n--;
    });
  }

  void addAdult() {
    setState(() {
      _m++;
    });
  }

  void minusAdult() {
    setState(() {
      if (_m != 0) _m--;
    });
  }

  List text = [
    'Per Person',
    'Total Person    x1',
    'Promo Code',
    'Points',
    'Total Amount'
  ];
  List text2 = [
    'ر.ع 20,000',
    'ر.ع 20,000',
    '-ر.ع 500',
    '-ر.ع 150',
    'ر.ع 19,350'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 1.5,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Image.asset(
            'images/backArrow.png',
            height: 20,
          ),
        ),
        title: MyText(
          text: 'Plan For Future ',
          color: bluishColor,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Card(
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 20),
                    child: Column(
                      children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: MyText(
                              text: 'Start Date',
                              weight: FontWeight.bold,
                              color: blackTypeColor4,
                              size: 2,
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: GestureDetector(
                            onTap: () => _selectDate(context),
                            child: Container(
                              width: MediaQuery.of(context).size.width / 1,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: ListTile(
                                  leading: Text(
                                    formattedDate.toString(),
                                    style: const TextStyle(color: blackColor),
                                  ),
                                  trailing: const Icon(Icons.calendar_today,
                                      color: greenishColor)),
                            ),
                          ),
                        ),
                        const Divider(),
                        const SizedBox(
                          height: 10,
                        ),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: MyText(
                              text: 'Planning For',
                              weight: FontWeight.bold,
                              color: blackTypeColor4,
                              size: 22,
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            MyText(
                              text: 'Adult',
                              color: blackColor,
                            ),
                            Container(
                              height: 31,
                              padding: const EdgeInsets.all(0),
                              color: greyColorShade400,
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: minusAdult,
                                      child: Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                              color: whiteColor,
                                              border: Border.all(
                                                  color: greyColorShade400)),
                                          padding: const EdgeInsets.all(6),
                                          child: const Image(
                                              image: ExactAssetImage(
                                                  'images/feather-minus.png'))),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Text('$_m',
                                          style:
                                              const TextStyle(fontSize: 20.0)),
                                    ),
                                    GestureDetector(
                                      onTap: addAdult,
                                      child: Container(
                                          decoration: BoxDecoration(
                                              color: whiteColor,
                                              border: Border.all(
                                                  color: greyColorShade400)),
                                          padding: const EdgeInsets.all(4),
                                          child: const Icon(Icons.add,
                                              color: bluishColor)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            MyText(
                              text: 'Child:',
                              color: blackColor,
                            ),
                            Container(
                              height: 31,
                              padding: const EdgeInsets.all(0),
                              color: greyColorShade400,
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: minus,
                                      child: Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                              color: whiteColor,
                                              border: Border.all(
                                                  color: greyColorShade400)),
                                          padding: const EdgeInsets.all(6),
                                          child: const Image(
                                              image: ExactAssetImage(
                                                  'images/feather-minus.png'))),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Text('$_n',
                                          style:
                                              const TextStyle(fontSize: 20.0)),
                                    ),
                                    GestureDetector(
                                      onTap: add,
                                      child: Container(
                                          decoration: BoxDecoration(
                                              color: whiteColor,
                                              border: Border.all(
                                                  color: greyColorShade400)),
                                          child: const Icon(Icons.add,
                                              color: bluishColor)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        MultiLineField('Type Message here...', 5, whiteColor,
                            mainController),
                      ],
                    ),
                  )),
              Card(
                child: Column(
                  children: [
                    CheckboxListTile(
                        value: value,
                        title: MyText(
                          text: 'Use earned Points',
                          weight: FontWeight.w500,
                          color: blackTypeColor1,
                          fontFamily: 'Roboto',
                        ),
                        checkColor: whiteColor,
                        activeColor: bluishColor,
                        onChanged: (bool? value1) {
                          setState(() {
                            value = value1!;
                          });
                        }),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 12.0, right: 12, bottom: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: const TextSpan(
                              text: 'Available Points',
                              style: TextStyle(
                                  color: blueTextColor,
                                  fontSize: 10,
                                  fontFamily: 'Roboto'),
                              children: <TextSpan>[
                                TextSpan(
                                    text: ' 500',
                                    style: TextStyle(
                                        fontSize: 24,
                                        color: blueTextColor,
                                        fontFamily: 'Roboto')),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              MyText(
                                  text: 'Opt to use',
                                  color: blueTextColor,
                                  size: 10,
                                  fontFamily: 'Roboto'),
                              const SizedBox(width: 5),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 5,
                                height: MediaQuery.of(context).size.width / 10,
                                child: TextField(
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 16),
                                  decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 10),
                                      isDense: true,
                                      filled: true,
                                      fillColor: whiteColor,
                                      border: OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(6.0)),
                                        borderSide: BorderSide(
                                            color: blackColor.withOpacity(0.2)),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(6.0)),
                                        borderSide: BorderSide(
                                            color: blackColor.withOpacity(0.2)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(6)),
                                          borderSide: BorderSide(
                                              color: blackColor
                                                  .withOpacity(0.2)))),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: MyText(
                              text: 'Apply Promo Code',
                              weight: FontWeight.bold,
                              color: blackTypeColor4,
                              size: 22,
                              fontFamily: 'Roboto')),
                      TextField(
                        decoration: InputDecoration(
                            suffixStyle: const TextStyle(
                              color: bluishColor,
                              fontFamily: 'Roboto',
                            ),
                            suffixText: 'Apply',
                            border: UnderlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
                                  color: blackColor.withOpacity(0.2)),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
                                  color: blackColor.withOpacity(0.2)),
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(
                                    color: blackColor.withOpacity(0.2)))),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 7,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 15),
                  child: Column(
                    children: [
                      Wrap(
                          children: List.generate(text.length, (index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyText(
                                text: text[index],
                                color: blackTypeColor3,
                                weight: FontWeight.w500,
                                fontFamily: 'Roboto'),
                            MyText(
                                text: text2[index],
                                color: greyColor,
                                weight: FontWeight.bold,
                                fontFamily: 'Roboto'),
                          ],
                        );
                      })),
                      const SizedBox(height: 5),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyText(
                              text: 'Total Amount',
                              color: blackTypeColor3,
                              weight: FontWeight.w500,
                              height: 1.5,
                              fontFamily: 'Roboto'),
                          MyText(
                              text: 'ر.ع 19,350',
                              color: bluishColor,
                              weight: FontWeight.bold,
                              size: 16,
                              height: 1.5,
                              fontFamily: 'Roboto'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ButtonIconLess('Send Request', bluishColor, whiteColor, 1.7, 17,
                  18, goToRequests),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
