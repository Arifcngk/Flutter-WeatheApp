import 'package:flutter/material.dart';
import 'package:weather_app/utils/weather.dart';

class MainScreen extends StatefulWidget {
  final WeatherData weatherdata;
  const MainScreen({Key? key, required this.weatherdata}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int temperature;
  late Icon weatherDisplayIcon;
  late AssetImage backgroundImage;
  late String city;

  void updateDisplayInfo(WeatherData weatherData) {
    setState(() {
      temperature = weatherData.currentTemperature.round();
      WeatherDisplayData weatherDisplayData =
          weatherData.getWeatherDisplayData();
      city = weatherData.city;
      backgroundImage = weatherDisplayData.weatherImage;
      weatherDisplayIcon = weatherDisplayData.weatherIcon;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateDisplayInfo(widget.weatherdata);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: BoxDecoration(
            image: DecorationImage(image: backgroundImage, fit: BoxFit.cover)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 40),
            Container(child: weatherDisplayIcon),
            const SizedBox(height: 40),
            Center(
              child: Text(
                "$temperature°",
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 80,
                    color: Colors.white,
                    letterSpacing: -9),
              ),
            ),
            const SizedBox(height: 40),
            Center(
              child: Text(
                city,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
