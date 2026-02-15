import 'package:flutter/material.dart';

class FadeExample extends StatefulWidget {
  const FadeExample({super.key});

  @override
  FadeExampleState createState() => FadeExampleState();
}

class FadeExampleState extends State<FadeExample>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );

    animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeIn),
    );

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: Container(width: 100, height: 100, color: Colors.blue),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
