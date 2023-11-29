import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyDateTimePicker extends StatefulWidget {
  final TextEditingController dateController;
  final DateTime firstDate;
  final TextEditingController timeController;
  final Map<String, DateTime> map;
  final String mapKey;

  const MyDateTimePicker({
    super.key,
    required this.dateController,
    required this.firstDate,
    required this.timeController,
    required this.map,
    required this.mapKey,
  });

  @override
  State<MyDateTimePicker> createState() => _MyDateTimePickerState();
}

class _MyDateTimePickerState extends State<MyDateTimePicker> {
  DateTime? pickedDate = DateTime.now();
  TimeOfDay? pickedTime = TimeOfDay.now();

  DateTime updateDate(DateTime oldDate, DateTime newDate) {
    oldDate = oldDate.toLocal();
    newDate = newDate.toLocal();
    return DateTime(
      newDate.year,
      newDate.month,
      newDate.day,
      oldDate.hour,
      oldDate.minute,
    );
  }

  DateTime updateTime(DateTime oldTime, TimeOfDay newTime) {
    oldTime = oldTime.toLocal();
    return DateTime(
      oldTime.year,
      oldTime.month,
      oldTime.day,
      newTime.hour,
      newTime.minute,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () async {
                  pickedDate = await showDatePicker(
                    context: context,
                    initialDate: pickedDate == null ||
                            pickedDate!.isBefore(widget.firstDate)
                        ? widget.firstDate
                        : pickedDate!,
                    firstDate: widget.firstDate,
                    lastDate: widget.firstDate.add(
                      const Duration(days: 365),
                    ),
                  );

                  if (pickedDate != null && pickedDate != DateTime.now()) {
                    setState(() {
                      DateTime oldDate = widget.map[widget.mapKey]!;
                      DateTime newDate = updateDate(oldDate, pickedDate!);

                      widget.map.update(widget.mapKey, (v) => newDate);

                      widget.dateController.text =
                          DateFormat.yMEd().format(newDate);
                    });
                  }
                },
                child: Container(
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Date",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        enabled: false,
                        controller: widget.dateController,
                        keyboardType: TextInputType.none,
                        style: Theme.of(context).textTheme.bodyMedium,
                        decoration:
                            const InputDecoration(hintText: "Select date"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 30),
            Expanded(
              child: GestureDetector(
                onTap: () async {
                  final TimeOfDay? picked = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (picked != null) {
                    setState(() {
                      DateTime oldTime = widget.map[widget.mapKey]!;
                      DateTime newTime = updateTime(oldTime, picked);

                      widget.map.update(widget.mapKey, (v) => newTime);

                      widget.timeController.text =
                          DateFormat.jm().format(newTime);
                    });
                  }
                },
                child: Container(
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Time",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        enabled: false,
                        controller: widget.timeController,
                        keyboardType: TextInputType.none,
                        style: Theme.of(context).textTheme.bodyMedium,
                        decoration: const InputDecoration(
                          hintText: "Select time",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
