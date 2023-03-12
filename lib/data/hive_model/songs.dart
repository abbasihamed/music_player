import 'package:hive/hive.dart';

part 'songs.g.dart';

@HiveType(typeId: 1)
class Songs extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  int id;

  @HiveField(2)
  String uri;

  @HiveField(3)
  String artist;

  Songs({
    required this.id,
    required this.title,
    required this.artist,
    required this.uri,
  });
}
