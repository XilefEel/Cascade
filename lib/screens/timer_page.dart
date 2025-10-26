import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../stores/timer_store.dart';
import '../widgets/timer_card.dart';

class TimersPage extends ConsumerWidget {
  const TimersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timers = ref.watch(timerProvider);

    void handleReorder(int oldIndex, int newIndex) {
      ref.read(timerProvider.notifier).reorderTimers(oldIndex, newIndex);
    }

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

          if (timers.isEmpty)
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
              itemCount: timers.length,
              onReorder: handleReorder,
              itemBuilder: (context, index) {
                final timer = timers[index];

                return Padding(
                  key: ValueKey(timer.id),
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    right: 20.0,
                    bottom: 12.0,
                  ),
                  child: TimerCard(index: index, timer: timer),
                );
              },
            ),

          SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }
}
