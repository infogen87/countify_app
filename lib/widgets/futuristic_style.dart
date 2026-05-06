import 'package:countify/providers/count_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FuturisticStyle extends StatelessWidget {
  final CounterItem item;
  final int index;

  const FuturisticStyle({super.key, required this.item, required this.index});

  // Helper function for the Futuristic Style
  Widget _buildNeonButton(String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.cyanAccent.withValues(alpha: 0.5),
            width: 1,
          ),
          color: Colors.cyanAccent.withValues(alpha: 0.05), // Very faint fill
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 40,
              color: Colors.cyanAccent,
              shadows: [
                Shadow(
                  blurRadius: 10,
                  color: Colors.cyanAccent.withValues(alpha: 0.7),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          colors: [Color(0xFF0F2027), Color(0xFF203A43)],
          center: Alignment.center,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Glowing Number
          Text(
            item.value.toString(),
            style: TextStyle(
              fontSize: 120,
              color: Colors.cyanAccent,
              fontWeight: FontWeight.w100,
              shadows: [
                Shadow(
                  blurRadius: 20,
                  color: Colors.cyanAccent.withValues(alpha: 0.8),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          // Glassmorphic Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildNeonButton(
                "-",
                () => context.read<CountProvider>().decrementCount(index),
              ),
              const SizedBox(width: 30),
              _buildNeonButton(
                "+",
                () => context.read<CountProvider>().incrementCount(index),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
