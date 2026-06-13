import 'package:countify/providers/count_provider.dart';
import 'package:countify/widgets/buttons.dart';
import 'package:countify/widgets/count_value_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClassicStyle extends StatelessWidget {
  final CounterItem item;
  final int index;

  const ClassicStyle({super.key, required this.index, required this.item});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: SizedBox(
          height: 500,
          width: 500,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CountValueWidget(item: item, index: index),
              const SizedBox(height: 50),
              Row(
                // mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CounterButton(
                    icon: Icons.add,
                    onTap: () =>
                        context.read<CountProvider>().incrementCount(index),
                    height: 120,
                    width: 120,
                    isCircular: true,
                  ),
                  CounterButton(
                    icon: Icons.remove,
                    onTap: () =>
                        context.read<CountProvider>().decrementCount(index),
                    height: 120,
                    width: 120,
                    isCircular: true,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
