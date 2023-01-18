import 'package:adventuresclub/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeCalendarPage extends StatefulWidget {  
  @override  
  _HomeCalendarPageState createState() => _HomeCalendarPageState();  
}  
  
class _HomeCalendarPageState extends State<HomeCalendarPage> {  
  // CalendarController _controller;  
  
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
                daysOfWeekStyle: DaysOfWeekStyle(
                 weekdayStyle: TextStyle(color: blackTypeColor4)
                ),
                
       //         selectedDayPredicate: (day) {
//   return isSameDay(_selectedDay, day);
// },
// onDaySelected: (selectedDay, focusedDay) {
//   setState(() {
//     _selectedDay = selectedDay;
//     _focusedDay = focusedDay; // update `_focusedDay` here as well
//   });
// },
     
                calendarStyle: CalendarStyle(  
                    // todayColor: Colors.blue,  
                    // selectedColor: Theme.of(context).primaryColor,  
                    // todayStyle: TextStyle(  
                    //     fontWeight: FontWeight.bold,  
                    //     fontSize: 22.0,  
                    //     color: Colors.white)  
                
                ),  
                
                headerStyle: HeaderStyle(  
                  titleCentered: true,  
                    formatButtonVisible: false,
                  formatButtonShowsNext: false,  
                ),  
                startingDayOfWeek: StartingDayOfWeek.monday,  
                onDaySelected: (date, events) {  
                  print(date.toUtc());  
                },  
                
                calendarBuilders: CalendarBuilders(
  dowBuilder: (context, day) {
    if (day.weekday == DateTime.sunday) {
      final text = DateFormat.E().format(day);

      return Center(
        child: Text(
          text,
          style: TextStyle(color: Colors.red),
        ),
      );
    }
  },
),
                //   todayBuilder: (context, date, events) => Container(  
                //       margin: const EdgeInsets.all(5.0),  
                //       alignment: Alignment.center,  
                //       decoration: BoxDecoration(  
                //           color: Colors.blue,  
                //           borderRadius: BorderRadius.circular(8.0)),  
                //       child: Text(  
                //         date.day.toString(),  
                //         style: TextStyle(color: whiteColor),  
                //       )),  
                // ),  
                // : _controller,
                 firstDay: DateTime.utc(2010, 10, 16),
  lastDay: DateTime.utc(2030, 3, 14),
  focusedDay: DateTime.now(),
              ),
            )  
          ],  
        ),  
      ),  
    );  
  }  
}  