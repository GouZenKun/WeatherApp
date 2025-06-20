import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'shared_prefs.dart';

part 'app_theme.g.dart';

@Riverpod(keepAlive: true)
class AppTheme extends _$AppTheme {
  @override
  Future<bool> build() async {
    final pref = await ref.read(prefWithCacheProvider.future);
    return pref.getBool('isDarkMode') ?? ThemeMode.system == ThemeMode.dark;
  }

  Future<void> toggleTheme() async {
    if (state.isLoading || state.hasError) return;
    final pref = await ref.read(prefWithCacheProvider.future);
    await pref.setBool('isDarkMode', !state.requireValue);
    ref.invalidateSelf();
  }
}
