import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/timer.dart';
import '../stores/timer_store.dart';

class TimerDialog extends ConsumerStatefulWidget {
  final TimerData? timerToEdit;

  const TimerDialog({super.key, this.timerToEdit});

  @override
  ConsumerState<TimerDialog> createState() => _TimerDialogState();
}

class _TimerDialogState extends ConsumerState<TimerDialog> {
  late final TextEditingController nameController;
  late final TextEditingController hoursController;
  late final TextEditingController minutesController;
  late final TextEditingController secondsController;
  late Color selectedColor;

  @override
  void initState() {
    super.initState();
    if (widget.timerToEdit != null) {
      final timer = widget.timerToEdit!;
      final hours = timer.duration.inHours;
      final minutes = timer.duration.inMinutes.remainder(60);
      final seconds = timer.duration.inSeconds.remainder(60);

      nameController = TextEditingController(text: timer.name);
      hoursController = TextEditingController(text: hours.toString());
      minutesController = TextEditingController(text: minutes.toString());
      secondsController = TextEditingController(text: seconds.toString());
      selectedColor = timer.color;
    } else {
      nameController = TextEditingController(text: 'New Timer');
      hoursController = TextEditingController(text: '0');
      minutesController = TextEditingController(text: '5');
      secondsController = TextEditingController(text: '0');
      selectedColor = Colors.blue;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    hoursController.dispose();
    minutesController.dispose();
    secondsController.dispose();
    super.dispose();
  }

  bool get isEditMode => widget.timerToEdit != null;

  void handleSubmit() async {
    final name = nameController.text.trim();
    final hours = int.tryParse(hoursController.text.trim()) ?? 0;
    final minutes = int.tryParse(minutesController.text.trim()) ?? 0;
    final seconds = int.tryParse(secondsController.text.trim()) ?? 0;

    if (name.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please enter a name')));
      return;
    }

    final totalSeconds = hours * 3600 + minutes * 60 + seconds;
    if (totalSeconds <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Duration must be greater than 0')),
      );
      return;
    }

    try {
      if (isEditMode) {
        await ref
            .read(timerProvider.notifier)
            .updateTimer(
              TimerData(
                id: widget.timerToEdit!.id,
                name: name,
                duration: Duration(seconds: totalSeconds),
                color: selectedColor,
                orderIndex: widget.timerToEdit!.orderIndex,
              ),
            );
      } else {
        await ref
            .read(timerProvider.notifier)
            .addTimer(
              TimerData.create(
                name: name,
                duration: Duration(seconds: totalSeconds),
                color: selectedColor,
                orderIndex: 0,
              ),
            );
      }

      if (!mounted) return;
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Failed to save timer')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(isEditMode ? 'Edit Timer' : 'Create New Timer'),
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
          onPressed: handleSubmit,
          child: Text(isEditMode ? 'Save' : 'Create'),
        ),
      ],
    );
  }
}
