import 'package:flutter/material.dart';
import 'package:music_player/data/hive_model/play_list.dart';
import 'package:music_player/data/hive_model/songs.dart';
import 'package:music_player/data/local/play_list_storage_imp.dart';

class PlayListController extends ChangeNotifier {
  final PlayListDbImp playListDbImp = PlayListDbImp();

  List<PlayList> _playLists = [];

  List<PlayList> get playList => _playLists;

  PlayListController() {
    hiveDbInit();
  }

  hiveDbInit() async {
    final isInit = await playListDbImp.initDb();
    if (isInit) {
      getAllPlayList();
    }
  }

  createPlayList({required String listName, Songs? songs}) {
    playListDbImp.createPlayList(listName: listName, song: songs);
    getAllPlayList();
  }

  getAllPlayList() {
    final playList = playListDbImp.getPlayList();
    _playLists = playList;
    notifyListeners();
  }

  updatePlayList({required String listName, required Songs song}) {
    playListDbImp.updatePlayList(listName: listName, song: song);
    getAllPlayList();
  }
}
