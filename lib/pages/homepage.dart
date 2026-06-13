
import 'package:countify/providers/count_provider.dart';
import 'package:countify/providers/setting_provider.dart';
import 'package:countify/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    Widget emptyContent = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.inventory_2_outlined, size: 80, color: Colors.grey),
          const SizedBox(height: 16),
          Text(
            "No items added yet",
            style: TextStyle(color: Colors.grey[600], fontSize: 18),
          ),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          onPressed: () {
            if (context.read<CountProvider>().items.isNotEmpty) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Delete All"),
                    content: const Text(
                      "Delete all items? This action cannot be undone.",
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
                        child: const Text(
                          "Cancel",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          context.read<CountProvider>().clearAll();
                          Navigator.pop(context);
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: const Color.fromARGB(
                            255,
                            255,
                            10,
                            10,
                          ),
                        ),
                        child: const Text(
                          "Delete",
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
            } else {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("No Items"),
                    content: const Text("There are no items to delete"),
                    actions: [
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: const Color.fromARGB(
                            255,
                            64,
                            41,
                            148,
                          ),
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: const Text(
                          "Ok",
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
            }
          },
          icon: const Icon(Icons.delete),
        ),
        title: Text(
          "Count list",
          style: GoogleFonts.montserrat(
            textStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900, // Makes it a heavy block
              letterSpacing: -0.5,
            ),
          ),
        ),
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
                ? const Icon(Icons.dark_mode)
                : const Icon(Icons.light_mode),
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
                      decoration: const InputDecoration(
                        hintText: "Add new item eg rods...",
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
                          backgroundColor: const Color.fromARGB(
                            255,
                            64,
                            41,
                            148,
                          ),
                        ),
                        child: const Text(
                          "Add",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
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
                        child: const Text(
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
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: context.watch<CountProvider>().items.isEmpty
          ? emptyContent
          : ListView.builder(
              padding: const EdgeInsets.only(
                top: 8,
                bottom: 100
              ), // Padding at top and bottom of list
              itemCount: context.watch<CountProvider>().items.length,
              itemBuilder: (context, index) {
                // We grab the item info once per index using watch for the UI elements
                final currentItem = context.watch<CountProvider>().items[index];

                return Dismissible(
                  key: Key(currentItem.name),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ), // Matches card boundaries
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(
                        12,
                      ), // Smooth dismiss corners matching the card
                    ),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (direction) {
                    String msg = "${currentItem.name} deleted";
                    context.read<CountProvider>().deleteItem(index);
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(msg)));
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ), // This creates your clean gap
                    clipBehavior: Clip.antiAlias,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: ListTile(
                      visualDensity: VisualDensity(vertical: 4),
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          "/count_item",
                          arguments: index,
                        );
                      },
                      tileColor:
                          AppTheme.brandPurple, // Your beautiful old purple
                      leading: Text(//the autoSizedText widget needs its parent widget to have a definite size
                        currentItem.value.toString(),
                        style: GoogleFonts.inter(
                          textStyle: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: context.watch<CountProvider>().getItemColor(
                              index,
                            ),
                          ),
                        ),
                        maxLines: 1,
                      ),
                      title: Row(
                        children: [
                          Expanded(
                            child: Text(
                              currentItem.name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
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
                                  context.read<CountProvider>().incrementCount(
                                    index,
                                  );
                                },
                                icon: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              ),
                              const VerticalDivider(
                                width: 2,
                                thickness: 2,
                                color: Colors.white24,
                              ),
                              IconButton(
                                onPressed: () {
                                  context.read<CountProvider>().decrementCount(
                                    index,
                                  );
                                },
                                icon: const Icon(
                                  Icons.remove,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (context.watch<CountProvider>().items.isNotEmpty)
            FloatingActionButton(
              heroTag:
                  "quickTip_fab", //add a hero tag or set to null if you have more than one floating action button
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Quick Tip"),
                      content: const Text(
                        "Swipe left on an item to delete it.",
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
              child: const Icon(Icons.lightbulb_outline),
            ),
          SizedBox(height: 10),
          FloatingActionButton(
            heroTag: "settings_fab",
            onPressed: () {
              Navigator.pushNamed(context, "/settings");
            },
            child: const Icon(Icons.settings),
          ),
        ],
      ),
    );
  }
}
