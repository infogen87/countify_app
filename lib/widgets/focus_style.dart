import 'package:countify/providers/count_provider.dart';
import 'package:countify/widgets/buttons.dart';
import 'package:countify/widgets/count_value_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class FocusStyle extends StatelessWidget {
  final CounterItem item;
  final int index;

  const FocusStyle({
    super.key,
    required this.item,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.height < 700;

    return LayoutBuilder(
      builder: (context, constraints) {
        // Make button sizes responsive
        final bigButtonSize = (constraints.maxWidth * 0.65).clamp(180.0, 280.0);
        final smallButtonSize = (bigButtonSize * 0.48).clamp(90.0, 130.0);

        return SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            padding: EdgeInsets.all(isSmallScreen ? 16 : 30),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Count Value + Minus Button Row
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: CountValueWidget(item: item, index: index),
                      ),
                      const SizedBox(width: 20),
                      CounterButton(
                        icon: Icons.remove,
                        onTap: () => context.read<CountProvider>().decrementCount(index),
                        height: smallButtonSize,
                        width: smallButtonSize,
                        isCircular: true,
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // Big Plus Button
                  CounterButton(
                    icon: Icons.add,
                    onTap: () => context.read<CountProvider>().incrementCount(index),
                    height: bigButtonSize,
                    width: bigButtonSize,
                    isCircular: true,
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}