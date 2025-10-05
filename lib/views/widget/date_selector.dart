import 'dart:developer';

import 'package:english_learning/helper/widget/field_label.dart';
import 'package:english_learning/helper/widget/neu_box.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateSelector extends StatefulWidget {
  final ValueChanged<DateTime> onDateSelected; // Callback function

  const DateSelector({super.key, required this.onDateSelected});

  @override
  State<DateSelector> createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  DateTime selectedDate = DateTime.now().toUtc().add(const Duration(hours: 6));
  int weekOffset = 0;

  List<DateTime> generateWeekDates(int weekOffset) {
    final today = DateTime.now().toUtc().add(const Duration(hours: 6));
    DateTime startOfWeek = today.subtract(Duration(days: today.weekday - 1));
    startOfWeek = startOfWeek.add(Duration(days: weekOffset * 7));
    return List.generate(7, (index) => startOfWeek.add(Duration(days: index)));
  }

  @override
  Widget build(BuildContext context) {
    List<DateTime> weekDates = generateWeekDates(weekOffset);
    String monthName = DateFormat('MMMM').format(weekDates.first);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 40,
                height: 40,
                child: NeuBox(
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios, size: 10),
                    onPressed: () {
                      setState(() {
                        weekOffset--;
                      });
                    },
                  ),
                ),
              ),
              FieldLabel(label: monthName),
              SizedBox(
                width: 40,
                height: 40,
                child: NeuBox(
                  child: IconButton(
                    icon: const Icon(Icons.arrow_forward_ios, size: 10),
                    onPressed: () {
                      setState(() {
                        weekOffset++;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: weekDates.length,
              itemBuilder: (context, index) {
                DateTime date = weekDates[index];
                bool isSelected = DateFormat('d').format(selectedDate) ==
                        DateFormat('d').format(date) &&
                    selectedDate.month == date.month &&
                    selectedDate.year == date.year;

                return Container(
                  width: (MediaQuery.of(context).size.width - 35) / 8,
                  margin: const EdgeInsets.symmetric(horizontal: 4.2),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedDate = date;
                      });
                      widget.onDateSelected(date); // Call the callback
                      log('Selected date: $selectedDate');
                    },
                    child: NeuBox(
                      color: isSelected ? Colors.deepOrangeAccent : null,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            DateFormat('d').format(date), // Day of the month
                            style: TextStyle(
                              color: isSelected ? Colors.black : Colors.grey,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            DateFormat('E') // Short weekday (Mon, Tue, etc.)
                                .format(date),
                            maxLines: 1,
                            style: TextStyle(
                              color: isSelected ? Colors.black : Colors.grey,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
