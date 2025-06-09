import 'package:flutter/material.dart';

class YearDaysPlanner extends StatefulWidget {
  final List<DateTime> redDays; // jours à colorer en rouge

  const YearDaysPlanner({Key? key, required this.redDays}) : super(key: key);

  @override
  State<YearDaysPlanner> createState() => _YearDaysPlannerState();
}

class _YearDaysPlannerState extends State<YearDaysPlanner> {
  DateTime? _selectedDay;
  final List<_Task> _tasks = [];

  bool _isRedDay(DateTime day) {
    return widget.redDays.any((d) =>
        d.year == day.year && d.month == day.month && d.day == day.day);
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final firstDay = DateTime(now.year, 1, 1);
    final lastDay = DateTime(now.year, 12, 31);
    final days = List<DateTime>.generate(
      lastDay.difference(firstDay).inDays + 1,
      (i) => firstDay.add(Duration(days: i)),
    );

    return Column(
      children: [
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 1.2,
            ),
            itemCount: days.length,
            itemBuilder: (context, idx) {
              final day = days[idx];
              final isRed = _isRedDay(day);
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedDay = day;
                  });
                  showDialog(
                    context: context,
                    builder: (ctx) => TaskDialog(
                      onSave: (title, desc) {
                        setState(() {
                          _tasks.add(_Task(day, title, desc));
                        });
                        Navigator.of(ctx).pop();
                      },
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: isRed ? Colors.red : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Center(
                    child: Text(
                      '${day.day}/${day.month}',
                      style: TextStyle(
                        color: isRed ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        if (_tasks.isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: _tasks.map((t) => ListTile(
                title: Text('${t.title} (${t.day.day}/${t.day.month})'),
                subtitle: Text(t.description),
              )).toList(),
            ),
          ),
      ],
    );
  }
}

class TaskDialog extends StatefulWidget {
  final void Function(String title, String description) onSave;

  const TaskDialog({Key? key, required this.onSave}) : super(key: key);

  @override
  State<TaskDialog> createState() => _TaskDialogState();
}

class _TaskDialogState extends State<TaskDialog> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _desc = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Créer une tâche'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Titre'),
              validator: (v) => v == null || v.isEmpty ? 'Obligatoire' : null,
              onSaved: (v) => _title = v ?? '',
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Description'),
              validator: (v) => v == null || v.isEmpty ? 'Obligatoire' : null,
              onSaved: (v) => _desc = v ?? '',
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Annuler'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState?.validate() ?? false) {
              _formKey.currentState?.save();
              widget.onSave(_title, _desc);
            }
          },
          child: const Text('Créer'),
        ),
      ],
    );
  }
}

class _Task {
  final DateTime day;
  final String title;
  final String description;

  _Task(this.day, this.title, this.description);
}
