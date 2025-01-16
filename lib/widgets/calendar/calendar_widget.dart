import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWidget extends StatefulWidget {
  final DateTime selectedDay;
  final Function(DateTime selectedDay) onDaySelected;

  const CalendarWidget({
    Key? key,
    required this.selectedDay,
    required this.onDaySelected,
  }) : super(key: key);

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  Widget build(BuildContext context) {
    return TableCalendar<String>(
      firstDay: DateTime(2020),
      lastDay: DateTime(2030),
      focusedDay: widget.selectedDay,
      selectedDayPredicate: (day) => isSameDay(widget.selectedDay, day),
      eventLoader: (day) {
        return []; // Event loader logic here if needed
      },
      onDaySelected: (selectedDay, focusedDay) {
        widget.onDaySelected(selectedDay);
      },
      calendarFormat: _calendarFormat, // Pass the calendar format here
      onFormatChanged: (format) {
        setState(() {
          _calendarFormat = format;
        });
      },
    );
  }
}
