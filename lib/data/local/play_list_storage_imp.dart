import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_player/data/hive_model/play_list.dart';

import 'package:music_player/data/local/play_list_storage.dart';

class PlayListDbImp implements PlayListDb {
  final String _boxName = 'playList';

  @override
  Future<bool> initDb() async {
    try {
      await Hive.initFlutter();
      Hive.registerAdapter(PlayListAdapter());
      await Hive.openBox<PlayList>(_boxName);
      return true;
    } catch (e) {
      return false;
    }
  }
}
