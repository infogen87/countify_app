import 'package:countify/providers/count_provider.dart';
import 'package:countify/widgets/buttons.dart';
import 'package:countify/widgets/count_value_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CascadeStyle extends StatelessWidget {
  final CounterItem item;
  final int index;

  const CascadeStyle({super.key, required this.index, required this.item});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final buttonSize = (constraints.maxHeight * 0.22).clamp(90.0, 120.0);
        final spacing = (constraints.maxHeight * 0.05).clamp(16.0, 30.0);

        return Padding(
          padding: const EdgeInsets.all(30),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CountValueWidget(item: item, index: index),
                SizedBox(height: spacing),
                CounterButton(
                  icon: Icons.remove,
                  onTap: () =>
                      context.read<CountProvider>().decrementCount(index),
                  height: buttonSize,
                  width: buttonSize,
                  isCircular: true,
                ),
                SizedBox(height: spacing),
                CounterButton(
                  icon: Icons.add,
                  onTap: () =>
                      context.read<CountProvider>().incrementCount(index),
                  height: buttonSize,
                  width: buttonSize,
                  isCircular: true,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
