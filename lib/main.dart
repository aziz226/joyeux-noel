import 'dart:math';

import 'package:flutter/material.dart';

import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.redAccent),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }

}

class SnowfallAndLightsScreen extends StatefulWidget {
  @override
  _SnowfallAndLightsScreenState createState() => _SnowfallAndLightsScreenState();
}

class _SnowfallAndLightsScreenState extends State<SnowfallAndLightsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Snowflake> _snowflakes;
  late List<TwinklingLight> _lights;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();

    _snowflakes = List.generate(150, (index) => Snowflake());
    _lights = List.generate(50, (index) => TwinklingLight());

    _controller.addListener(() {
      setState(() {
        _snowflakes.forEach((flake) => flake.update(MediaQuery.of(context).size));
        _lights.forEach((light) => light.update());
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.blue.shade900,
      body: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: SnowfallAndLightsPainter(_snowflakes, _lights, screenSize),
            ),
          ),
          Center(
            child: Text(
              "Joyeux Noël 🎄",
              style: TextStyle(
                fontSize: screenSize.width * 0.08,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(
                    blurRadius: 5.0,
                    color: Colors.black45,
                    offset: Offset(3.0, 3.0),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}






