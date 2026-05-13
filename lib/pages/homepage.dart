import 'package:countify/providers/count_provider.dart';
import 'package:countify/providers/setting_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            if (context.read<CountProvider>().items.isNotEmpty) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Delete All"),
                    content: const Text(
                      "are you sure you want to delete all items?,this action cannot be undone",
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () {
                          context.read<CountProvider>().clearAll();
                          Navigator.pop(context);
                        },
                        child: const Text("Delete"),
                      ),
                    ],
                  );
                },
              );
            } else {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("No Items"),
                    content: const Text("there are no items to delete"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Close"),
                      ),
                    ],
                  );
                },
              );
            }
          },
          icon: Icon(Icons.delete),
        ),
        title: Text("Count list"),
        actions: [
          IconButton(
            icon: const Icon(Icons.swap_vert),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: const Icon(Icons.sort_by_alpha),
                      title: const Text("Sort by Name"),
                      onTap: () {
                        context.read<CountProvider>().toggleSort(SortType.name);
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.numbers),
                      title: const Text("Sort by Value"),
                      onTap: () {
                        context.read<CountProvider>().toggleSort(
                          SortType.value,
                        );
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.calendar_today),
                      title: const Text("Sort by Date Created"),
                      onTap: () {
                        context.read<CountProvider>().toggleSort(SortType.date);
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              );
            },
          ),
          IconButton(
            onPressed: () {
              context.read<SettingsProvider>().switchTheme(
                !context.read<SettingsProvider>().isDarkThemeEnabled,
              );
            },
            icon: context.watch<SettingsProvider>().isDarkThemeEnabled
                ? Icon(Icons.dark_mode)
                : Icon(Icons.light_mode),
          ),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  TextEditingController countTextController =
                      TextEditingController();

                  return AlertDialog(
                    title: TextField(
                      controller: countTextController,
                      decoration: InputDecoration(
                        hintText: "add new item eg cars...",
                        hintStyle: TextStyle(color: Colors.blueGrey),
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          final defaultCounterSound = context
                              .read<SettingsProvider>()
                              .defaultSounds;
                          final defaultCounterStyle = context
                              .read<SettingsProvider>()
                              .defaultCounterStyle;
                          String newItemName = countTextController.text.trim();

                          if (newItemName.isNotEmpty) {
                            context.read<CountProvider>().addItem(
                              newItemName,
                              defaultSound: defaultCounterSound,
                              defaultCounterStyle: defaultCounterStyle,
                            );
                          }

                          Navigator.pop(context);
                        },

                        style: TextButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        child: Text("add"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },

                        style: TextButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        child: Text("close"),
                      ),
                    ],
                  );
                },
              );
              // context.read<CountProvider>().addItem();
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: ListView.separated(
        itemCount: context.watch<CountProvider>().items.length,
        itemBuilder: (context, index) {
          // final item = myData[index];

          return Dismissible(
            key: Key(context.watch<CountProvider>().items[index].name),
            direction: DismissDirection.endToStart, // Swipe right-to-left
            background: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20),
              color: Colors.red,
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            onDismissed: (direction) {
              // Logic to remove the item from your list goes here later
              String msg = "${context.watch<CountProvider>().items[index].name} deleted";
              context.read<CountProvider>().deleteItem(index);
              SnackBar(content: Text(msg));
              
              
            },
            child: ListTile(
              onTap: () {
                Navigator.pushNamed(context, "/count_item", arguments: index);
              },
              tileColor: Colors.purple,
              leading: Text(
                context.watch<CountProvider>().items[index].value.toString(),
                style: TextStyle(
                  color: context.watch<CountProvider>().getItemColor(index),
                ),
              ),
              title: Text(context.watch<CountProvider>().items[index].name),
              trailing: IntrinsicHeight(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          context.read<CountProvider>().incrementCount(index);
                        },
                        icon: const Icon(Icons.add),
                      ),
                      const VerticalDivider(width: 2, thickness: 2),
                      IconButton(
                        onPressed: () {
                          context.read<CountProvider>().decrementCount(index);
                        },
                        icon: const Icon(Icons.remove),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) =>
            Divider(color: Colors.white, height: 2, thickness: 2),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/settings");
        },
        child: Icon(Icons.settings),
      ),
    );
  }
}
