import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class ProductServiceFormReservation extends StatefulWidget {
  final Map<String, dynamic> productOrService;
  final List<Map<String, dynamic>> reservations;
  final void Function(DateTime selectedDate)? onReservation;

  const ProductServiceFormReservation({
    Key? key,
    required this.productOrService,
    required this.reservations,
    this.onReservation,
  }) : super(key: key);

  @override
  State<ProductServiceFormReservation> createState() => _ProductServiceFormReservationState();
}

class _ProductServiceFormReservationState extends State<ProductServiceFormReservation> {
  DateTime? _selectedDate;
  late DateTime _focusedDay;
  late List<DateTime> _reservedDates;

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _reservedDates = widget.reservations
        .map((r) => r['date'] is DateTime
            ? r['date']
            : DateTime.tryParse(r['date'].toString()) ?? DateTime(2000))
        .toList()
        .cast<DateTime>();
  }

  bool _isReserved(DateTime day) {
    return _reservedDates.any((d) =>
        d.year == day.year && d.month == day.month && d.day == day.day);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.productOrService['title'] ?? 'Réservation',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 16),
            TableCalendar(
              locale: 'fr_FR',
              firstDay: DateTime(_focusedDay.year, _focusedDay.month, 1),
              lastDay: DateTime(_focusedDay.year,9, 0),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) =>
                  _selectedDate != null &&
                  day.year == _selectedDate!.year &&
                  day.month == _selectedDate!.month &&
                  day.day == _selectedDate!.day,
              calendarFormat: CalendarFormat.month,
              availableGestures: AvailableGestures.none,
              onDaySelected: (selectedDay, focusedDay) {
                if (_isReserved(selectedDay)) return;
                setState(() {
                  _selectedDate = selectedDay;
                  _focusedDay = focusedDay;
                });
                if (widget.onReservation != null) {
                  widget.onReservation!(selectedDay);
                }
              },
              calendarBuilders: CalendarBuilders(
                defaultBuilder: (context, day, focusedDay) {
                  if (_isReserved(day)) {
                    return Container(
                      margin: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${day.day}',
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    );
                  }
                  return null;
                },
                selectedBuilder: (context, day, focusedDay) {
                  return Container(
                    margin: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '${day.day}',
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  );
                },
                todayBuilder: (context, day, focusedDay) {
                  if (_isReserved(day)) {
                    return Container(
                      margin: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${day.day}',
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    );
                  }
                  return Container(
                    margin: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '${day.day}',
                      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  );
                },
              ),
              enabledDayPredicate: (day) => !_isReserved(day),
            ),
            if (_selectedDate != null)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  'Date sélectionnée : ${DateFormat.yMMMd('fr_FR').format(_selectedDate!)}',
                  style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
