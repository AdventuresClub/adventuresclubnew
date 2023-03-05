import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/provider/complete_profile_provider/complete_profile_provider.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:adventuresclub/widgets/text_fields/TF_with_size.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Program extends StatefulWidget {
  const Program({super.key});

  @override
  State<Program> createState() => _ProgramState();
}

class _ProgramState extends State<Program> {
  TextEditingController controller = TextEditingController();
  var formattedDate;
  var endDate;
  DateTime? pickedDate;
  DateTime currentDate = DateTime.now();

  abc() {}

  @override
  void initState() {
    super.initState();
    formattedDate = 'GatheringDate';
  }

  Future<void> _selectDate(BuildContext context, var givenDate) async {
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
    getDates(formattedDate.toString());
  }

  void getDates(String gatheringDate) {
    Provider.of<CompleteProfileProvider>(context, listen: false).gatheringDate =
        gatheringDate;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CompleteProfileProvider>(
        builder: (context, provider, child) {
      return Column(
        children: [
          const SizedBox(height: 20),
          TFWithSize('Schedule Title', provider.scheduleController, 12,
              lightGreyColor, 1),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () => _selectDate(context, formattedDate),
            child: Container(
              height: 50,
              padding: const EdgeInsets.symmetric(vertical: 0),
              //width: MediaQuery.of(context).size.width / 1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: lightGreyColor,
                border: Border.all(
                  width: 1,
                  color: greyColor.withOpacity(0.2),
                ),
              ),
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                leading: Text(
                  formattedDate.toString(),
                  style: TextStyle(color: blackColor.withOpacity(0.6)),
                ),
                trailing: Icon(
                  Icons.calendar_today,
                  color: blackColor.withOpacity(0.6),
                  size: 20,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          provider.particularWeekDay
              ? Container()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _selectDate(context, formattedDate),
                        child: Container(
                          height: 50,
                          padding: const EdgeInsets.symmetric(vertical: 0),
                          //width: MediaQuery.of(context).size.width / 1,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: lightGreyColor,
                            border: Border.all(
                              width: 1,
                              color: greyColor.withOpacity(0.2),
                            ),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            leading: Text(
                              formattedDate.toString(),
                              style:
                                  TextStyle(color: blackColor.withOpacity(0.6)),
                            ),
                            trailing: Icon(
                              Icons.calendar_today,
                              color: blackColor.withOpacity(0.6),
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _selectDate(context, endDate),
                        child: Container(
                          height: 50,
                          padding: const EdgeInsets.symmetric(vertical: 0),
                          //width: MediaQuery.of(context).size.width / 1,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: lightGreyColor,
                            border: Border.all(
                              width: 1,
                              color: greyColor.withOpacity(0.2),
                            ),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            leading: Text(
                              endDate.toString(),
                              style:
                                  TextStyle(color: blackColor.withOpacity(0.6)),
                            ),
                            trailing: Icon(
                              Icons.calendar_today,
                              color: blackColor.withOpacity(0.6),
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
          // Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Expanded(
          //         child: TFWithSizeImage(
          //             'Start Date',
          //             controller,
          //             16,
          //             lightGreyColor,
          //             2.4,
          //             Icons.calendar_month_outlined,
          //             bluishColor),
          //       ),
          //       const SizedBox(
          //         width: 10,
          //       ),
          //       Expanded(
          //           child: TFWithSizeImage(
          //               'End Date',
          //               controller,
          //               16,
          //               lightGreyColor,
          //               2.4,
          //               Icons.access_time,
          //               bluishColor)),
          //     ],
          //   ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TFWithSize('Schedule Description', provider.scheduleDesController,
                  12, lightGreyColor, 1.4),
              //const Image(image: ExactAssetImage('images/add-circle.png'))
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
    });
  }
}
