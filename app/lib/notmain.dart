import 'package:flutter/material.dart';

void main() => runApp(const TappApp());

class TappApp extends StatelessWidget {
  const TappApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tapp',
      theme: ThemeData.dark(),
      home: const Scaffold(
        body: Center(
          child: FadeInText(),
        ),
      ),
    );
  }
}

class FadeInText extends StatefulWidget {
  const FadeInText({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _FadeInTextState createState() => _FadeInTextState();
}

class _FadeInTextState extends State<FadeInText>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: const Text(
        'Tapp',
        style: TextStyle(
          color: Colors.white,
          fontSize: 48,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
