import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ninjacoder/src/presentation/screens/cubit/employee_cubit.dart';
import 'package:ninjacoder/src/shared/extension/string_ext.dart';
import 'package:table_calendar/table_calendar.dart';

class EndCalenderDialog extends StatefulWidget {
  const EndCalenderDialog({super.key});

  @override
  State<EndCalenderDialog> createState() => _EndCalenderDialogState();
}

class _EndCalenderDialogState extends State<EndCalenderDialog> {
  DateTime? _selectedDay = DateTime.now();

  List<String> initialDate = ['No date', 'Today'];
  String selected = '';

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: initialDate
                .map(
                  (e) => GestureDetector(
                    onTap: () {
                      switch (e) {
                        case 'No date':
                          setState(() {
                            _selectedDay = DateTime(0);
                            selected = e;
                          });
                          break;
                        case 'Today':
                          setState(() {
                            _selectedDay = DateTime.now();
                            selected = e;
                          });
                          break;

                        default:
                      }
                    },
                    child: Container(
                      width: 175,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: selected == e
                            ? Colors.blue
                            : const Color(0xFFEDF8FF),
                      ),
                      child: Text(
                        e.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: selected == e
                              ? Colors.white
                              : const Color(0xFF1DA1F2),
                          fontSize: 14,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 10),
          Theme(
            data: ThemeData(primaryColor: Colors.blue),
            child: TableCalendar(
              calendarStyle: CalendarStyle(
                  markerDecoration: const BoxDecoration(color: Colors.blue),
                  todayDecoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.blue),
                  ),
                  todayTextStyle: const TextStyle(color: Colors.black),
                  selectedDecoration: const BoxDecoration(
                      color: Colors.blue, shape: BoxShape.circle)),
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: DateTime.now(),
              availableCalendarFormats: const {CalendarFormat.month: 'Month'},
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                });
              },
            ),
          ),
          const Divider(
            color: Colors.grey,
            thickness: 1,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                const Icon(
                  Icons.event,
                  color: Colors.blue,
                ),
                const SizedBox(width: 10),
                Text(
                  _selectedDay == DateTime(0)
                      ? selected
                      : _selectedDay.toString().formatToCustomDate(),
                  style: const TextStyle(
                    color: Color(0xFF323238),
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: const Color(0xFFEDF8FF),
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        color: Color(0xFF1DA1F2),
                        fontSize: 14,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    context.read<EmployeeCubit>().selectEndDate(_selectedDay!);
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: const Color(0xFF1DA1F2),
                    ),
                    child: const Text(
                      'Save',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10)
              ],
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
