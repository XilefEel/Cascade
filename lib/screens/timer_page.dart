import 'package:flutter/material.dart';
import '../models/timer.dart';
import '../widgets/timer_card.dart';

class TimersPage extends StatefulWidget {
  const TimersPage({super.key});

  @override
  State<TimersPage> createState() => _TimersPageState();
}

class _TimersPageState extends State<TimersPage> {
  @override
  Widget build(BuildContext context) {
    final mockTimers = [
      TimerData(
        name: 'Rest 60s',
        duration: const Duration(seconds: 60),
        color: Colors.blue,
      ),
      TimerData(
        name: 'Plank',
        duration: const Duration(minutes: 3),
        color: Colors.green,
      ),
      TimerData(
        name: 'HIIT Round',
        duration: const Duration(seconds: 45),
        color: Colors.orange,
      ),
      TimerData(
        name: 'Cool Down',
        duration: const Duration(minutes: 5),
        color: Colors.purple,
      ),
      TimerData(
        name: 'Stretch',
        duration: const Duration(minutes: 10),
        color: Colors.red,
      ),
      TimerData(
        name: 'Rest 60s',
        duration: const Duration(seconds: 60),
        color: Colors.blue,
      ),
      TimerData(
        name: 'Plank',
        duration: const Duration(minutes: 3),
        color: Colors.green,
      ),
      TimerData(
        name: 'HIIT Round',
        duration: const Duration(seconds: 45),
        color: Colors.orange,
      ),
      TimerData(
        name: 'Cool Down',
        duration: const Duration(minutes: 5),
        color: Colors.purple,
      ),
      TimerData(
        name: 'Stretch',
        duration: const Duration(minutes: 10),
        color: Colors.red,
      ),
    ];
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.only(
          top: 48.0,
          left: 16.0,
          right: 16.0,
          bottom: 100.0,
        ),
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: Text(
              'Your Timers',
              style: TextStyle(
                fontSize: 32,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),

          ...mockTimers.map(
            (timer) => Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: TimerCard(timer: timer),
            ),
          ),
        ],
      ),
    );
  }
}
