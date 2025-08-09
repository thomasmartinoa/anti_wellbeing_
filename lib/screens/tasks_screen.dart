import 'package:flutter/material.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Daily Challenges',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
              ),
            ),
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
            _ChallengeTile(
              icon: Icons.games,
              title: 'Use instagram for 2 hours',
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
        trailing: Text(
          '${(progress * 100).toInt()}%',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
