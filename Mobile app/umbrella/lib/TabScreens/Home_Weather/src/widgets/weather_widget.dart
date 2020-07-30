import 'package:flutter/material.dart';
import 'package:umbrella/TabScreens/Home_Weather/src/model/weather.dart';
import 'package:umbrella/TabScreens/Home_Weather/src/widgets/forecast_horizontal_widget.dart';
import 'package:umbrella/TabScreens/Home_Weather/src/widgets/value_tile.dart';
import 'package:umbrella/TabScreens/Home_Weather/src/widgets/weather_swipe_pager.dart';
import 'package:intl/intl.dart';

class WeatherWidget extends StatelessWidget {
  final Weather weather;

  WeatherWidget({this.weather}) : assert(weather != null);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            this.weather.cityName.toUpperCase(),
            style: TextStyle(
                fontWeight: FontWeight.w900,
                letterSpacing: 5,
                color: Colors.red,
                fontSize: 25),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            this.weather.description.toUpperCase(),
            style: TextStyle(
                fontWeight: FontWeight.w100,
                letterSpacing: 5,
                fontSize: 15,
                color: Colors.blueGrey),
          ),
          WeatherSwipePager(weather: weather),
          Padding(
            child: Divider(color: Colors.grey),
            padding: EdgeInsets.all(10),
          ),
          ForecastHorizontal(weathers: weather.forecast),
          Padding(
            child: Divider(
              color: Colors.grey,
            ),
            padding: EdgeInsets.all(10),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            ValueTile("wind speed", '${this.weather.windSpeed} m/s'),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Center(
                  child: Container(width: 1, height: 30, color: Colors.red)),
            ),
            ValueTile(
                "sunrise",
                DateFormat('h:m a').format(DateTime.fromMillisecondsSinceEpoch(
                    this.weather.sunrise * 1000))),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Center(
                  child: Container(width: 1, height: 30, color: Colors.red)),
            ),
            ValueTile(
                "sunset",
                DateFormat('h:m a').format(DateTime.fromMillisecondsSinceEpoch(
                    this.weather.sunset * 1000))),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Center(
                  child: Container(
                width: 1,
                height: 30,
                color: Colors.red,
              )),
            ),
            ValueTile("humidity", '${this.weather.humidity}%'),
          ]),
        ],
      ),
    );
  }
}
