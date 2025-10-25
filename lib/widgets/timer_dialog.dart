import 'package:flutter/material.dart';
import '../models/timer.dart';
import '../services/timer_service.dart';

class CreateTimerDialog extends StatefulWidget {
  final VoidCallback onTimerCreated;
  final TimerData? timerToEdit;
  const CreateTimerDialog({
    super.key,
    required this.onTimerCreated,
    this.timerToEdit,
  });

  @override
  State<CreateTimerDialog> createState() => _CreateTimerDialogState();
}

class _CreateTimerDialogState extends State<CreateTimerDialog> {
  final nameController = TextEditingController(text: 'New Timer');

  final hoursController = TextEditingController(text: '0');
  final minutesController = TextEditingController(text: '5');
  final secondsController = TextEditingController(text: '0');

  Color selectedColor = Colors.blue;

  @override
  void dispose() {
    nameController.dispose();
    minutesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Create New Timer'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Timer Name'),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: hoursController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Hours'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: minutesController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Minutes'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: secondsController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Seconds'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 48),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: Colors.primaries.map((color) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedColor = color;
                    });
                  },
                  child: CircleAvatar(
                    backgroundColor: color,
                    child: selectedColor == color
                        ? const Icon(Icons.check, color: Colors.white)
                        : null,
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () async {
            final name = nameController.text.trim();
            final hours = int.tryParse(hoursController.text.trim()) ?? 0;
            final minutes = int.tryParse(minutesController.text.trim()) ?? 0;
            final seconds = int.tryParse(secondsController.text.trim()) ?? 0;

            if (name.isNotEmpty && minutes > 0) {
              final newTimer = TimerData.create(
                name: name,
                duration: Duration(
                  hours: hours,
                  minutes: minutes,
                  seconds: seconds,
                ),
                color: selectedColor,
              );

              await TimerService.addTimer(newTimer);
              widget.onTimerCreated();
              Navigator.of(context).pop();
            }
          },
          child: const Text('Create'),
        ),
      ],
    );
  }
}
