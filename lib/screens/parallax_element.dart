import 'package:flutter/material.dart';

class ParallaxElement extends StatelessWidget {
  final double top;
  final String image;

  const ParallaxElement({Key? key, required this.top, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;

    return Positioned(
      top: top,
      child: Container(
        width: _screenWidth,
        child: Image.asset(
          "images/$image.png",
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }
}
