import 'package:flutter/material.dart';
import 'package:umbrella/TabScreens/Home_Weather/src/api/weather_api_client.dart';
import 'package:umbrella/TabScreens/Home_Weather/src/bloc/weather_bloc.dart';
import 'package:umbrella/TabScreens/Home_Weather/src/bloc/weather_event.dart';
import 'package:umbrella/TabScreens/Home_Weather/src/bloc/weather_state.dart';
import 'package:umbrella/TabScreens/Home_Weather/src/repository/weather_repository.dart';
import 'package:umbrella/secret.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umbrella/TabScreens/Home_Weather/src/widgets/weather_widget.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

enum OptionsMenu { changeCity, settings }

class WeatherScreen extends StatefulWidget {
  final WeatherRepository weatherRepository = WeatherRepository(
      weatherApiClient: WeatherApiClient(
          httpClient: http.Client(), apiKey: ApiKey.OPEN_WEATHER_MAP));
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen>
    with TickerProviderStateMixin {
  WeatherBloc _weatherBloc;
  String _cityName = 'chennai';
  AnimationController _fadeController;
  Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _weatherBloc = WeatherBloc(weatherRepository: widget.weatherRepository);
    _fetchWeatherWithLocation().catchError((error) {
      _fetchWeatherWithCity();
    });
    _fadeController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _fadeAnimation =
        CurvedAnimation(parent: _fadeController, curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          constraints: BoxConstraints.expand(),
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  //Location Search
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: TextFormField(
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.location_on,
                          color: Colors.black,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.search),
                          color: Colors.red,
                          onPressed: () {
                            _fetchWeatherWithCity();
                          },
                        ),
                        prefixStyle: TextStyle(color: Colors.black),
                        fillColor: Colors.white.withOpacity(0.1),
                        filled: true,
                        isDense: true,
                        hintStyle: TextStyle(color: Colors.grey),
                        labelStyle: TextStyle(color: Colors.red),
                        focusColor: Colors.red,
                        border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(20.0),
                          ),
                          borderSide: new BorderSide(
                            color: Colors.red,
                            width: 1.0,
                          ),
                        ),
                        focusedBorder: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(20.0),
                          ),
                          borderSide: new BorderSide(
                            color: Colors.red,
                            width: 1.0,
                          ),
                        ),
                        hintText: 'Location',
                        labelText: "Change Location",
                      ),
                      onChanged: (text) {
                        _cityName = text;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  BlocBuilder(
                      bloc: _weatherBloc,
                      builder: (_, WeatherState weatherState) {
                        if (weatherState is WeatherLoaded) {
                          this._cityName = weatherState.weather.cityName;
                          _fadeController.reset();
                          _fadeController.forward();
                          return WeatherWidget(
                            weather: weatherState.weather,
                          );
                        } else if (weatherState is WeatherError ||
                            weatherState is WeatherEmpty) {
                          String errorText =
                              'There was an error fetching weather data';
                          if (weatherState is WeatherError) {
                            if (weatherState.errorCode == 404) {
                              errorText =
                                  'We have trouble fetching weather for $_cityName';
                            }
                          }
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.error_outline,
                                color: Colors.redAccent,
                                size: 24,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                errorText,
                                style: TextStyle(color: Colors.red),
                              ),
                              FlatButton(
                                child: Text(
                                  "Try Again",
                                  style: TextStyle(color: Colors.red),
                                ),
                                onPressed: _fetchWeatherWithCity,
                              )
                            ],
                          );
                        } else if (weatherState is WeatherLoading) {
                          return Center(
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                        return Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.red,
                          ),
                        );
                      }),
                ],
              ),
            ),
          ),
        ));
  }

  _fetchWeatherWithCity() {
    _weatherBloc.dispatch(FetchWeather(cityName: _cityName));
  }

  _fetchWeatherWithLocation() async {
    var permissionHandler = PermissionHandler();
    var permissionResult = await permissionHandler
        .requestPermissions([PermissionGroup.locationWhenInUse]);

    switch (permissionResult[PermissionGroup.locationWhenInUse]) {
      case PermissionStatus.denied:
      case PermissionStatus.unknown:
        print('location permission denied');
        _showLocationDeniedDialog(permissionHandler);
        throw Error();
    }

    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    _weatherBloc.dispatch(FetchWeather(
        longitude: position.longitude, latitude: position.latitude));
  }

  void _showLocationDeniedDialog(PermissionHandler permissionHandler) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text('Location is disabled :(',
                style: TextStyle(color: Colors.black)),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  'Enable!',
                  style: TextStyle(color: Colors.green, fontSize: 16),
                ),
                onPressed: () {
                  permissionHandler.openAppSettings();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
