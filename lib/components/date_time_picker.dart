import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                      lastDate: DateTime(2101));

                  if (pickedDate != null && pickedDate != DateTime.now()) {
                    setState(() {
                      DateTime newDateTime = pickedDate!.toLocal();
                      DateTime oldDateTime =
                          widget.map[widget.mapKey] ?? DateTime(0);
                      widget.map.update(
                        widget.mapKey,
                        (v) => DateTime(
                            newDateTime.year,
                            newDateTime.month,
                            newDateTime.day,
                            oldDateTime.hour,
                            oldDateTime.minute,
                            oldDateTime.second,
                            oldDateTime.millisecond,
                            oldDateTime.microsecond),
                      );

                      widget.map.update(widget.mapKey, (v) => pickedDate!);
                      widget.dateController.text = "${[
                        'Mon',
                        'Tue',
                        'Wed',
                        'Thu',
                        'Fri',
                        'Sat',
                        'Sun'
                      ][pickedDate!.weekday - 1]}, ${pickedDate!.day}/${pickedDate!.month}/${pickedDate!.year}";
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
                        // TODO: Change into theme font
                        style:
                            GoogleFonts.nunitoSans(fontWeight: FontWeight.bold),
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
                    DateTime oldDateTime =
                        widget.map[widget.mapKey] ?? DateTime(0);
                    widget.map.update(
                      widget.mapKey,
                      (v) => DateTime(
                          oldDateTime.year,
                          oldDateTime.month,
                          oldDateTime.day,
                          picked.hour,
                          picked.minute,
                          oldDateTime.second,
                          oldDateTime.millisecond,
                          oldDateTime.microsecond),
                    );
                    setState(() {
                      widget.timeController.text =
                          "${picked.hourOfPeriod.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')} ${picked.hour < 12 ? 'AM' : 'PM'}";
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
                        // TODO: Change into theme font
                        style:
                            GoogleFonts.nunitoSans(fontWeight: FontWeight.bold),
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
