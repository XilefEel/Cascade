import 'package:flutter/material.dart';
import '../widgets/cascade_card.dart';
import '../models/cascade.dart';

class CascadesPage extends StatelessWidget {
  const CascadesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final mockCascades = [
      CascadeData(
        name: 'Full Workout',
        timerCount: 5,
        totalDuration: const Duration(minutes: 15),
        color: Colors.purple,
      ),
      CascadeData(
        name: 'Morning Routine',
        timerCount: 3,
        totalDuration: const Duration(minutes: 8),
        color: Colors.orange,
      ),
      CascadeData(
        name: 'Study Session',
        timerCount: 4,
        totalDuration: const Duration(minutes: 50),
        color: Colors.blue,
      ),
    ];

    return ListView(
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
            'Cascades',
            style: TextStyle(
              fontSize: 32,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),

        ...mockCascades.map(
          (cascade) => Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: CascadeCard(cascade: cascade),
          ),
        ),
      ],
    );
  }
}
