import 'package:adventuresclub/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeCalendarPage extends StatefulWidget {
  const HomeCalendarPage({super.key});

  @override
  HomeCalendarPageState createState() => HomeCalendarPageState();
}

class HomeCalendarPageState extends State<HomeCalendarPage> {
  //  CalendarController _controller;

  // @override
  // void initState() {
  //   super.initState();
  //   _controller = CalendarController();
  // }
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  late CalendarFormat _calendarFormat;
  // @override
  // void initState() {
  //   super.initState();
  //   _controller = CalendarController();
  // }
//   void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
//   if (!isSameDay(_selectedDay, selectedDay)) {
//     setState(() {
//       _focusedDay = focusedDay;
//       _selectedDay = selectedDay;
//       _selectedEvents = _getEventsForDay(selectedDay);
//     });
//   }
// }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Card(
              elevation: 1,
              child: TableCalendar(
                calendarFormat: CalendarFormat.week,
                daysOfWeekVisible: true,
                daysOfWeekHeight: 20,
                daysOfWeekStyle: const DaysOfWeekStyle(
                    weekdayStyle: TextStyle(
                        color: greyColor, fontWeight: FontWeight.w500)),
//            availableCalendarFormats: _calendarFormat,
// onFormatChanged: (format) {
//   setState(() {
//     _calendarFormat = format;
//   });
// },
                // eventLoader: (day) {
                //   if (day.weekday == DateTime.monday) {
                //     return [Event('Cyclic event')];
                //   }

                //   return [];
                // },

                selectedDayPredicate: (day) {
                  // Use `selectedDayPredicate` to determine which day is currently selected.
                  // If this returns true, then `day` will be marked as selected.

                  // Using `isSameDay` is recommended to disregard
                  // the time-part of compared DateTime objects.
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  if (!isSameDay(_selectedDay, selectedDay)) {
                    // Call `setState()` when updating the selected day
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  }
                },
                onFormatChanged: (format) {
                  if (_calendarFormat != format) {
                    // Call `setState()` when updating calendar format
                    setState(() {
                      _calendarFormat = format;
                    });
                  }
                },
                onPageChanged: (focusedDay) {
                  // No need to call `setState()` here
                  _focusedDay = focusedDay;
                },
                calendarStyle: const CalendarStyle(
                    todayDecoration: BoxDecoration(color: bluishColor),
                    // todayColor: Colors.blue,
                    selectedDecoration: BoxDecoration(color: bluishColor),
                    todayTextStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22.0,
                        color: Colors.black)),

                headerStyle: const HeaderStyle(
                  titleCentered: true,
                  formatButtonVisible: false,
                  formatButtonShowsNext: false,
                ),
                startingDayOfWeek: StartingDayOfWeek.monday,
                // onDaySelected: (date, events) {
                //   print(date.toUtc());
                // },

                calendarBuilders: CalendarBuilders(
                  dowBuilder: (context, day) {
                    if (day.weekday == DateTime.sunday) {
                      final text = DateFormat.E().format(day);

                      return Center(
                        child: Text(
                          text,
                          style: const TextStyle(
                              color: greyColor, fontWeight: FontWeight.w500),
                        ),
                      );
                    }
                  },
                  //  markerBuilder: (context, datetime, events) {
                  //       return // model.countTasksByDate(datetime) >0 ?
                  //       Container(
                  //         width: 20,
                  //         height: 15,
                  //         decoration: BoxDecoration(
                  //             color: globals.primaries[model.countTasksByDate(datetime)],
                  //             borderRadius: BorderRadius.circular(4.0)
                  //         ),
                  //         child: Center(
                  //           child: Text(model.countTasksByDate(datetime).toString(),
                  //           style: TextStyle(color: Colors.white)),
                  //         ),)
                  //      // ): Container();
                  //     },

                  selectedBuilder: (context, _datetime, focusedDay) {
                    return Container(
                      decoration: BoxDecoration(
                          color: bluishColor,
                          borderRadius: BorderRadius.circular(32.0)),
                      margin: const EdgeInsets.all(10.0),
                      child: Center(
                        child: Text(
                          _datetime.day.toString(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  },

                  todayBuilder: (context, date, events) => Container(
                      margin: const EdgeInsets.all(10.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(32.0)),
                      child: Text(
                        date.day.toString(),
                        style: const TextStyle(color: blackColor),
                      )),
                ),

                //: _controller,
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: DateTime.now(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
