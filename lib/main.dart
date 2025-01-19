import 'package:exams/services/providers/exam_provider.dart';
import 'package:exams/services/providers/locations_provider.dart';
import 'package:exams/widgets/screens/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/navigation_service.dart';
import 'widgets/screens/home_screen.dart';
import 'widgets/screens/location_screen.dart';


void main() {
  final NavigationService navigationService = NavigationService();

  runApp(MyApp(navigationService: navigationService));
}

class MyApp extends StatelessWidget {
  final NavigationService navigationService;

  // Constructor to inject the NavigationService
  MyApp({required this.navigationService});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocationProvider()),
        ChangeNotifierProvider(create: (_) => ExamProvider()),
      ],
      child: MaterialApp(
        title: 'University App',
        navigatorKey: navigationService.navigatorKey, // Provide navigator key
        initialRoute: '/home',
        routes: {
          '/home': (context) => HomeScreen(navigationService: navigationService), // Inject NavigationService
          '/locations': (context) => LocationScreen(navigationService: navigationService), // Inject NavigationService
          '/map': (context) => LocationMapScreen(navigationService: navigationService,)
        },
      ),
    );
  }
}
