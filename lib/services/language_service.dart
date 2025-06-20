import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:weather_app/util/shared_prefs/langauge_code.dart';

String getLangauge(ref) {
  final langCode = ref.watch(langaugeCodeProvider);
  return switch (langCode) {
    AsyncData(:final value) => value,
    _ => "",
  };
}
