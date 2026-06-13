import 'package:auto_size_text/auto_size_text.dart';
import 'package:countify/providers/count_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CountValueWidget extends StatelessWidget {
  final CounterItem item;
  final int index;

  const CountValueWidget({super.key, required this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final TextEditingController countValueController =
            TextEditingController(text: item.value.toString());
        showDialog(
          context: context,
          builder: (dialogContext) {
            return StatefulBuilder(
              builder: (context, setState) {
                int? currentInputValue = int.tryParse(
                  countValueController.text,
                );
                bool isOverMaxLimit =
                    currentInputValue != null && currentInputValue > 1000000;
                bool isOverMinLimit = currentInputValue != null && currentInputValue < -1000000;    
                return AlertDialog(
                  title: Text("Set Value"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Set the initial value of your count"),
                      const SizedBox(height: 10),
                      TextField(
                        keyboardType: TextInputType.number,
                        controller: countValueController,
                        onChanged: (value) {
                          setState(() {});
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                      if (isOverMaxLimit)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "The initial value can't be greater than 1,000,000",
                            style: TextStyle(color: Colors.red, fontSize: 13),
                          ),
                        ),
                      if (isOverMinLimit)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "The initial value can't be lesser than -1,000,000",
                            style: TextStyle(color: Colors.red, fontSize: 13),
                          ),
                        ),  
                    ],
                  ),
                  actions: [
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 64, 41, 148),
                      ),
                      onPressed: () {
                        int? newValue = int.tryParse(countValueController.text);

                        if (newValue != null && newValue <= 1000000 && newValue >= -1000000) {
                          context.read<CountProvider>().setInitialValue(
                            newValue,
                            index,
                          );
                          Navigator.pop(dialogContext);
                          countValueController.clear();
                        }
                      },
                      child: Text(
                        "Set",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 64, 41, 148),
                      ),
                      onPressed: () {
                        Navigator.pop(dialogContext);
                      },
                      child: Text(
                        "Close",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        );
      },
      child: AutoSizeText(
        item.value.toString(),
        // item.value.toString().padLeft(3, '0'), // 001, 002...
        style: TextStyle(
          fontSize: 100,
          color: Theme.of(context).colorScheme.onSurface,
          fontFamily: 'Courier', // Or any Monospace font
          fontWeight: FontWeight.bold,
        ),
        maxLines: 1,
        minFontSize: 24, // ← Important: Don't let it get too small
        stepGranularity: 2.0,
      ),
    );
  }
}
