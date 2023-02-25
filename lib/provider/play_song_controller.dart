import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player/config/get_context.dart';
import 'package:music_player/provider/local_songs_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class PlaySongController extends ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();

  bool _isPlay = false;
  bool _isPause = false;

  List<SongModel> _allSong = [];

  late SongModel _currentDetail;

  late Duration lastDuration;

  bool get isPlay => _isPlay;
  bool get isPause => _isPause;
  SongModel get currentDetail => _currentDetail;
  AudioPlayer get audioPlayer => _audioPlayer;

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

  playSong(int index,
      {Duration duration = Duration.zero, bool isShuffle = false}) {
    _allSong =
        Provider.of<LocalSongs>(ctx.currentContext!, listen: false).allSongs;
    _audioPlayer.setAudioSource(
      ConcatenatingAudioSource(
        children:
            _allSong.map((e) => AudioSource.uri(Uri.parse(e.uri!))).toList(),
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
