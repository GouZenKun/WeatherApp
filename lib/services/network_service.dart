import 'dart:async';
import 'dart:io';

import 'package:geocoding/geocoding.dart';

import 'package:weather_app/error/for_display_exception.dart';
import 'package:weather_app/services/language_service.dart';
import 'package:weather_app/util/contants.dart';

Future<T> tryConnectTo<T>(Future<T> doConnection, ref) async {
  try {
    final response = await doConnection.timeout(const Duration(seconds: 60));
    return response;
  } on TimeoutException {
    throw ForDisplayException(
      getLangauge(ref) == "ja" ? timeoutErrorJP : timeoutErrorEN,
    );
  } on SocketException {
    throw ForDisplayException(
      getLangauge(ref) == "ja" ? socketErrorJP : socketErrorEN,
    );
  } on NoResultFoundException {
    throw ForDisplayException(
      getLangauge(ref) == "ja"
          ? '検索された都市は見つかりません。'
          : 'Could not find any result for the supplied address or coordinates.',
    );
  } on Error catch (e) {
    print("ERROR : $e");
    throw ForDisplayException(
      getLangauge(ref) == "ja" ? commonErrorJP : commonErrorEN,
    );
  }
}
