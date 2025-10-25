import 'package:flutter/material.dart';
import '../models/cascade.dart';

class CascadeCard extends StatelessWidget {
  final CascadeData cascade;

  const CascadeCard({super.key, required this.cascade});

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

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      child: InkWell(
        onTap: () {},
        hoverColor: cascade.color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12.0),
        splashColor: cascade.color.withOpacity(0.2),
        highlightColor: cascade.color.withOpacity(0.1),
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
                          color: cascade.color,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cascade.name,
                              style: const TextStyle(fontSize: 17),
                            ),
                            Text(
                              formatDuration(cascade.totalDuration),
                              style: TextStyle(
                                fontSize: 14,
                                color: cascade.color,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.edit_outlined, color: cascade.color),
                  tooltip: 'Edit',
                ),
                IconButton(
                  onPressed: () {},
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
