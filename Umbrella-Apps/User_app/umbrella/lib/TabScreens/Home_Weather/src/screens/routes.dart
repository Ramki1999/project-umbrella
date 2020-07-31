import 'package:flutter/material.dart';
import 'package:umbrella/DrawerScreens//Settings.dart';
import 'package:umbrella/TabScreens/Home_Weather/src/screens/weather_screen.dart';

class Routes {
  static final mainRoute = <String, WidgetBuilder>{
    '/home': (context) => WeatherScreen(),
    '/settings': (context) => SettingsScreen(),
  };
}
