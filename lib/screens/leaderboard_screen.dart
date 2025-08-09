import 'package:flutter/material.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

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
              'Leaderboard',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView(
                children: [
                  _LeaderboardTile(
                    rank: 1,
                    name: 'You',
                    points: 43,
                    highlight: true,
                  ),
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
          child: Text(
            '$rank',
            style: TextStyle(color: highlight ? Colors.white : Colors.black),
          ),
        ),
        title: Text(
          name,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: highlight ? colorScheme.primary : Colors.black,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.star, color: colorScheme.primary, size: 18),
            const SizedBox(width: 4),
            Text(
              '$points',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
