import 'package:usage_stats/usage_stats.dart';
  Future<int> getTodayUnlocks() async {
    try {
      final now = DateTime.now();
      final start = DateTime(now.year, now.month, now.day);
      final end = now;
      final events = await UsageStats.queryEvents(start, end);
      // Event type 7 = USER_PRESENT (unlock)
      return events.where((e) => e.eventType == '7').length;
    } catch (e) {
      return 0;
    }
  }

  Future<int> getTodayAppsUsed() async {
    try {
      final now = DateTime.now();
      final start = DateTime(now.year, now.month, now.day);
      final end = now;
      final events = await UsageStats.queryEvents(start, end);
      // Count unique package names that had a MOVE_TO_FOREGROUND event (type 1)
      final apps = events.where((e) => e.eventType == '1').map((e) => e.packageName).toSet();
      return apps.length;
    } catch (e) {
      return 0;
    }
  }

class UsageStatsService {
  Future<int> getTodayUnlocks() async {
    try {
      final now = DateTime.now();
      final start = DateTime(now.year, now.month, now.day);
      final end = now;
      final events = await UsageStats.queryEvents(start, end);
      // Event type 7 = USER_PRESENT (unlock)
      return events.where((e) => e.eventType == '7').length;
    } catch (e) {
      return 0;
    }
  }

  Future<int> getTodayAppsUsed() async {
    try {
      final now = DateTime.now();
      final start = DateTime(now.year, now.month, now.day);
      final end = now;
      final events = await UsageStats.queryEvents(start, end);
      // Count unique package names that had a MOVE_TO_FOREGROUND event (type 1)
      final apps = events.where((e) => e.eventType == '1').map((e) => e.packageName).toSet();
      return apps.length;
    } catch (e) {
      return 0;
    }
  }
  Future<bool> hasPermission() async {
    return await UsageStats.checkUsagePermission() ?? false;
  }

  Future<bool> requestPermission() async {
    try {
      await UsageStats.grantUsagePermission();
      return await hasPermission();
    } catch (e) {
      return false;
    }
  }

  Future<Duration> getTodayScreenTime() async {
    try {
      final now = DateTime.now();
      final start = DateTime(now.year, now.month, now.day);
      final end = now;
      final events = await UsageStats.queryEvents(start, end);
      // For demo, just count number of events as seconds.
      return Duration(seconds: events.length);
    } catch (e) {
      return Duration.zero;
    }
  }
}
