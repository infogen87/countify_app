// import 'dart:ffi';

import 'package:countify/providers/count_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemCountPage extends StatefulWidget {
  const ItemCountPage({super.key});

  @override
  State<ItemCountPage> createState() => _ItemCountPageState();
}

class _ItemCountPageState extends State<ItemCountPage> {
  TextEditingController countController = TextEditingController();
  TextEditingController countValueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Catch the index passed from the previous screen, because i need the index for the provider functions on this screen
    final int index = ModalRoute.of(context)!.settings.arguments as int;
    final counterItem = context.watch<CountProvider>().items[index];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.chevron_left),
        ),
        title: Padding(
          padding: EdgeInsets.all(10),

          child: TextField(
            keyboardType: TextInputType.text,

            decoration: InputDecoration(
              hintText: "edit ${counterItem.name}...",
              hintStyle: TextStyle(color: Colors.blueGrey),
              border: InputBorder.none,
              // border: OutlineInputBorder(),
              fillColor: Colors.white,
              filled: true,
            ),
            controller: countController,
            onEditingComplete: () {
              String itemName = countController.text.trim();
              if (itemName.isNotEmpty) {
                context.read<CountProvider>().changeItemName(
                  countController.text,
                  index,
                );
                // Clears the text field after saving so the new hint shows
                countController.clear();
                FocusScope.of(context).unfocus(); // Closes the keyboard
              }
            },
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "/edit_count");
            },
            icon: Icon(Icons.more_horiz),
          ),
        ],
      ),
      body: Center(
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
                        color: context.watch<CountProvider>().getItemColor(
                          index,
                        ),
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/settings');
        },
        child: Icon(Icons.settings),
      ),
    );
  }
}
