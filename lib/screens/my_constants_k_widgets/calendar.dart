import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendrierJourTravail extends StatefulWidget {
  final Function(Map<String, dynamic>) onChanged;

  const CalendrierJourTravail({super.key, required this.onChanged});

  @override
  State<CalendrierJourTravail> createState() => _CalendrierJourTravailState();
}

class _CalendrierJourTravailState extends State<CalendrierJourTravail> {
  DateTime _currentMonth = DateTime.now();
  Set<int> _selectedDays = {};

  @override
  Widget build(BuildContext context) {
    int daysInMonth = DateUtils.getDaysInMonth(_currentMonth.year, _currentMonth.month);
    List<Widget> dayButtons = List.generate(daysInMonth, (index) {
      int day = index + 1;
      bool isSelected = _selectedDays.contains(day);

      return GestureDetector(
        onTap: () {
          setState(() {
            isSelected ? _selectedDays.remove(day) : _selectedDays.add(day);
            widget.onChanged({
              'mois': DateFormat.MMMM('fr_FR').format(_currentMonth),
              'annee': _currentMonth.year,
              'jours': _selectedDays.toList()..sort()
            });
          });
        },
        child: Container(
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: isSelected ? Colors.green : Colors.grey[300],
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Text(
            '$day',
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    });

    return Column(
      children: [
        Text(
          DateFormat.yMMMM('fr_FR').format(_currentMonth),
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 7,
          children: dayButtons,
        ),
      ],
    );
  }


}
