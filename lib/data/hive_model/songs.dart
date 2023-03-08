import 'package:hive/hive.dart';

part 'songs.g.dart';

@HiveType(typeId: 1)
class Songs extends HiveObject {
  @HiveField(0)
  String songName;

  @HiveField(1)
  int songId;

  @HiveField(2)
  String songPath;

  @HiveField(3)
  String songArtists;

  Songs({
    required this.songId,
    required this.songName,
    required this.songArtists,
    required this.songPath,
  });
}
