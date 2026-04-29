import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings"), centerTitle: true),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SwitchListTile(
              value: true,
              secondary: const Icon(Icons.brightness_4),
              title: const Text('Dark Mode'),
              onChanged: (value) {},
            ),
            const Divider(),
            SwitchListTile(
              value: true,
              secondary: const Icon(Icons.brightness_4),
              title: const Text('Dark Mode'),
              onChanged: (value) {},
            ),
            const Divider(),
            SwitchListTile(
              value: true,
              secondary: const Icon(Icons.brightness_4),
              title: const Text('Dark Mode'),
              onChanged: (value) {},
            ),
            const Divider(),
            ListTile(
              leading: Icon(Icons.sailing),
              title: Text("default sounds"),
              trailing: IconButton(
                onPressed: () {},
                icon: Icon(Icons.chevron_right),
              ),
            ),
            const Divider(),
            SwitchListTile(
              value: true,
              secondary: const Icon(Icons.brightness_4),
              title: const Text('Dark Mode'),
              onChanged: (value) {},
            ),
            const Divider(),
            ListTile(
              leading: Icon(Icons.sailing),
              title: Text("default sounds"),
              trailing: IconButton(
                onPressed: () {},
                icon: Icon(Icons.chevron_right),
              ),
            ),
            const Divider(),
            SwitchListTile(
              value: true,
              secondary: const Icon(Icons.brightness_4),
              title: const Text('Dark Mode'),
              onChanged: (value) {},
            ),
            const Divider(),
            ListTile(
              leading: Icon(Icons.sailing),
              title: Text("default sounds"),
              trailing: IconButton(
                onPressed: () {},
                icon: Icon(Icons.chevron_right),
              ),
            ),
            const Divider(),
            ListTile(
              leading: Icon(Icons.sailing),
              title: Text("default sounds"),
              trailing: IconButton(
                onPressed: () {},
                icon: Icon(Icons.chevron_right),
              ),
            ),
            const Divider(),
            ListTile(
              leading: Icon(Icons.sailing),
              title: Text("default sounds"),
              trailing: IconButton(
                onPressed: () {},
                icon: Icon(Icons.chevron_right),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
