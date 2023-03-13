// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/models/health_condition_model.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/material.dart';

class CheckboxGrid extends StatefulWidget {
  final List<HealthConditionModel> hc;
  const CheckboxGrid(this.hc, {Key? key}) : super(key: key);

  @override
  CheckboxGridState createState() => CheckboxGridState();
}

class CheckboxGridState extends State<CheckboxGrid> {
  @override
  void initState() {
    super.initState();
    widget.hc.forEach((element) {
      value.add(false);
    });
  }

  List<bool> value = [
    // false,
    // false,
    // false,
    // false,
    // false,
    // false,
    // false,
    // false,
    // false,
    // false,
    // false,
    // false
  ];
  List<String> text = [
    'Good Condition',
    'Bone weakness',
    'Breath difficulty',
    'Mussels issue',
    'Backbone issue',
    'Joins issue',
    'Ligament issue',
    'Not Good Condition',
    'High B.P',
    'Low B.P',
    'High Diabetes',
    'Low Diabetes'
  ];
  @override
  Widget build(BuildContext context) {
    // final double itemHeight =
    //     (MediaQuery.of(context).size.height - kToolbarHeight - 24) / 9.75;
    // final double itemWidth = MediaQuery.of(context).size.width / 4.5;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: GridView.count(
        padding: const EdgeInsets.only(top: 0),
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        mainAxisSpacing: 0,
        childAspectRatio: 5.5,
        crossAxisSpacing: 2,
        crossAxisCount: 2,
        children: List.generate(
          widget.hc.length, // widget.profileURL.length,
          (index) {
            return Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: SizedBox(
                    width: 15,
                    child: Transform.scale(
                      scale: 0.8,
                      child: Checkbox(
                          activeColor: whiteColor,
                          checkColor: bluishColor,
                          hoverColor: bluishColor,
                          focusColor: bluishColor,
                          value: value[index],
                          onChanged: (bool? value1) {
                            setState(() {
                              value[index] = value1!;
                            });
                          }),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                // Expanded(
                //   child: SizedBox.shrink(),
                //   flex: 1,
                // ),
                MyText(
                    text: widget.hc[index].healthCondition,
                    color: blackColor.withOpacity(0.6),
                    weight: FontWeight.w700,
                    size: 12,
                    fontFamily: 'Raleway'),
                //Container()
                // const Spacer(
                //   flex: 3,
                // ),
              ],
            );
          },
        ),
      ),
    );
  }
}
