import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/data/hive_model/songs.dart';
import 'package:music_player/provider/play_song_controller.dart';
import 'package:music_player/views/components/custom_scaffold.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class PlayListSongsScreen extends HookWidget {
  final HiveList<Songs> songs;
  const PlayListSongsScreen({
    super.key,
    required this.songs,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarTitle: 'Play List',
      songList: songs,
      body: Consumer<PlaySongController>(
        builder: (context, play, child) {
          return ListView.builder(
            itemCount: songs.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  onTap: () {
                    play.playSong(songs, index);
                  },
                  leading: QueryArtworkWidget(
                    id: songs[index].id,
                    type: ArtworkType.AUDIO,
                    artworkBorder: BorderRadius.circular(8),
                    artworkHeight: double.infinity,
                    artworkWidth: 60,
                    nullArtworkWidget: SizedBox(
                      height: double.infinity,
                      width: 60,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Image.asset(
                            'assets/images/song-place.png',
                            width: 30,
                          ),
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    songs[index].artist,
                    style: const TextStyle(
                      fontFamily: 'Gilroy',
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                    ),
                  ),
                  subtitle: Text(
                    songs[index].artist,
                    style: const TextStyle(
                      fontFamily: 'Gilroy',
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
