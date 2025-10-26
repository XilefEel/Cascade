import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/timer.dart';

class TimerService {
  static const String _key = 'timers';

  static Future<List<TimerData>> getAllTimers() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);

    if (jsonString == null) return [];

    try {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      final timers = jsonList.map((e) => TimerData.fromJson(e)).toList();
      timers.sort((a, b) => a.orderIndex.compareTo(b.orderIndex));
      return timers;
    } catch (e) {
      return [];
    }
  }

  static Future<void> saveTimers(List<TimerData> timers) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(timers.map((t) => t.toJson()).toList());
    await prefs.setString(_key, jsonString);
  }

  static Future<void> addTimer(TimerData timer) async {
    final timers = await getAllTimers();
    timer.orderIndex = timers.length;
    timers.add(timer);
    await saveTimers(timers);
  }

  static Future<void> deleteTimer(String id) async {
    final timers = await getAllTimers();
    timers.removeWhere((t) => t.id == id);
    for (int i = 0; i < timers.length; i++) {
      timers[i].orderIndex = i;
    }
    await saveTimers(timers);
  }

  static Future<void> updateTimer(TimerData timer) async {
    final timers = await getAllTimers();
    final index = timers.indexWhere((t) => t.id == timer.id);
    timers[index] = timer;
    await saveTimers(timers);
  }

  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
