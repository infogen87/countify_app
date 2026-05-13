import 'package:countify/providers/count_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BigPlusButtonStyle extends StatelessWidget {
  final CounterItem item;
  final int index;

  const BigPlusButtonStyle({
    super.key,
    required this.item,
    required this.index,
  });

  Widget _buildMetalButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey[400],
          gradient: LinearGradient(
            colors: [Colors.grey[300]!, Colors.grey[600]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.5),
              offset: const Offset(2, 2),
              blurRadius: 4,
            ),
          ],
        ),
        child: Icon(icon, color: Colors.black87),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController countValueController = TextEditingController(
      text: item.value.toString(),
    );
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: GestureDetector(
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
                    height: 100,
                    decoration: BoxDecoration(color: Colors.yellow),
                    child: Center(
                      child: Text(
                        item.value.toString(),
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: context.read<CountProvider>().getItemColor(
                            index,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              _buildMetalButton(
                Icons.remove,
                () => context.read<CountProvider>().decrementCount(index),
              ),
              // GestureDetector(
              //   onTap: () {
              //     context.read<CountProvider>().decrementCount(index);
              //   },
              //   child: Container(
              //     height: 100,
              //     width: 60,
              //     color: Colors.blueGrey,
              //     child: Icon(Icons.remove),
              //   ),
              // ),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: GestureDetector(
              onTap: () {
                context.read<CountProvider>().incrementCount(index);
              },
              child: Container(
                decoration: BoxDecoration(color: Colors.purple),
                child: Icon(Icons.add),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
