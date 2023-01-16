import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/material.dart';

class CheckboxGrid extends StatefulWidget {
  const CheckboxGrid({Key? key}) : super(key: key);

  @override
  _CheckboxGridState createState() => _CheckboxGridState();
}

class _CheckboxGridState extends State<CheckboxGrid> {
  List<bool> value = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
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
    final double itemHeight =
        (MediaQuery.of(context).size.height - kToolbarHeight - 24) / 9.75;
    final double itemWidth = MediaQuery.of(context).size.width / 4.5;
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
          value.length, // widget.profileURL.length,
          (index) {
            return Row(
              children: [
                Transform.scale(
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
                // Expanded(
                //   child: SizedBox.shrink(),
                //   flex: 1,
                // ),
                MyText(
                    text: text[index],
                    color: blackColor.withOpacity(0.6),
                    weight: FontWeight.w700,
                    size: 10,
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
