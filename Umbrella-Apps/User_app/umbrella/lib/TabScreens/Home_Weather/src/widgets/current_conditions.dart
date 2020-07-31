import 'package:flutter/material.dart';
import 'package:umbrella/main.dart';
import 'package:umbrella/TabScreens/Home_Weather/src/model/weather.dart';
import 'package:umbrella/TabScreens/Home_Weather/src/widgets/value_tile.dart';

/// Renders Weather Icon, current, min and max temperatures
class CurrentConditions extends StatelessWidget {
  final Weather weather;
  const CurrentConditions({Key key, this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          weather.getIconData(),
          color: Colors.black,
          size: 70,
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          '${this.weather.temperature.as(AppStateContainer.of(context).temperatureUnit).round()}°',
          style: TextStyle(
              fontSize: 100, fontWeight: FontWeight.w100, color: Colors.black),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          ValueTile("max",
              '${this.weather.maxTemperature.as(AppStateContainer.of(context).temperatureUnit).round()}°'),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Center(
                child: Container(
              width: 1,
              height: 30,
              color: Colors.red,
            )),
          ),
          ValueTile("min",
              '${this.weather.minTemperature.as(AppStateContainer.of(context).temperatureUnit).round()}°'),
        ]),
      ],
    );
  }
}
