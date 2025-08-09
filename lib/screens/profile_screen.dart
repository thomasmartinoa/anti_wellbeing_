import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
                  child: Icon(
                    Icons.person,
                    size: 40,
                    color: colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 18),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'You',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Battery Killer',
                      style: TextStyle(fontSize: 15, color: Colors.orange),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 32),
            Text(
              'Badges',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
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
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
