import 'package:countify/providers/count_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ErgonomicWithThumbRestStyle extends StatelessWidget {
  final CounterItem item;
  final int index;

  const ErgonomicWithThumbRestStyle({
    super.key,
    required this.index,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController countValueController = TextEditingController(
      text: item.value.toString(),
    );
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (dialogContext) {
                  return AlertDialog(
                    title: Text("Set Value"),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("set the initial number of your count"),
                        TextField(
                          keyboardType: TextInputType.number,
                          controller: countValueController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          int? newValue = int.tryParse(
                            countValueController.text,
                          );

                          if (newValue != null) {
                            context.read<CountProvider>().setInitialValue(
                              newValue,
                              index,
                            );
                            Navigator.pop(dialogContext);
                            countValueController.clear();
                          }
                        },
                        child: Text("Set"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(dialogContext);
                        },
                        child: Text("Close"),
                      ),
                    ],
                  );
                },
              );
            },
            child: Container(
              decoration: BoxDecoration(color: Colors.yellow),
              child: Center(
                child: Text(
                  item.value.toString(),
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: context.read<CountProvider>().getItemColor(index),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 30),
          GestureDetector(
            onTap: () => context.read<CountProvider>().incrementCount(index),
            child: Container(
              height: 100,
              width: 60,
              color: Colors.blueGrey,
              child: Icon(Icons.add),
            ),
          ),
          SizedBox(height: 30),
          GestureDetector(
            onTap: () => context.read<CountProvider>().decrementCount(index),
            child: Container(
              height: 100,
              width: 60,
              color: Colors.blueGrey,
              child: Icon(Icons.remove),
            ),
          ),
        ],
      ),
    );
  }
}
