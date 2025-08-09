
import 'package:flutter/material.dart';

void main() {
  runApp(const ScreenKingApp());
}

class ScreenKingApp extends StatelessWidget {
  const ScreenKingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Screen King',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.amber,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          elevation: 0.5,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Colors.amber,
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.white,
          showUnselectedLabels: true,
        ),
      ),
      home: const MainNavigation(),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  static final List<Widget> _screens = <Widget>[
    HomeScreen(),
    TasksScreen(),
    LeaderboardScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.flag_rounded),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard_rounded),
            label: 'Leaderboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Screen King',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.primary,
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: colorScheme.primary.withOpacity(0.1),
                    child: Icon(Icons.emoji_events, color: colorScheme.primary),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      Text('Today\'s Screen Time',
                          style: TextStyle(fontSize: 18, color: Colors.grey[700])),
                      const SizedBox(height: 8),
                      Text('4h 20m',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: colorScheme.primary,
                          )),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.star, color: colorScheme.primary, size: 20),
                          const SizedBox(width: 4),
                          Text('Points: 43',
                              style: TextStyle(fontSize: 16, color: Colors.black87)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Text('Quick Stats',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _StatCard(
                    icon: Icons.phone_android,
                    label: 'Unlocks',
                    value: '27',
                    color: colorScheme.secondary,
                  ),
                  _StatCard(
                    icon: Icons.apps,
                    label: 'Apps Used',
                    value: '12',
                    color: colorScheme.tertiary,
                  ),
                  _StatCard(
                    icon: Icons.battery_charging_full,
                    label: 'Battery',
                    value: '68%',
                    color: Colors.green,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 8),
            Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 4),
            Text(label, style: const TextStyle(fontSize: 13, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}

class TasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Daily Challenges',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: colorScheme.primary)),
            const SizedBox(height: 24),
            _ChallengeTile(
              icon: Icons.ondemand_video,
              title: 'Watch YouTube for 3 hours',
              progress: 0.7,
              color: Colors.redAccent,
            ),
            _ChallengeTile(
              icon: Icons.chat,
              title: 'Use WhatsApp for 1 hour',
              progress: 0.4,
              color: Colors.green,
            ),
            _ChallengeTile(
              icon: Icons.games,
              title: 'Play games for 2 hours',
              progress: 0.2,
              color: Colors.blueAccent,
            ),
          ],
        ),
      ),
    );
  }
}

class _ChallengeTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final double progress;
  final Color color;

  const _ChallengeTile({
    required this.icon,
    required this.title,
    required this.progress,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 18),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.15),
          child: Icon(icon, color: color),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6.0),
          child: LinearProgressIndicator(
            value: progress,
            color: color,
            backgroundColor: color.withOpacity(0.1),
            minHeight: 7,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        trailing: Text('${(progress * 100).toInt()}%', style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}

class LeaderboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Leaderboard',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: colorScheme.primary)),
            const SizedBox(height: 24),
            Expanded(
              child: ListView(
                children: [
                  _LeaderboardTile(rank: 1, name: 'You', points: 43, highlight: true),
                  _LeaderboardTile(rank: 2, name: 'Alex', points: 39),
                  _LeaderboardTile(rank: 3, name: 'Sam', points: 36),
                  _LeaderboardTile(rank: 4, name: 'Taylor', points: 32),
                  _LeaderboardTile(rank: 5, name: 'Jordan', points: 28),
                  _LeaderboardTile(rank: 6, name: 'Morgan', points: 25),
                  _LeaderboardTile(rank: 7, name: 'Casey', points: 22),
                  _LeaderboardTile(rank: 8, name: 'Jamie', points: 20),
                  _LeaderboardTile(rank: 9, name: 'Riley', points: 18),
                  _LeaderboardTile(rank: 10, name: 'Chris', points: 15),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LeaderboardTile extends StatelessWidget {
  final int rank;
  final String name;
  final int points;
  final bool highlight;

  const _LeaderboardTile({
    required this.rank,
    required this.name,
    required this.points,
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      color: highlight ? colorScheme.primary.withOpacity(0.1) : null,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: highlight ? colorScheme.primary : Colors.grey[300],
          child: Text('$rank', style: TextStyle(color: highlight ? Colors.white : Colors.black)),
        ),
        title: Text(name, style: TextStyle(fontWeight: FontWeight.w600, color: highlight ? colorScheme.primary : Colors.black)),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.star, color: colorScheme.primary, size: 18),
            const SizedBox(width: 4),
            Text('$points', style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 36,
                  backgroundColor: colorScheme.primary.withOpacity(0.15),
                  child: Icon(Icons.person, size: 40, color: colorScheme.primary),
                ),
                const SizedBox(width: 18),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('You', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text('Battery Killer', style: TextStyle(fontSize: 15, color: Colors.orange)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 32),
            Text('Badges', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                _BadgeTile(
                  icon: Icons.battery_charging_full,
                  label: 'Battery Killer',
                  color: Colors.orange,
                ),
                _BadgeTile(
                  icon: Icons.chat_bubble,
                  label: 'Social Media Lord',
                  color: Colors.blueAccent,
                ),
                _BadgeTile(
                  icon: Icons.ondemand_video,
                  label: 'Binge Watcher',
                  color: Colors.redAccent,
                ),
                _BadgeTile(
                  icon: Icons.games,
                  label: 'Game Addict',
                  color: Colors.green,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _BadgeTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _BadgeTile({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          backgroundColor: color.withOpacity(0.15),
          child: Icon(icon, color: color),
        ),
        const SizedBox(height: 6),
        Text(label, style: TextStyle(fontSize: 13, color: color, fontWeight: FontWeight.w600)),
      ],
    );
  }
}
