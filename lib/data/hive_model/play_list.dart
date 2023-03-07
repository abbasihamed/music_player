import 'package:hive/hive.dart';

part 'play_list.g.dart';

@HiveType(typeId: 0)
class PlayList extends HiveObject {
  @HiveField(0)
  String listName;

  PlayList({required this.listName});
}
