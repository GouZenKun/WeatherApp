import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:weather_app/home/models/models.dart';
import 'package:weather_app/services/language_service.dart';
import 'package:weather_app/widgets/widgets.dart';

class WeatherItem extends ConsumerWidget {
  const WeatherItem({super.key, required this.data, this.isFeature = false});

  final WeatherData data;
  final bool isFeature;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final langCode = getLangauge(ref);
    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding:
              isFeature
                  ? const EdgeInsets.only(
                    top: 20,
                    bottom: 20,
                    left: 20,
                    right: 0,
                  )
                  : const EdgeInsets.only(
                    top: 20,
                    bottom: 4,
                    left: 20,
                    right: 4,
                  ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blue[100],
              borderRadius:
                  isFeature
                      ? BorderRadius.circular(60)
                      : BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 5,
                  offset: Offset(0, 2), // changes position of shadow
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  right: isFeature ? -5 : -10,
                  bottom: isFeature ? -5 : -15,
                  child: Image.network(
                    'https://openweathermap.org/img/wn/${data.weatherIcon}@2x.png',
                    scale: isFeature ? 0.6 : 1,
                  ),
                ),
                Positioned(top: 0, right: 4, child: _temperature()),
              ],
            ),
          ),
        ),
        _day(langCode),
        _date(langCode),
        _current(langCode),
      ],
    );
  }

  Widget _temperature() => OutlinedText(
    text: Text(
      "${data.temperature}\u00BA",
      style: TextStyle(
        fontSize: isFeature ? 28 : 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    strokes: [OutlinedTextStroke(color: Colors.grey[600], width: 4)],
  );

  Widget _day(langCode) {
    return Positioned(
      top: 0,
      left: 0,
      child: OutlinedText(
        text: Text(
          DateFormat.E(langCode).format(data.dateTime),
          style: TextStyle(
            fontSize:
                langCode == "ja"
                    ? (isFeature ? 48 : 32)
                    : (isFeature ? 48 : 26),
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        strokes: [OutlinedTextStroke(color: Colors.red, width: 5)],
      ),
    );
  }

  Widget _date(langCode) {
    return Positioned(
      top: langCode == "ja" ? (isFeature ? 72 : 48) : (isFeature ? 63 : 36),
      left: langCode == "ja" ? 0 : 8,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          OutlinedText(
            text: Text(
              langCode == "ja"
                  ? DateFormat.M("ja").format(data.dateTime)
                  : DateFormat.MMM("en").format(data.dateTime),
              style: TextStyle(
                fontSize: isFeature ? 24 : 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            strokes: [OutlinedTextStroke(color: Colors.blue, width: 3)],
          ),
          OutlinedText(
            text: Text(
              DateFormat.d(langCode).format(data.dateTime),
              style: TextStyle(
                fontSize: isFeature ? 24 : 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            strokes: [OutlinedTextStroke(color: Colors.blue, width: 3)],
          ),
        ],
      ),
    );
  }

  Widget _current(langCode) {
    if (!isFeature) return Container();
    final text = langCode == "ja" ? "今日" : "Today";
    return Positioned(
      right: 15,
      bottom: 0,
      child: OutlinedText(
        text: Text(
          "($text ${DateFormat.Hm().format(data.dateTime)})",
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
        strokes: [OutlinedTextStroke(color: Colors.grey[800], width: 5)],
      ),
    );
  }
}
