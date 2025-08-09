import 'package:usage_stats/usage_stats.dart';
import 'package:flutter/services.dart';

class UsageStatsService {
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
