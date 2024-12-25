import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{
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
    double widthSize= MediaQuery.of(context).size.width;
    double heightSize= MediaQuery.of(context).size.height;
    final screenSize = MediaQuery.of(context).size;

    final double fontSize = widthSize * 0.05;


    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Stack(
          children: [
            // Top Decorations
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Image.asset(
                height: heightSize,
                'assets/back.jpg', // Ajouter une image pour la guirlande
                fit: BoxFit.cover,
              ),
            ),
            // Star Decoration
            Positioned(
              top: 120,
              right: 40,
              child: Icon(
                Icons.star,
                size: 50,
                color: Colors.amber,
              ),
            ),
            // Balls and Ornaments


            Positioned.fill(
              child: CustomPaint(
                painter: SnowfallAndLightsPainter(_snowflakes, _lights, screenSize),
              ),
            ),

            // Text: "Wish you a Merry Christmas"
            Positioned(
              top: 200,
              left: widthSize/2.4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "SAFRIMAT GROUP",
                    style: GoogleFonts.abhayaLibre(
                      fontSize: fontSize,
                      foreground: Paint()..shader = LinearGradient(
                        colors: [Colors.white, Colors.white],
                      ).createShader(Rect.fromLTWH(0, 0, widthSize, fontSize)),
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          offset: Offset(5, 5),
                          blurRadius: 15,
                          color: Colors.white.withOpacity(0.5),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "vous souhaite",
                    style: GoogleFonts.abhayaLibre(
                      fontSize: fontSize,
                      foreground: Paint()..shader = LinearGradient(
                        colors: [Colors.white, Colors.white],
                      ).createShader(Rect.fromLTWH(0, 0, widthSize, fontSize)),
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          offset: Offset(5, 5),
                          blurRadius: 15,
                          color: Colors.white.withOpacity(0.5),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "Joyeux Noël 🎄",
                    style: GoogleFonts.arizonia(
                      fontSize: fontSize,
                      foreground: Paint()..shader = LinearGradient(
                        colors: [Colors.white, Colors.white],
                      ).createShader(Rect.fromLTWH(0, 0, widthSize, fontSize)),
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          offset: Offset(5, 5),
                          blurRadius: 15,
                          color: Colors.white.withOpacity(0.5),
                        ),
                      ],
                    ),
                  ),



                ],
              ),
            ),
            // Bottom Left Gifts
            Positioned(
              bottom: 20,
              left: 10,
              child: Row(
                children: [
                  Image.asset(
                    'assets/bottom.png', // Image de cadeau
                    height: 100,
                    width: 100,
                  ),
                ],
              ),
            ),
            // Social Media Links
            Positioned(
              bottom: 20,
              right: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "SAFRIMAT GROUP",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.phone, color: Colors.green, size: 24),
                      SizedBox(width: 8),
                      Icon(CupertinoIcons.globe, color: Colors.blue, size: 24),
                      SizedBox(width: 8),
                      Icon(Icons.facebook, color: Colors.pink, size: 24),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}

class Snowflake {
  static final Random random = Random();

  double x = random.nextDouble();
  double y = random.nextDouble();
  double radius = random.nextDouble() * 4 + 1;
  double speed = random.nextDouble() * 2 + 1;

  void update(Size screenSize) {
    y += speed / 1000; // Ajuste la vitesse pour être plus visible
    if (y > 1.0) {
      y = 0;
      x = random.nextDouble();
    }
  }
}

class TwinklingLight {
  static final Random random = Random();

  double x = random.nextDouble();
  double y = random.nextDouble();
  double radius = random.nextDouble() * 6 + 3;
  double opacity = random.nextDouble();
  double flickerSpeed = random.nextDouble() * 0.02 + 0.01;

  void update() {
    opacity += flickerSpeed;
    if (opacity > 1.0 || opacity < 0.2) {
      flickerSpeed = -flickerSpeed;
    }
  }
}

class SnowfallAndLightsPainter extends CustomPainter {
  final List<Snowflake> snowflakes;
  final List<TwinklingLight> lights;
  final Size screenSize;

  SnowfallAndLightsPainter(this.snowflakes, this.lights, this.screenSize);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint snowPaint = Paint()..color = Colors.white;
    final Paint lightPaint = Paint();

    // Dessiner les flocons de neige
    for (var flake in snowflakes) {
      canvas.drawCircle(
        Offset(flake.x * screenSize.width, flake.y * screenSize.height),
        flake.radius,
        snowPaint,
      );
    }

    // Dessiner les lumières scintillantes
    for (var light in lights) {
      lightPaint.color = Colors.primaries[Random().nextInt(Colors.primaries.length)]
          .withOpacity(light.opacity);
      canvas.drawCircle(
        Offset(light.x * screenSize.width, light.y * screenSize.height),
        light.radius,
        lightPaint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
