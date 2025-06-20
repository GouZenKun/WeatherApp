import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:weather_app/home/models/models.dart';
import 'package:weather_app/services/language_service.dart';
import 'package:weather_app/widgets/widgets.dart';

class WeatherTile extends ConsumerWidget {
  const WeatherTile({super.key, required this.data});

  final WeatherData data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final langCode = getLangauge(ref);
    final double screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      height: screenHeight * 0.1,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          OutlinedText(
            text: Text(
              DateFormat('MMMd H:mm', langCode).format(data.dateTime),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            strokes: [OutlinedTextStroke(color: Colors.grey[600], width: 3)],
          ),
          OutlinedText(
            text: Text(
              "${data.temperature}\u00BA",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            strokes: [OutlinedTextStroke(color: Colors.grey[600], width: 4)],
          ),

          Image.network(
            'https://openweathermap.org/img/wn/${data.weatherIcon}@2x.png',
          ),
        ],
      ),
    );
  }
}
