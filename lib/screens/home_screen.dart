import 'package:flutter/material.dart';
import '../service/usage_stats_service.dart';
import 'package:battery_plus/battery_plus.dart';

var battery = Battery();

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Duration? _screenTime;
  int? _unlocks;
  int? _appsUsed;
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _checkAndRequestPermission();
  }

  Future<void> _checkAndRequestPermission() async {
    final usageService = UsageStatsService();
    bool hasPerm = await usageService.hasPermission();
    if (!hasPerm) {
      if (mounted) {
        await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: const Text('Permission Required'),
            content: const Text(
              'Screen King needs Usage Access Permission to track your screen time and app usage. Please grant it in the next screen.',
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  await usageService.requestPermission();
                  if (mounted) Navigator.of(context).pop();
                },
                child: const Text('Grant Permission'),
              ),
            ],
          ),
        );
      }
    }
    _fetchUsageStats();
  }

  Future<void> _fetchUsageStats() async {
    final usageService = UsageStatsService();
    bool hasPerm = await usageService.hasPermission();
    if (!hasPerm) {
      hasPerm = await usageService.requestPermission();
    }
    if (!hasPerm) {
      setState(() {
        _error = 'Permission denied';
        _loading = false;
      });
      return;
    }
    final duration = await usageService.getTodayScreenTime();
    final unlocks = await usageService.getTodayUnlocks();
    final appsUsed = await usageService.getTodayAppsUsed();
    setState(() {
      _screenTime = duration;
      _unlocks = unlocks;
      _appsUsed = appsUsed;
      _loading = false;
    });
  }

  String _formatDuration(Duration d) {
    if (d == Duration.zero) return '0m';
    final h = d.inHours;
    final m = d.inMinutes % 60;
    return h > 0 ? '${h}h ${m}m' : '${m}m';
  }

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
                      Text(
                        'Today\'s Screen Time',
                        style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                      ),
                      const SizedBox(height: 8),
                      _loading
                          ? const CircularProgressIndicator()
                          : _error != null
                          ? Text(
                              _error!,
                              style: TextStyle(color: colorScheme.error),
                            )
                          : Text(
                              _formatDuration(_screenTime ?? Duration.zero),
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: colorScheme.primary,
                              ),
                            ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.star,
                            color: colorScheme.primary,
                            size: 20,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Points: 43',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'Quick Stats',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _StatCard(
                    icon: Icons.phone_android,
                    label: 'Unlocks',
                    value: _loading ? '-' : (_unlocks?.toString() ?? '-'),
                    color: colorScheme.secondary,
                  ),
                  _StatCard(
                    icon: Icons.apps,
                    label: 'Apps Used',
                    value: _loading ? '-' : (_appsUsed?.toString() ?? '-'),
                    color: colorScheme.tertiary,
                  ),
                  _StatCard(
                    icon: Icons.battery_charging_full,
                    label: 'Battery',
                    value: await batter.batteryLevel,
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
            Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(fontSize: 13, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
