import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_player/data/hive_model/play_list.dart';
import 'package:music_player/data/hive_model/songs.dart';

import 'package:music_player/data/local/play_list_storage.dart';

class PlayListDbImp implements PlayListDb {
  final String _playListBox = 'playList';
  final String _songsBox = 'songs';

  @override
  Future<bool> initDb() async {
    try {
      await Hive.initFlutter();
      Hive.registerAdapter(PlayListAdapter());
      Hive.registerAdapter(SongsAdapter());
      await Hive.openBox<PlayList>(_playListBox);
      await Hive.openBox<Songs>(_songsBox);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future createPlayList({required String listName, Songs? song}) async {
    final playList = Hive.box<PlayList>(_playListBox);
    final list = PlayList(listName: listName);
    if (song != null) {
      final songs = Hive.box<Songs>(_songsBox);
      songs.add(song);
      list.songList = HiveList(songs);
      list.songList!.add(song);
    }
    playList.add(list);
    list.save();
  }

  @override
  List<PlayList> getPlayList() {
    final playList = Hive.box<PlayList>(_playListBox);
    return playList.values.toList();
  }

  @override
  void updatePlayList({required String listName, required Songs song}) {
    final playList = Hive.box<PlayList>(_playListBox);
    for (var element in playList.values) {
      if (element.listName == listName) {
        final songs = Hive.box<Songs>(_songsBox);

        songs.add(song);
        element.songList!.add(song);
        element.save();
      }
    }
  }
}
