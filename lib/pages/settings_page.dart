import 'package:countify/pages/edit_countpage.dart';
import 'package:countify/providers/count_provider.dart';
import 'package:countify/providers/setting_provider.dart';
import 'package:countify/utils/url_helper.dart';
import 'package:countify/widgets/default_sound_picker_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // const Divider(),
            SwitchListTile(
              value: settings.isHepticsEnabled,
              secondary: const Icon(Icons.vibration),
              title: const Text('Vibrations'),
              onChanged: (value) {
                context.read<SettingsProvider>().toggleHeptics(value);
              },
            ),
            // const Divider(),
            SwitchListTile(
              value: settings.isSoundEnabled,
              secondary: const Icon(Icons.volume_up),
              title: const Text('Click Sounds'),
              onChanged: (value) {
                context.read<SettingsProvider>().toggleSounds(value);
              },
            ),
            // const Divider(),
            ListTile(
              leading: Icon(Icons.music_note),
              title: Text("Default Sounds"),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => ShowDefaultSoundPicker(),
                );
              },
            ),
            // const Divider(),
            SwitchListTile(
              value: settings.readNumbers,
              secondary: const Icon(Icons.record_voice_over),
              title: const Text('Read Out Numbers'),
              onChanged: (value) {
                context.read<SettingsProvider>().toggleReadNumbers(value);
              },
            ),
            // const Divider(),
            ListTile(
              leading: Icon(Icons.dashboard_customize),
              title: Text("Default Counter Style"),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (defaultStyleContext) {
                    final selectedStyle = defaultStyleContext
                        .watch<SettingsProvider>()
                        .defaultCounterStyle;
                    return Container(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "select default counter style",
                            style: TextStyle(),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            height: 160,
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
                                        .read<SettingsProvider>()
                                        .setDefaultCounterStyle(style["key"]!);
                                    // Navigator.pop(context);
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
                                        const SizedBox(height: 6),
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
                    );
                  },
                );
              },
            ),
            // const Divider(),
            SwitchListTile(
              value: settings.keepScreenActive,
              secondary: const Icon(Icons.lightbulb_outline),
              title: const Text('Screen Always On'),
              onChanged: (value) {
                context.read<SettingsProvider>().toggleAlwaysOn(value);
              },
            ),
            // const Divider(),
            SwitchListTile(
              value: settings.isDarkThemeEnabled,
              secondary: Icon(
                settings.isDarkThemeEnabled
                    ? Icons.dark_mode
                    : Icons.light_mode,
              ),
              title: const Text('Theme'),
              onChanged: (value) {
                context.read<SettingsProvider>().switchTheme(value);
              },
            ),
            // const Divider(),
            // ListTile(
            //   leading: Icon(Icons.auto_awesome),
            //   title: Text("Upgrade: Ad Free"),
            //   trailing: Icon(Icons.chevron_right),
            //   onTap: () {},
            // ),
            // const Divider(),
            ListTile(
              leading: Icon(Icons.restart_alt),
              title: Text("Reset All"),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Reset All"),
                      content: const Text(
                        "Warning: This deletes all counters and resets your settings to default. This action is permanent.",
                      ),
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
                          child: Text(
                            "Close",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: const Color.fromARGB(
                              255,
                              255,
                              10,
                              10,
                            ),
                          ),
                          onPressed: () {
                            context.read<CountProvider>().resetAll();
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Reset",
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
              trailing: Icon(Icons.chevron_right),
            ),
            // const Divider(),
            ListTile(
              leading: Icon(Icons.star_rate),
              title: Text("Rate The App"),
              trailing: Icon(Icons.chevron_right),
              onTap: () => UrlHelper.openPlayStoreForAppReview(),
            ),

            // const Divider(),
            ListTile(
              leading: Icon(Icons.help_outline),
              title: Text("Support"),
              trailing: Icon(Icons.chevron_right),
              onTap: () => UrlHelper.launchSupportEmail(),
            ),
            // const Divider(),
            ListTile(
              leading: Icon(Icons.gavel),
              title: Text("Privacy Policy"),
              trailing: Icon(Icons.chevron_right),
              onTap: () => UrlHelper.launchPrivacyPolicy(),
            ),
          ],
        ),
      ),
    );
  }

  
}
