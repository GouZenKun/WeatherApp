import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:weather_app/services/language_service.dart';
import 'package:weather_app/home/widgets/widgets.dart';
import 'package:weather_app/widgets/widgets.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title:
            getLangauge(ref) == "ja" ? const Text('ホーム') : const Text('Home'),
        actions: [NavButton()],
        backgroundColor: Colors.lightBlue,
      ),
      body: SafeArea(
        child: Container(
          height: screenHeight,
          width: screenWidth,
          alignment: Alignment.center,
          child: Stack(
            children: [
              Container(
                height: screenHeight * 0.8,
                margin: EdgeInsets.all(16),
                decoration: ShapeDecoration(shape: RoundedRectangleBorder()),
                child: Column(
                  children: [
                    SearchLocation(contentHeight: screenHeight * 0.15),
                    WeatherTable(
                      contentHeight: screenHeight * 0.4,
                      contentWidth: screenWidth,
                    ),
                  ],
                ),
              ),
              Character(),
            ],
          ),
        ),
      ),
    );
  }
}
