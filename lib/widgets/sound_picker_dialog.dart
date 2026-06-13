import 'package:audioplayers/audioplayers.dart';
import 'package:countify/providers/count_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const Map<String, String> soundEffects = {
  'Default': 'sounds/pop_alert.mp3',
  'Liquid Bubble': 'sounds/liquid_bubble.wav',
  'Soap Bubble': 'sounds/soap_bubble.wav',
  'Sci-Fi Click': 'sounds/sci_fi_click.wav',
  'Select Click': 'sounds/select_click.wav',
  'Type Writer': 'sounds/type_writer.wav',
  'Water Bleep': 'sounds/water_bleep.wav', //i will modify later
};

void showSoundPicker({
  required BuildContext theContext,
  required String title,
  required int itemIndex,
  required String soundType,
}) {
  final player = AudioPlayer();
  String? playingSound; // tracks which sound is playing, null = none

  showDialog(
    context: theContext,
    builder: (context) {
      return StatefulBuilder(
        // ← Fix 1: allows setState inside dialog
        builder: (context, setState) {
          return AlertDialog(
            title: Text(title),
            content: SizedBox(
              width: double.maxFinite,
              height: 300,
              child: ListView(
                children: soundEffects.keys.map((name) {
                  final isThisPlaying =
                      playingSound == name; // ← Fix 4: per-tile state

                  return ListTile(
                    title: Text(name),
                    trailing: IconButton(
                      onPressed: () async {
                        if (isThisPlaying) {
                          await player.stop();
                          setState(() => playingSound = null);
                        } else {
                          await player.play(AssetSource(soundEffects[name]!));
                          setState(() => playingSound = name);

                          // Reset icon when sound finishes naturally
                          player.onPlayerComplete.listen((_) {
                            setState(() => playingSound = null);
                          });
                        }
                      },
                      icon: Icon(
                        // ← Fix 2 & 3: correct icon logic
                        isThisPlaying ? Icons.pause : Icons.play_arrow,
                      ),
                    ),
                    onTap: () {
                      final soundProvider = context.read<CountProvider>();
                      if (soundType == "alert") {
                        soundProvider.setAlertSound(name, itemIndex);
                      }
                      if (soundType == "plus") {
                        soundProvider.setPlusSound(name, itemIndex);
                      }
                      if (soundType == "minus") {
                        soundProvider.setMinusSound(name, itemIndex);
                      }

                      Navigator.pop(context);
                    },
                  );
                }).toList(),
              ),
            ),
          );
        },
      );
    },
  ).then((_) => player.dispose());
}
