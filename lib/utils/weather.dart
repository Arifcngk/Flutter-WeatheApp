import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

import 'location.dart';

const apiKeyy = "c31650b1bc8d43330de4e011853e14e7";

class WeatherDisplayData {
  final Icon weatherIcon;
  final AssetImage weatherImage;

  WeatherDisplayData({required this.weatherIcon, required this.weatherImage});
}

class WeatherData {
  final LocationsHelper locationData;
  late double currentTemperature;
  late int currentCondition;
  late String city;

  WeatherData({required this.locationData}) {
    getCurrentTemperature();
  }

  Future<void> getCurrentTemperature() async {
    var url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=${locationData.latitude}&lon=${locationData.longitude}&appid=$apiKeyy&units=metric");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      String data = response.body;
      try {
        var currentWeather = jsonDecode(data);
        currentTemperature = currentWeather['main']['temp'];
        currentCondition = currentWeather['weather'][0]['id'];
        // Update the city name as well
        city = currentWeather['name'];
        locationData.city = city;
      } catch (e) {
        print(e);
      }
    } else {
      print("API Çalışmıyor");
    }
  }

  WeatherDisplayData getWeatherDisplayData() {
    var now = DateTime.now();
    bool isDaytime = (now.hour >= 6 && now.hour < 18); // Gündüz saatleri
    if (currentCondition < 600) {
      return WeatherDisplayData(
          weatherIcon: const Icon(
            FontAwesomeIcons.cloud,
            size: 105,
            color: Colors.white,
          ),
          weatherImage: const AssetImage("assets/yağmurlu1.jpg"));
    } else {
      if (isDaytime) {
        return WeatherDisplayData(
            weatherIcon: const Icon(
              FontAwesomeIcons.sun,
              size: 105,
              color: Colors.white,
            ),
            weatherImage: const AssetImage("assets/güneşli.jpg"));
      } else {
        return WeatherDisplayData(
            weatherIcon: const Icon(
              FontAwesomeIcons.moon,
              size: 105,
              color: Colors.white,
            ),
            weatherImage: const AssetImage("assets/gece.jpg"));
      }
    }
  }
}
