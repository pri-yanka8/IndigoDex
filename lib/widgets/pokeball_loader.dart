import 'package:flutter/material.dart';

class PokeballLoader extends StatefulWidget {
  const PokeballLoader({super.key});

  @override
  State<PokeballLoader> createState() => _PokeballLoaderState();
}

class _PokeballLoaderState extends State<PokeballLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: Image.asset('assets/images/pokeball.png', width: 44, height: 44),
    );
  }
}
