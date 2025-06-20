import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:weather_app/error/for_display_exception.dart';

import 'package:weather_app/services/language_service.dart';
import 'package:weather_app/services/network_service.dart';
import 'package:weather_app/util/contants.dart';

part 'search_data.g.dart';

@riverpod
class SearchParam extends _$SearchParam {
  @override
  String build() {
    return getLangauge(ref) == "ja" ? "東京" : "Tokyo";
  }

  void setParam(String param) {
    if (param == "") return;
    state = param;
  }
}

class LocationData {
  final double latitude;
  final double longitude;

  LocationData({required this.latitude, required this.longitude});
}

@riverpod
Future<LocationData> fetchLocationData(Ref ref) async {
  final String param = ref.watch(searchParamProvider);

  List<Location> locations = await tryConnectTo(
    locationFromAddress(param),
    ref,
  );

  return LocationData(
    latitude: locations[0].latitude,
    longitude: locations[0].longitude,
  );
}
