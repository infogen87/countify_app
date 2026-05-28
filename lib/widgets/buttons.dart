import 'package:flutter/material.dart';

class CounterButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final double height;
  final double width;
  final bool isCircular;

  const CounterButton({
    super.key,
    required this.icon,
    required this.onTap,
    required this.height,
    required this.width,
    required this.isCircular
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          shape: isCircular? BoxShape.circle: BoxShape.rectangle,
          color: const Color.fromARGB(255, 64, 41, 148),
          borderRadius: isCircular? null : BorderRadius.circular(15),
        ),
        child: Icon(icon, color: Colors.white, size: 36),
      ),
    );
  }
}