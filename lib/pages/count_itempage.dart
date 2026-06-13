// import 'dart:ffi';

import 'package:countify/providers/count_provider.dart';
import 'package:countify/widgets/focus_style.dart';
import 'package:countify/widgets/classic_style.dart';
import 'package:countify/widgets/cascade_style.dart';
// import 'package:countify/widgets/flip_tally_style.dart';
import 'package:countify/widgets/minimal_style.dart';
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

  Widget getBody(String styleName, CounterItem item, int theIndex) {
    switch (styleName) {
      case "focus Style":
        return FocusStyle(item: item, index: theIndex);
      case "cascade Style":
        return CascadeStyle(item: item, index: theIndex);
      case "classic Style":
        return ClassicStyle(item: item, index: theIndex);
      // case "flip Tally Style":
      //   return FlipTallyStyle(item: item, index: theIndex);
      case "minimal Style":
        return MinimalStyle(item: item, index: theIndex);
      default:
        return ClassicStyle(item: item, index: theIndex);
    }
  }

  String showAlert(CounterItem currentItem) {
    if (currentItem.value >= currentItem.maxLimit &&
        currentItem.isMaxAlertEnabled) {
      return "Max value reached!";
    }
    if (currentItem.value <= currentItem.minLimit &&
        currentItem.isMinAlertEnabled) {
      return "Min value reached!";
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    // Catch the index passed from the previous screen, because i need the index for the provider functions on this screen
    final int index = ModalRoute.of(context)!.settings.arguments as int;
    final counterItem = context.watch<CountProvider>().items[index];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
              hintStyle: TextStyle(color: Colors.grey[700]),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              // border: OutlineInputBorder(),
              // fillColor: Colors.white,
              // filled: true,
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
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Quick Tip"),
                    content: const Text(
                      "Click on the number to set it's initial value.",
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        style: TextButton.styleFrom(
                          backgroundColor: const Color.fromARGB(
                            255,
                            64,
                            41,
                            148,
                          ),
                        ),
                        child: Text(
                          "Ok",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            icon: Icon(Icons.lightbulb_outline),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "/edit_count", arguments: index);
            },
            icon: Icon(Icons.more_horiz),
          ),
        ],
        // flexibleSpace: Container(
        //   decoration: BoxDecoration(
        //     gradient: LinearGradient(
        //       end: Alignment.bottomCenter,
        //       begin: Alignment.bottomRight,
        //       colors: [Color(0xFFF2994A), Color(0xFFF2C94C)],
        //     ),
        //   ),
        // ),
      ),
      body: Column(
        children: [
          Builder(
            builder: (context) {
              final message = showAlert(counterItem);
              if (message.isEmpty) return const SizedBox.shrink();
              return Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    Icon(
                      Icons.report_problem_outlined,
                      color: const Color(0xFF455A64),
                    ),
                    SizedBox(width: 10),
                    Text(
                      message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFF455A64),
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          Expanded(
            child: getBody(counterItem.counterStyle, counterItem, index),
          ),
        ],
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
