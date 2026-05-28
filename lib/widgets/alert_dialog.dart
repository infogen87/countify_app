import 'package:countify/providers/count_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void setAlertDialogState({
  required BuildContext context,
  required String title,
  required String switchListTileTitle,
  required int itemIndex,
  required CounterItem theCounterItem,
  required String alertType, //"min" or "max"
}) {
  bool isEnabled = (alertType == "min")
      ? theCounterItem.isMinAlertEnabled
      : theCounterItem.isMaxAlertEnabled;

  int initialValue = (alertType == "min")
      ? theCounterItem.minLimit
      : theCounterItem.maxLimit;

  TextEditingController theController = TextEditingController(
    text: initialValue.toString(),
  );

  showDialog(
    context: context,
    builder: (dialogContext) {
      //renaming the context for clarity
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text(title),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SwitchListTile(
                  title: Text(switchListTileTitle),
                  value: isEnabled,
                  onChanged: (bool value) {
                    setState(() {
                      isEnabled = value;
                    });
                  },
                ),

                if (isEnabled)
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: TextField(
                      controller: theController,
                      keyboardType: TextInputType.number,
                      autofocus: true, // Pop the keyboard up immediately
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: "Enter $alertType value...",
                      ),
                    ),
                  ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  int newVal = int.tryParse(theController.text) ?? initialValue;
                  if (alertType == "min") {
                    context.read<CountProvider>().setMinAlertState(
                      itemIndex,
                      isEnabled,
                      newVal,
                    );
                  } else {
                    context.read<CountProvider>().setMaxAlertState(
                      itemIndex,
                      isEnabled,
                      newVal,
                    );
                  }
                  Navigator.pop(dialogContext);
                },
                style: TextButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 64, 41, 148),
                ),
                child: const Text(
                  "Done",
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
  );
}
