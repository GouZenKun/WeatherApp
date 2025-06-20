import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:weather_app/error/for_display_exception.dart';

import 'package:weather_app/services/language_service.dart';
import 'package:weather_app/services/network_service.dart';
import 'package:weather_app/util/contants.dart';
import 'models.dart';

part 'weather_data.g.dart';

class WeatherListData {
  final List<WeatherData> list;

  WeatherListData({required this.list});

  WeatherListData.fromJson(Map<String, dynamic> json)
    : list =
          (json['list'] as List)
              .map((item) => WeatherData.fromJson(item))
              .toList();
}

class WeatherData {
  final DateTime dateTime;
  final String temperature;
  final String weatherIcon;

  WeatherData({
    required this.dateTime,
    required this.temperature,
    required this.weatherIcon,
  });

  WeatherData.fromJson(Map<String, dynamic> json)
    : dateTime = DateTime.parse(json['dt_txt']),
      temperature = json['main']['temp'].round().toString(),
      weatherIcon = json['weather'][0]['icon'];
}

@Riverpod(keepAlive: true)
Future<WeatherListData> fetchWeatherList(Ref ref) async {
  final loc = await ref.watch(fetchLocationDataProvider.future);
  final lat = loc.latitude;
  final lon = loc.longitude;
  final apiKey = dotenv.env['API_KEY'];
  final url = Uri.parse(
    'https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lon&appid=$apiKey&units=metric&cnt=40',
  );

  final response = await tryConnectTo(http.get(url), ref);

  if (response.statusCode == 200) {
    return WeatherListData.fromJson(jsonDecode(response.body));
  } else {
    throw ForDisplayException(
      'Failed to load weather data: ${response.statusCode}',
    );
  }
}
