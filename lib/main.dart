import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/home_screen.dart';
import 'screens/tasks_screen.dart';
import 'screens/leaderboard_screen.dart';
import 'screens/profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ScreenKingApp());
}

class ScreenKingApp extends StatelessWidget {
  const ScreenKingApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Tokyo Night color palette
    const background = Color(0xFF1A1B26);
    const surface = Color(0xFF24283B);
    const primary = Color(0xFF7AA2F7);
    const secondary = Color(0xFFBB9AF7);
    const error = Color(0xFFF7768E);
    const onPrimary = Color(0xFF1A1B26);
    const onSurface = Color(0xFFC0CAF5);
    const onSecondary = Color(0xFF1A1B26);

    final tokyoNightColorScheme = ColorScheme(
      brightness: Brightness.dark,
      primary: primary,
      onPrimary: onPrimary,
      secondary: secondary,
      onSecondary: onSecondary,
      error: error,
      onError: Colors.white,
      surface: surface,
      onSurface: onSurface,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Screen King',
      theme: ThemeData(
        colorScheme: tokyoNightColorScheme,
        useMaterial3: true,
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: background,
        appBarTheme: AppBarTheme(
          backgroundColor: surface,
          foregroundColor: onSurface,
          elevation: 0.5,
          iconTheme: IconThemeData(color: primary),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: primary,
          unselectedItemColor: onSurface.withOpacity(0.5),
          backgroundColor: surface,
          showUnselectedLabels: true,
        ),
        cardColor: surface,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: onSurface),
          bodyMedium: TextStyle(color: onSurface),
          bodySmall: TextStyle(color: onSurface),
        ),
        iconTheme: const IconThemeData(color: primary),
      ),
      darkTheme: ThemeData(
        colorScheme: tokyoNightColorScheme,
        useMaterial3: true,
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: background,
        appBarTheme: AppBarTheme(
          backgroundColor: surface,
          foregroundColor: onSurface,
          elevation: 0.5,
          iconTheme: IconThemeData(color: primary),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: primary,
          unselectedItemColor: onSurface.withOpacity(0.5),
          backgroundColor: surface,
          showUnselectedLabels: true,
        ),
        cardColor: surface,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: onSurface),
          bodyMedium: TextStyle(color: onSurface),
          bodySmall: TextStyle(color: onSurface),
        ),
        iconTheme: const IconThemeData(color: primary),
      ),
      themeMode: ThemeMode.dark,
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
