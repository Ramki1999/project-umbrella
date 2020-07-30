import 'package:flutter/material.dart';
import 'package:umbrella/IntroScreens/HomeScreen.dart';
import 'package:umbrella/IntroScreens/SplashScreen.dart';
import 'package:bloc/bloc.dart';
import 'package:umbrella/TabScreens/Home_Weather/src/utils/converters.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:umbrella/DrawerScreens/Emergency/call_service.dart';

/// Using the BlOC Pattern to represent widgets as stream of events - Used for weather updates in HomeScreen
/// MyApp - Main widget that starts the splashScreen
void main() {
  setupLocator();
  BlocSupervisor().delegate = SimpleBlocDelegate();
  runApp(AppStateContainer(child: MyApp()));
}

const SHARED_PREF_KEY_TEMPERATURE_UNIT = "temp_unit";

class SimpleBlocDelegate extends BlocDelegate {
  @override
  onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }
}

class AppStateContainer extends StatefulWidget {
  final Widget child;

  AppStateContainer({@required this.child});

  @override
  _AppStateContainerState createState() => _AppStateContainerState();

  static _AppStateContainerState of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(_InheritedStateContainer)
            as _InheritedStateContainer)
        .data;
  }
}

class _AppStateContainerState extends State<AppStateContainer> {
  TemperatureUnit temperatureUnit = TemperatureUnit.celsius;

  @override
  initState() {
    super.initState();
    SharedPreferences.getInstance().then((sharedPref) {
      setState(() {
        temperatureUnit = TemperatureUnit.values[
            sharedPref.getInt(SHARED_PREF_KEY_TEMPERATURE_UNIT) ??
                TemperatureUnit.celsius.index];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedStateContainer(
      data: this,
      child: widget.child,
    );
  }

  updateTemperatureUnit(TemperatureUnit unit) {
    setState(() {
      this.temperatureUnit = unit;
    });
    SharedPreferences.getInstance().then((sharedPref) {
      sharedPref.setInt(SHARED_PREF_KEY_TEMPERATURE_UNIT, unit.index);
    });
  }
}

class _InheritedStateContainer extends InheritedWidget {
  final _AppStateContainerState data;

  const _InheritedStateContainer({
    Key key,
    @required this.data,
    @required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_InheritedStateContainer oldWidget) => true;
}

/// Opens Splash screen and moves to HomeScreen after animation is completed
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.white, accentColor: Colors.red),
      home: SplashScreen(),
      routes: <String, WidgetBuilder>{
        '/HomeScreen': (BuildContext context) => new HomeScreen()
      },
    );
  }
}
