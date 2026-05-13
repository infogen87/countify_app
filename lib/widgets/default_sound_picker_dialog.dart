// sound_picker_dialog.dart
import 'package:audioplayers/audioplayers.dart';
import 'package:countify/providers/setting_provider.dart';
import 'package:countify/widgets/sound_picker_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShowDefaultSoundPicker extends StatefulWidget {
  const ShowDefaultSoundPicker({super.key});

  @override
  State<ShowDefaultSoundPicker> createState() => _SoundPickerDialogState();
}

class _SoundPickerDialogState extends State<ShowDefaultSoundPicker> {
  late final AudioPlayer _player;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
  }

  @override
  void dispose() {
    _player.dispose(); // safely cleaned up when dialog closes
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Select Default Sound"),
      content: SizedBox(
        width: double.maxFinite,
        height: 300,
        child: ListView(
          children: soundEffects.keys.map((name) {
            return ListTile(
              title: Text(name),
              trailing: IconButton(
                onPressed: () => _player.play(AssetSource(soundEffects[name]!)),
                icon: const Icon(Icons.play_arrow),
              ),
              onTap: () {
                context.read<SettingsProvider>().setDefaultSound(name);
                Navigator.pop(context);
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
