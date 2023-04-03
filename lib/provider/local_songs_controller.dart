import 'package:flutter/foundation.dart';
import 'package:on_audio_query/on_audio_query.dart';

class LocalSongs extends ChangeNotifier {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  bool _isLoading = false;

  List<SongModel> _filterdSong = [];
  List<SongModel> _allSong = [];

  List<SongModel> get filterdSongs => _filterdSong;
  bool get isLoading => _isLoading;

  LocalSongs() {
    getAllSongs();
  }

  setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<bool> reguestPermissions() async {
    if (!kIsWeb) {
      bool permissions = await _audioQuery.permissionsRequest();
      return permissions;
    }
    return false;
  }

  getAllSongs() async {
    bool permission = await reguestPermissions();
    if (permission) {
      _allSong = await filteredSongs();
      _filterdSong = await filteredSongs();
    } else {} 
    notifyListeners();
  }

  searchSongs(String songName) {
    _filterdSong.clear();
    for (var element in _allSong) {
      if (element.title.contains(songName)) {
        _filterdSong.add(element);
      }
    }
    notifyListeners();
  }

  Future<List<SongModel>> filteredSongs() async {
    setLoading(true);
    List<SongModel> temp = [];
    final songs = await _audioQuery.querySongs(
      sortType: SongSortType.DATE_ADDED,
      ignoreCase: false,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
    );
    for (var element in songs) {
      if (element.artist != null && element.artist != '<unknown>') {
        temp.add(element);
      }
    }
    setLoading(false);
    return temp;
  }
}
