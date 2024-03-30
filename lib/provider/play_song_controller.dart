import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class PlaySongController extends ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();

  bool _isPlay = false;
  bool _isPause = false;

  List _allSong = [];

  late var _currentDetail;

  late Duration lastDuration;

  bool get isPlay => _isPlay;
  bool get isPause => _isPause;
  dynamic get currentDetail => _currentDetail;
  AudioPlayer get audioPlayer => _audioPlayer;

  playSong(List songs, int index,
      {Duration duration = Duration.zero, bool isShuffle = false}) {
    if (songs.isNotEmpty) {
      setAllSong(songs);
      _audioPlayer.setAudioSource(
        ConcatenatingAudioSource(
          children:
              songs.map((e) => AudioSource.uri(Uri.parse(e.uri!))).toList(),
          shuffleOrder: isShuffle ? DefaultShuffleOrder() : null,
        ),
        initialIndex: index,
        initialPosition: duration,
        preload: true,
      );
      _audioPlayer.play();
      setCurrentSongDetail(_audioPlayer.currentIndex!);
      setIsPlay(_audioPlayer.playing);
      setIsPause(false);
      playerStream();
    }
  }

  setIsPlay(bool value) {
    _isPlay = value;
    notifyListeners();
  }

  setIsPause(bool value) {
    _isPause = value;
    notifyListeners();
  }

  setCurrentSongDetail(int index) {
    _currentDetail = _allSong[index];
    notifyListeners();
  }

  setAllSong(var value) {
    _allSong = value;
    notifyListeners();
  }

  playerStream() {
    _audioPlayer.durationStream.listen((event) {
      setCurrentSongDetail(_audioPlayer.currentIndex!);
    });
  }

  stopSong() {
    _audioPlayer.stop();
    setIsPlay(_audioPlayer.playing);
    setIsPause(false);
  }

  pauseSong() {
    _audioPlayer.pause();
    setIsPause(true);
    lastDuration = _audioPlayer.duration!;
  }

  nextSong() {
    _audioPlayer.seekToNext();
    if (_audioPlayer.hasNext) {
      setCurrentSongDetail(_audioPlayer.nextIndex!);
    }
  }

  previousSong() {
    _audioPlayer.seekToPrevious();
    if (_audioPlayer.hasPrevious) {
      setCurrentSongDetail(_audioPlayer.previousIndex!);
    }
  }
}
