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
  String? playingSound; // tracks which sound is playing, null = none

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();

    // Listen for when the audio finishes playing to reset the icon state automatically
    _player.onPlayerComplete.listen((event) {
      if (mounted) {
        setState(() {
          playingSound = null;
        });
      }
    });
  }

  @override
  void dispose() {
    _player.dispose(); // safely cleaned up when dialog closes
    super.dispose();
  }

  void _togglePlay(String name, String assetPath) async {
    if (playingSound == name) {
      // If clicking the currently playing sound, stop it
      await _player.stop();
      setState(() {
        playingSound = null;
      });
    } else {
      // If playing a new sound, stop any current sound and play the new one
      await _player.stop();
      await _player.play(AssetSource(assetPath));
      setState(() {
        playingSound = name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Removed StatefulBuilder since the widget itself holds the state perfectly
    return AlertDialog(
      title: const Text("Select Default Sound"),
      content: SizedBox(
        width: double.maxFinite,
        height: 300,
        child: ListView(
          children: soundEffects.keys.map((name) {
            final isThisPlaying = playingSound == name;

            return ListTile(
              title: Text(name),
              trailing: IconButton(
                onPressed: () => _togglePlay(name, soundEffects[name]!),
                icon: Icon(
                  isThisPlaying ? Icons.pause : Icons.play_arrow,
                ), // Removed 'const'
              ),
              onTap: () {
                // Good practice: stop audio before leaving the screen
                _player.stop();
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
