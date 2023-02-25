import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:adventuresclub/widgets/text_fields/TF_with_size.dart';
import 'package:adventuresclub/widgets/text_fields/tf_with_Size_image.dart';
import 'package:flutter/material.dart';

class Program extends StatefulWidget {
  const Program({super.key});

  @override
  State<Program> createState() => _ProgramState();
}

class _ProgramState extends State<Program> {
  TextEditingController controller = TextEditingController();
  abc() {}
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        TFWithSize('Schedule Title', controller, 12, lightGreyColor, 1),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: TFWithSizeImage(
                    'Start Date',
                    controller,
                    16,
                    lightGreyColor,
                    2.4,
                    Icons.calendar_month_outlined,
                    bluishColor)),
            Expanded(
                child: TFWithSizeImage('End Date', controller, 16,
                    lightGreyColor, 2.4, Icons.access_time, bluishColor)),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TFWithSize(
                'Schedule Description', controller, 12, lightGreyColor, 1.4),
            const Image(image: ExactAssetImage('images/add-circle.png'))
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Image(
                image: ExactAssetImage('images/add-circle.png'), height: 20),
            const SizedBox(
              width: 5,
            ),
            MyText(
              text: 'Add More Schedule',
              color: bluishColor,
            )
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
