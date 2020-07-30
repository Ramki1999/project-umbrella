import 'package:flutter/material.dart';
import 'package:umbrella/TabScreens/Home_Weather/src/screens/routes.dart';
import 'package:umbrella/TabScreens/Home_Weather/src/screens/weather_screen.dart';

///Uses the OpenWeather API to collect weather data and show various data analytics to the user
///It uses the BLOC pattern to manage all widget and states as events.
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Weather App',
      debugShowCheckedModeBanner: false,
      home: WeatherScreen(),
      routes: Routes.mainRoute,
    );
  }
}
