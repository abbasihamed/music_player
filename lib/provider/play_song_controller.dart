import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class PlaySongController extends ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();

  play(String uri) {
    _audioPlayer.setAudioSource(
      AudioSource.uri(Uri.parse(uri)),
    );
    _audioPlayer.play();
  }
}
