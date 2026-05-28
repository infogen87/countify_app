import 'package:countify/providers/count_provider.dart';
import 'package:countify/widgets/buttons.dart';
import 'package:countify/widgets/count_value_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class MinimalStyle extends StatelessWidget {
  final CounterItem item;
  final int index;

  const MinimalStyle({super.key, required this.item, required this.index});



  @override
  Widget build(BuildContext context) {
    // final TextEditingController countValueController = TextEditingController(
    //   text: item.value.toString(),
    // );
    return Container(
      decoration: const BoxDecoration(
        // gradient: RadialGradient(
        //   colors: [Color(0xFF0F2027), Color(0xFF203A43)],
        //   center: Alignment.center,
        // ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Glowing Number
          CountValueWidget(item: item, index: index),
          const SizedBox(height: 40),
          // Glassmorphic Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CounterButton(
              icon: Icons.remove,
              onTap: () => context.read<CountProvider>().decrementCount(index),
              height: 80,
              width: 80,
              isCircular: false
            ),
              const SizedBox(width: 30),
              CounterButton(
              icon: Icons.add,
              onTap: () => context.read<CountProvider>().incrementCount(index),
              height: 80,
              width: 80,
              isCircular: false
            ),
            ],
          ),
        ],
      ),
    );
  }
}
