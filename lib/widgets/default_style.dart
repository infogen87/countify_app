import 'package:countify/providers/count_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DefaultStyle extends StatelessWidget {
  final CounterItem item;
  final int index;

  const DefaultStyle({super.key, required this.index, required this.item});

  @override
  Widget build(BuildContext context) {
    final TextEditingController countValueController = TextEditingController(
      text: item.value.toString(),
    );

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            int? initialValue = int.tryParse(
                              countValueController.text,
                            );

                            if (initialValue != null) {
                              context.read<CountProvider>().setInitialValue(
                                initialValue,
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
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(color: Colors.yellow),
                child: Center(
                  child: Text(
                    context
                        .watch<CountProvider>()
                        .items[index]
                        .value
                        .toString(),
                    style: TextStyle(
                      color: context.watch<CountProvider>().getItemColor(index),
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    context.read<CountProvider>().decrementCount(index);
                  },
                  child: Container(
                    decoration: BoxDecoration(color: Colors.purple),
                    child: Icon(Icons.remove),
                  ),
                ),
                SizedBox(width: 20),
                GestureDetector(
                  onTap: () {
                    context.read<CountProvider>().incrementCount(index);
                  },
                  child: Container(
                    decoration: BoxDecoration(color: Colors.purple),
                    child: Icon(Icons.add),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
