import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/Models/Current_models.dart';
import 'package:weather_app/Models/Forecast_models.dart';
import 'package:weather_app/Utils/weather_utils.dart';
import 'package:http/http.dart'as Http;

class WeatherProvider extends ChangeNotifier{
 CurrentWeatherModel currentWeatherModel;
 ForecastWeatherModel forecastWeatherModel;

 Future getCurrentData(Position position) async {
   final status = await getFahrenheitStatus();
   final unit= status ? 'imperial' : "metric";
   final url = 'http://api.openweathermap.org/data/2.5/weather?lat=${position.latitude}&lon=${position.longitude}&units=$unit&appid=$weather_api_key';
   final response = await Http.get(Uri.parse(url));
   final map = json.decode(response.body);

   currentWeatherModel = CurrentWeatherModel.fromJson(map);
   print(currentWeatherModel.main.temp);
   notifyListeners();

 }

 Future getForecastData(Position position) async {
   final status = await getFahrenheitStatus();
   final unit= status ? 'imperial' : "metric";
   final url = 'http://api.openweathermap.org/data/2.5/forecast?lat=${position.latitude}&lon=${position.longitude}&units=$unit&appid=$weather_api_key';
   final response = await Http.get(Uri.parse(url));
   final map = json.decode(response.body);

   forecastWeatherModel = ForecastWeatherModel.fromJson(map);
   print(currentWeatherModel.main.temp);
   notifyListeners();

 }
}

