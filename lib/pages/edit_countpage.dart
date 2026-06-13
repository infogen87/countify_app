import 'package:countify/providers/count_provider.dart';
import 'package:countify/utils/constants.dart';
import 'package:countify/widgets/alert_dialog.dart';
import 'package:countify/widgets/sound_picker_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final List<Map<String, dynamic>> counterPageStyles = [
  {
    'name': 'Focus',
    'key': 'focus Style',
    'image': "assets/images/focusStyle.png",
  },
  // {
  //   'name': 'Stacked',
  //   'key': 'stacked Style',
  //   'image': "/images/countifyCounterStyles.png",
  // },
  {
    'name': 'Cascade',
    'key': 'cascade Style',
    'image': "assets/images/cascadeStyle.png",
  },
  {
    'name': 'Classic',
    'key': 'classic Style',
    'image': "assets/images/CountifyAppIcon.png",
  },
  // {
  //   'name': 'Flip Tally',
  //   'key': 'flip Tally Style',
  //   'image': "assets/images/countifyCounterStyles.png",
  // },
  {
    'name': 'Minimal',
    'key': 'minimal Style',
    'image': "assets/images/minimalStyle.png",
  },
];

class EditCountPage extends StatelessWidget {
  const EditCountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final int index = ModalRoute.of(context)!.settings.arguments as int;
    final counterItem = context.watch<CountProvider>().items[index];

    return Scaffold(
      appBar: AppBar(
        title: Text("edit count"),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          onPressed: () {
            if (context.read<CountProvider>().items.isEmpty) {
              Navigator.of(
                context,
              ).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
            } else {
              Navigator.pop(context);
            }
          },
          icon: Icon(Icons.chevron_left),
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.notification_important_outlined),
            title: Text("Minimum Alert"),
            subtitle: Text(
              counterItem.isMinAlertEnabled
                  ? "min: ${counterItem.minLimit}"
                  : "Off",
              style: TextStyle(color: Colors.grey[600]),
            ),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              setAlertDialogState(
                context: context,
                title: "Minimum Alert",
                switchListTileTitle: "enable minimum limit",
                itemIndex: index,
                theCounterItem: counterItem,
                alertType: "min", //"min" or "max"
              );
            },
          ),

          // const Divider(),
          ListTile(
            leading: Icon(Icons.report_problem_outlined),
            title: Text("Maximum Alert"),
            subtitle: Text(
              counterItem.isMaxAlertEnabled
                  ? "max: ${counterItem.maxLimit}"
                  : "Off",
              style: TextStyle(color: Colors.grey[600]),
            ),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              setAlertDialogState(
                context: context,
                title: "Maximum Alert",
                switchListTileTitle: "enable maximum alert",
                itemIndex: index,
                theCounterItem: counterItem,
                alertType: "max",
              );
            },
          ),

          // const Divider(),
          ListTile(
            leading: Icon(Icons.campaign_outlined),
            title: Text("Alert sound"),
            subtitle: Text(
              counterItem.alertSound,
              style: TextStyle(color: Colors.grey[600]),
            ),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              showSoundPicker(
                theContext: context,
                title: "Select Alert Sound",
                itemIndex: index,
                soundType: 'alert',
              );
            },
          ),

          // const Divider(),
          ListTile(
            leading: Icon(Icons.campaign_outlined),
            title: Text("Plus sound"),
            subtitle: Text(
              counterItem.plusSound,
              style: TextStyle(color: Colors.grey[600]),
            ),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              showSoundPicker(
                theContext: context,
                title: "Select Plus Sound",
                itemIndex: index,
                soundType: 'plus',
              );
            },
          ),
          // const Divider(),
          ListTile(
            leading: Icon(Icons.campaign_outlined),
            title: Text("Minus sound"),
            subtitle: Text(
              counterItem.minusSound,
              style: TextStyle(color: Colors.grey[600]),
            ),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              showSoundPicker(
                theContext: context,
                title: "Select Minus Sound",
                itemIndex: index,
                soundType: 'minus',
              );
            },
          ),
          // const Divider(),
          ListTile(
            leading: Icon(Icons.palette_outlined),
            title: Text("Counter Style"),
            subtitle: Text(
              counterItem.counterStyle,
              style: TextStyle(color: Colors.grey[600]),
            ),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (itemCounterStyleContext) {
                  final selectedStyle = itemCounterStyleContext
                      .watch<CountProvider>()
                      .items[index]
                      .counterStyle;
                  return SafeArea(
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(
                        20,
                        20,
                        20,
                        30,
                      ), // Extra bottom padding for breathing room
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "select counter style",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: AppTheme.showModalHeaderSize,
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            height: 130,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: counterPageStyles.length,
                              itemBuilder: (context, indexStyle) {
                                final style = counterPageStyles[indexStyle];
                                final isSelected =
                                    selectedStyle == style["key"];

                                return GestureDetector(
                                  onTap: () {
                                    context
                                        .read<CountProvider>()
                                        .setCounterStyle(style["key"]!, index);
                                    // Navigator.pop(sheetContext);
                                  },
                                  child: Container(
                                    width: 100,
                                    margin: const EdgeInsets.only(right: 15),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: isSelected
                                            ? Color.fromARGB(255, 64, 41, 148)
                                            : Colors.grey,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height:
                                              50, // Bumped slightly from 40 to give the image more breathing room
                                          width: 50,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              6,
                                            ), // Subtle rounding matching your UI style
                                            child: Image.asset(
                                              style["image"],
                                              fit: BoxFit
                                                  .cover, // FIXED: Prevents squishing and layout overflows
                                            ),
                                          ),
                                        ),

                                        const SizedBox(height: 10),
                                        Text(
                                          style["name"]!,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontWeight: isSelected
                                                ? FontWeight.bold
                                                : FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
          // const Divider(),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
