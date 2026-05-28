import 'package:countify/providers/count_provider.dart';
import 'package:countify/widgets/buttons.dart';
import 'package:countify/widgets/count_value_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CascadeStyle extends StatelessWidget {
  final CounterItem item;
  final int index;

  const CascadeStyle({
    super.key,
    required this.index,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CountValueWidget(item: item, index: index),
            SizedBox(height: 30),
            CounterButton(
              icon: Icons.add,
              onTap: () => context.read<CountProvider>().incrementCount(index),
              height: 120,
              width: 120,
              isCircular: true
            ),
            SizedBox(height: 30),
            CounterButton(
              icon: Icons.remove,
              onTap: () => context.read<CountProvider>().decrementCount(index),
              height: 120,
              width: 120,
              isCircular: true
            ),
          ],
        ),
      ),
    );
  }
}
