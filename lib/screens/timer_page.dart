import 'package:flutter/material.dart';
import '../models/timer.dart';
import '../services/timer_service.dart';
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
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 60.0,
                left: 20.0,
                right: 20.0,
                bottom: 24.0,
              ),
              child: Text(
                'Timers',
                style: TextStyle(
                  fontSize: 32,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ),

          if (widget.timers.isEmpty)
            SliverFillRemaining(
              child: Center(
                child: Text(
                  'No timers here! Tap the + button to add one.',
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          else
            SliverReorderableList(
              itemCount: widget.timers.length,
              onReorder: (oldIndex, newIndex) async {
                await TimerService.reorderTimers(oldIndex, newIndex);
                widget.onTimersChanged();
              },
              itemBuilder: (context, index) {
                final timer = widget.timers[index];

                return Padding(
                  key: ValueKey(timer.id),
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    right: 20.0,
                    bottom: 12.0,
                  ),
                  child: TimerCard(
                    index: index,
                    timer: timer,
                    onTimersChanged: widget.onTimersChanged,
                  ),
                );
              },
            ),

          SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }
}
