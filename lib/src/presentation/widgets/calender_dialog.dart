import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderDialog extends StatefulWidget {
  const CalenderDialog({super.key});

  @override
  State<CalenderDialog> createState() => _CalenderDialogState();
}

class _CalenderDialogState extends State<CalenderDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(15),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 175,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: const BoxDecoration(
                    color: Color(0xFFEDF8FF),
                  ),
                  child: const Text(
                    'Today',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF1DA1F2),
                      fontSize: 14,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Container(
                  width: 175,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: const BoxDecoration(
                    color: Color(0xFFEDF8FF),
                  ),
                  child: const Text(
                    'Next Monday',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF1DA1F2),
                      fontSize: 14,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 175,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: const BoxDecoration(
                    color: Color(0xFFEDF8FF),
                  ),
                  child: const Text(
                    'Next Tuesday',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF1DA1F2),
                      fontSize: 14,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Container(
                  width: 175,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: const BoxDecoration(
                    color: Color(0xFFEDF8FF),
                  ),
                  child: const Text(
                    'After 1 week',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF1DA1F2),
                      fontSize: 14,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            TableCalendar(
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: DateTime.now(),
            ),
          ],
        ),
      ),
    );
  }
}
