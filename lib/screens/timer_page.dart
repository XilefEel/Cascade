import 'package:flutter/material.dart';
import '../models/timer.dart';
import '../widgets/timer_card.dart';

class TimersPage extends StatefulWidget {
  final List<TimerData> timers;
  final VoidCallback onTimersChanged;
  const TimersPage({
    super.key,
    required this.timers,
    required this.onTimersChanged,
  });

  @override
  State<TimersPage> createState() => _TimersPageState();
}

class _TimersPageState extends State<TimersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.only(
          top: 60.0,
          left: 20.0,
          right: 20.0,
          bottom: 100.0,
        ),
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: Text(
              'Timers',
              style: TextStyle(
                fontSize: 32,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),

          if (widget.timers.isEmpty)
            Center(
              child: Text(
                'No timers here! Tap the + button to add one.',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
            ),
          ...widget.timers.map(
            (timer) => Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: TimerCard(
                key: ValueKey(timer.id),
                timer: timer,
                onTimersChanged: widget.onTimersChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
