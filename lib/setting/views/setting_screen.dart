import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/services/language_service.dart';

import 'package:weather_app/services/theme_service.dart';
import 'package:weather_app/widgets/widgets.dart';
import 'package:weather_app/util/shared_prefs/app_theme.dart';
import 'package:weather_app/util/shared_prefs/langauge_code.dart';

class SettingScreen extends ConsumerWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title:
            getLangauge(ref) == "ja"
                ? const Text('設定')
                : const Text('Settings'),
        actions: [NavButton()],
        backgroundColor: Colors.lightBlue,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: screenHeight * 0.2,
              alignment: Alignment.topCenter,
              // color: Colors.lightGreen,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [_darkSwitch(ref), _langDropdown(ref)],
              ),
            ),
            Character(),
          ],
        ),
      ),
    );
  }

  Widget _darkSwitch(ref) {
    return SwitchListTile(
      title:
          getLangauge(ref) == "ja"
              ? const Text('ダークモード')
              : const Text('Dark Mode'),
      value: getIsDarkMode(ref),
      onChanged: (value) {
        ref.read(appThemeProvider.notifier).toggleTheme();
      },
    );
  }

  Widget _langDropdown(ref) {
    return ListTile(
      title:
          getLangauge(ref) == "ja" ? const Text('言語') : const Text('Langauge'),
      trailing: DropdownButton(
        items:
            ["ja", "en"].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(value: value, child: Text(value));
            }).toList(),
        onChanged: (value) {
          ref.read(langaugeCodeProvider.notifier).toggleLangauge();
        },
        value: getLangauge(ref),
      ),
    );
  }
}
