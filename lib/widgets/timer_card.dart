import 'package:flutter/material.dart';
import '../models/timer.dart';
import '../services/timer_service.dart';
import 'timer_dialog.dart';

class TimerCard extends StatelessWidget {
  final TimerData timer;
  final VoidCallback onTimersChanged;

  const TimerCard({
    super.key,
    required this.timer,
    required this.onTimersChanged,
  });

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String hours = twoDigits(duration.inHours);
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));

    if (duration.inHours > 0) {
      return '$hours:$minutes:$seconds';
    } else {
      return '$minutes:$seconds';
    }
  }

  Future<void> deleteTimer(String id) async {
    await TimerService.deleteTimer(id);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      child: InkWell(
        onTap: () {},
        hoverColor: timer.color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12.0),
        splashColor: timer.color.withOpacity(0.2),
        highlightColor: timer.color.withOpacity(0.1),
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.0)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        width: 8,
                        height: 60,
                        decoration: BoxDecoration(
                          color: timer.color,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              timer.name,
                              style: const TextStyle(fontSize: 17),
                            ),
                            Text(
                              formatDuration(timer.duration),
                              style: TextStyle(
                                fontSize: 14,
                                color: timer.color,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => TimerDialog(
                        onTimerCreated: onTimersChanged,
                        timerToEdit: timer,
                      ),
                    );
                  },
                  icon: Icon(Icons.edit_outlined, color: timer.color),
                  tooltip: 'Edit',
                ),
                IconButton(
                  onPressed: () async {
                    await deleteTimer(timer.id);
                    onTimersChanged();
                  },
                  icon: Icon(Icons.delete_outlined, color: Colors.red[400]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
