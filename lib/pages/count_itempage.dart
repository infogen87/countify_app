// import 'dart:ffi';

import 'package:countify/providers/count_provider.dart';
import 'package:countify/widgets/big_plus_button_style.dart';
import 'package:countify/widgets/classic_style.dart';
import 'package:countify/widgets/default_style.dart';
import 'package:countify/widgets/ergonomic_style.dart';
import 'package:countify/widgets/ergonomic_with_thumb_rest_style.dart';
import 'package:countify/widgets/flip_tally_style.dart';
import 'package:countify/widgets/futuristic_style.dart';
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
      case "bigPlusButtonStyle":
        return BigPlusButtonStyle(item: item, index: theIndex);
      case "classicStyle":
        return ClassicStyle(item: item, index: theIndex);
      case "ergonomicStyle":
        return ErgonomicStyle(item: item, index: theIndex);
      case "ergonomicWithThumbRestStyle":
        return ErgonomicWithThumbRestStyle(item: item, index: theIndex);
      case "default":
        return DefaultStyle(item: item, index: theIndex);
      case "flipTallyStyle":
        return FlipTallyStyle(item: item, index: theIndex);
      case "futuristicStyle":
        return FuturisticStyle(item: item, index: theIndex);
      default:
        return DefaultStyle(item: item, index: theIndex);
    }
  }

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
              Navigator.pushNamed(context, "/edit_count", arguments: index);
            },
            icon: Icon(Icons.more_horiz),
          ),
        ],
      ),
      body: getBody(counterItem.counterStyle, counterItem, index),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/settings');
        },
        child: Icon(Icons.settings),
      ),
    );
  }
}
