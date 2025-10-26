import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/timer.dart';
import '../services/timer_service.dart';

part 'timer_store.g.dart';

// Simple synchronous state - no AsyncValue needed for local storage
@Riverpod(keepAlive: true)
class TimerNotifier extends _$TimerNotifier {
  @override
  List<TimerData> build() {
    _loadTimers();
    return [];
  }

  Future<void> _loadTimers() async {
    state = await TimerService.getAllTimers();
  }

  // Add a timer
  Future<void> addTimer(TimerData timer) async {
    await TimerService.addTimer(timer);
    state = [...state, timer];
  }

  Future<void> updateTimer(TimerData timer) async {
    await TimerService.updateTimer(timer);
    state = state.map((t) => t.id == timer.id ? timer : t).toList();
  }

  Future<void> deleteTimer(String id) async {
    await TimerService.deleteTimer(id);
    state = state.where((t) => t.id != id).toList();
  }

  // Reorder timers
  Future<void> reorderTimers(int oldIndex, int newIndex) async {
    final newTimers = List<TimerData>.from(state);
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final timer = newTimers.removeAt(oldIndex);
    newTimers.insert(newIndex, timer);
    state = newTimers;

    await TimerService.reorderTimers(oldIndex, newIndex);
  }
}
