// import 'package:music_player/data/hive_model/play_list.dart';
// import 'package:on_audio_query/on_audio_query.dart';

import 'package:music_player/data/hive_model/play_list.dart';
import 'package:music_player/data/hive_model/songs.dart';

abstract class PlayListDb {
  Future<bool> initDb();
  Future createPlayList({required String listName, Songs song});
  List<PlayList> getPlayList();
  void updatePlayList({required String listName, required Songs song});
}
