import 'package:flutter/foundation.dart';
import 'package:on_audio_query/on_audio_query.dart';

class LocalSongs extends ChangeNotifier {
  final OnAudioQuery _audioQuery = OnAudioQuery();

  List<SongModel> _allSong = [];

  List<SongModel> get allSongs => _allSong;

  LocalSongs() {
    getAllSongs();
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
    } else {
      print('Does not have permission');
    }
    notifyListeners();
  }

  Future<List<SongModel>> filteredSongs() async {
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
    return temp;
  }
}
