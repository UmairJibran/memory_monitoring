import 'package:flutter/material.dart';
import 'package:memory_checkup/views/home.dart';

class AppRouter {
  Route? onGeneratedRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case "/":
        return MaterialPageRoute(
          builder: (ctx) => const MyHomePage(
            title: 'Pick Your JSON',
          ),
        );
      default:
        return null;
    }
  }
}
