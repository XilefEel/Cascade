import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cascade',
      theme: ThemeData(
        textTheme: GoogleFonts.plusJakartaSansTextTheme(),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        tooltip: 'New Timer',
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.timer), label: 'Timers'),
          BottomNavigationBarItem(icon: Icon(Icons.link), label: 'Chains'),
        ],
      ),
    );
  }
}

class TimerCard extends StatelessWidget {
  final TimerData timer;

  const TimerCard({super.key, required this.timer});

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
                  onPressed: () {},
                  icon: Icon(Icons.edit_outlined, color: timer.color),
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

class TimerData {
  final String name;
  final Duration duration;
  final Color color;

  TimerData({required this.name, required this.duration, required this.color});
}
