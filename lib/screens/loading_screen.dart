import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app/screens/main_screen.dart';
import 'package:weather_app/utils/location.dart';

import '../utils/weather.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late LocationsHelper locationData;

  Future<void> getLocationData() async {
    locationData = LocationsHelper();
    await locationData.getCurrentLocation();
    if (locationData.latitude == null) {
      print("latitude is null");
    }
    if (locationData.longitude == null) {
      print("longitude is null");
    }
    if (locationData.latitude != null && locationData.longitude != null) {
      print("latitude:" + locationData.latitude.toString());
      print("longitude:" + locationData.longitude.toString());
    }
  }

  void getWeatherData() async {
    await getLocationData();
    if (locationData.latitude != null && locationData.longitude != null) {
      WeatherData weatherData = WeatherData(locationData: locationData);
      await weatherData.getCurrentTemperature();
      if (weatherData.currentCondition != null ||
          weatherData.currentTemperature != null) {
        print("Api çalışıyor  ");
      } else {
        print("Api'den sıcaklık veya durum bilgisi boş dönüyor");
      }

      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MainScreen(
              weatherdata: weatherData,
            ),
          ),
        );
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blueGrey, Colors.red],
          ),
        ),
        child: const Center(
          child: SpinKitFadingCircle(
            color: Colors.black,
            size: 150.0,
            duration: Duration(milliseconds: 1200),
          ),
        ),
      ),
    );
  }
}
