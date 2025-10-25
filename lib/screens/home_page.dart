import 'package:cascade/models/timer.dart';
import 'package:cascade/screens/cascade_page.dart';
import 'package:flutter/material.dart';
import '../services/timer_service.dart';
import '../widgets/timer_dialog.dart';
import 'timer_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    loadTimers();
    _pageController = PageController();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  List<TimerData> timers = [];
  bool isLoading = true;

  Future<void> loadTimers() async {
    final loaded = await TimerService.getAllTimers();
    setState(() {
      timers = loaded;
      isLoading = false;
    });
  }

  void _showCreateTimerDialog() {
    showDialog(
      context: context,
      builder: (context) => CreateTimerDialog(onTimerCreated: loadTimers),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                _tabController.animateTo(index);
              },
              children: [
                TimersPage(timers: timers),
                const CascadesPage(),
              ],
            ),
          ),
          TabBar(
            controller: _tabController,
            labelColor: Theme.of(context).colorScheme.primary,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Theme.of(context).colorScheme.primary,
            onTap: (index) {
              _pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            tabs: const [
              Tab(icon: Icon(Icons.timer), text: 'Timers'),
              Tab(icon: Icon(Icons.layers), text: 'Cascades'),
            ],
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 24.0),
        child: FloatingActionButton(
          onPressed: () async {
            _showCreateTimerDialog();
          },
          tooltip: 'New Timer',
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          shape: const CircleBorder(),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
