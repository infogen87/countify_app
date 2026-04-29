import 'package:countify/providers/count_provider.dart';
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
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
        title: Text("Count list"),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.swap_vert)),
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
                          String newItemName = countTextController.text.trim();

                          if (newItemName.isNotEmpty) {
                            context.read<CountProvider>().addItem(newItemName);
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
              print(
                "${context.watch<CountProvider>().items[index].name} deleted",
              );
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
