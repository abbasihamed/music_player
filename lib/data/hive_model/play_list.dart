import 'package:hive/hive.dart';
import 'package:music_player/data/hive_model/songs.dart';

part 'play_list.g.dart';

@HiveType(typeId: 0)
class PlayList extends HiveObject {
  @HiveField(0)
  String listName;

  @HiveField(1)
  HiveList<Songs>? songList;

  PlayList({required this.listName, this.songList});
}
