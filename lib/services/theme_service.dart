import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:weather_app/util/shared_prefs/app_theme.dart';

bool getIsDarkMode(ref) {
  final isDarkMode = ref.watch(appThemeProvider);
  return switch (isDarkMode) {
    AsyncData(:final value) => value,
    _ => false,
  };
}
