import 'package:countify/providers/count_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditCountPage extends StatelessWidget {
  const EditCountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("edit count"), centerTitle: true),
      body: Column(
        children: [
          ListTile(
            leading: Icon(Icons.sailing),
            title: Text("Minimum Alert"),
            trailing: IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (minAlertContext) {
                    return AlertDialog(
                      title: Text("Minimum Alert"),
                      content: SwitchListTile(
                        value: false,
                        onChanged: (value) {
                          TextEditingController minAlertController =
                              TextEditingController();
                          TextField(
                            controller: minAlertController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "set min alert value...",
                            ),
                            onEditingComplete: () {
                              int newMinValue = int.parse(minAlertController.text);
                              context.read<CountProvider>().setMinValue(newMinValue, index);
                            },
                          );
                        },
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(minAlertContext);
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          child: Text("Close"),
                        ),
                      ],
                    );
                  },
                );
              },
              icon: Icon(Icons.chevron_right),
            ),
          ),
          const Divider(),

          ListTile(
            leading: Icon(Icons.sailing),
            title: Text("Maximum Alert"),
            trailing: IconButton(
              onPressed: () {},
              icon: Icon(Icons.chevron_right),
            ),
          ),
          const Divider(),

          ListTile(
            leading: Icon(Icons.sailing),
            title: Text("Alert sound"),
            trailing: IconButton(
              onPressed: () {},
              icon: Icon(Icons.chevron_right),
            ),
          ),
          const Divider(),

          ListTile(
            leading: Icon(Icons.sailing),
            title: Text("Plus sound"),
            trailing: IconButton(
              onPressed: () {},
              icon: Icon(Icons.chevron_right),
            ),
          ),
          const Divider(),
          ListTile(
            leading: Icon(Icons.sailing),
            title: Text("Minus sound"),
            trailing: IconButton(
              onPressed: () {},
              icon: Icon(Icons.chevron_right),
            ),
          ),
          const Divider(),
          ListTile(
            leading: Icon(Icons.sailing),
            title: Text("counter Style"),
            trailing: IconButton(
              onPressed: () {},
              icon: Icon(Icons.chevron_right),
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
