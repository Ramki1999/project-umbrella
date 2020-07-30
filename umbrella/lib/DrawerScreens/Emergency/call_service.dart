import 'package:url_launcher/url_launcher.dart';
import 'package:get_it/get_it.dart';

//Calling service for in-app calling
GetIt locator = GetIt();

class CallService {
  void call(String number) => launch("tel:$number");
}

void setupLocator() {
  locator.registerSingleton(CallService());
}
