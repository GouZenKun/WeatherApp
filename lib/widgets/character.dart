import 'dart:async';

import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:weather_app/services/language_service.dart';

class Character extends ConsumerStatefulWidget {
  const Character({super.key});
  @override
  ConsumerState<Character> createState() => _CharacterState();
}

class _CharacterState extends ConsumerState<Character>
    with TickerProviderStateMixin {
  late final AnimationController _charaScaleController;
  late final Animation<double> _charaScaleAnimation;
  late final AnimationController _bubbleScaleController;
  late final Animation<double> _bubbleScaleAnimation;
  late final AnimationController _bubbleFadeOutController;
  late final Animation<double> _bubbleFadeOutAnimation;

  @override
  void initState() {
    super.initState();
    _charaScaleController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _charaScaleAnimation = Tween(begin: 0.98, end: 1.0).animate(
      CurvedAnimation(parent: _charaScaleController, curve: Curves.ease),
    );

    _bubbleScaleController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _bubbleScaleAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _bubbleScaleController, curve: Curves.easeInCirc),
    );

    _bubbleFadeOutController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _bubbleFadeOutAnimation = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _bubbleFadeOutController,
        curve: Curves.fastOutSlowIn,
      ),
    );

    _bubbleScaleController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Timer(Duration(seconds: 3), () {
          _bubbleFadeOutController.forward();
        });
      }
    });

    Timer.periodic(Duration(seconds: 7), (_) {
      _bubbleFadeOutController.reset();
      _bubbleScaleController.reset();
      _bubbleScaleController.forward();
    });
    _bubbleScaleController.forward();
  }

  @override
  void dispose() {
    _charaScaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double contentAreaWidth = screenWidth * 1.5;
    final double contentAreaHeight = screenHeight;

    final String langCode = getLangauge(ref);

    return Stack(
      children: [
        SizedBox(width: screenWidth, height: screenHeight),
        Positioned(
          bottom: 0,
          right: -screenWidth * 0.7,
          child: Container(
            width: contentAreaWidth,
            height: contentAreaHeight,
            alignment: Alignment.bottomRight,
            // color: Colors.pinkAccent,
            padding: EdgeInsets.only(bottom: screenWidth * 0.1),
            child: ScaleTransition(
              scale: _charaScaleAnimation,
              alignment: Alignment.bottomCenter,
              child: IgnorePointer(
                child: Image.asset(
                  "assets/images/BaleenChan.webp",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: screenWidth * 0.1,
          child: Container(
            width: screenWidth * 0.9,
            height: screenHeight * 0.2,
            alignment: Alignment.center,
            child: FadeTransition(
              opacity: _bubbleFadeOutAnimation,
              child: ScaleTransition(
                scale: _bubbleScaleAnimation,
                alignment: Alignment.topRight,
                child: Bubble(
                  alignment: Alignment.bottomCenter,
                  nip: BubbleNip.rightTop,
                  nipWidth: 20,
                  nipHeight: 50,
                  padding: BubbleEdges.all(36),
                  margin: BubbleEdges.all(24),
                  radius: Radius.circular(20.0),
                  elevation: 10,
                  color: Colors.amber[100],
                  child: Text(
                    langCode == "ja"
                        ? "いい天気ですね。\n散歩しましょう！"
                        : "Nice Weather. \nLet's take a walk!",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
