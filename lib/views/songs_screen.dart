import 'package:flutter/material.dart';
import 'package:music_player/config/app_loading.dart';
import 'package:music_player/data/hive_model/songs.dart';
import 'package:music_player/provider/local_songs_controller.dart';
import 'package:music_player/provider/play_song_controller.dart';
import 'package:music_player/views/components/add_playlist_dialog.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class SongsScreen extends StatelessWidget {
  const SongsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<LocalSongs, PlaySongController>(
        builder: (context, songs, play, child) {
      if (songs.isLoading) {
        return const AppLoading();
      }
      return Column(
        children: [
          Container(
            height: 60,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: TextFormField(
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Gilroy',
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
              cursorColor: Colors.grey[800],
              decoration: const InputDecoration(
                hintText: 'Search by music',
              ),
              onChanged: (value) {
                songs.searchSongs(value);
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: songs.filterdSongs.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    onTap: () {
                      play.playSong(songs.filterdSongs, index);
                    },
                    leading: QueryArtworkWidget(
                      id: songs.filterdSongs[index].id,
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
                      songs.filterdSongs[index].title,
                      style: const TextStyle(
                        fontFamily: 'Gilroy',
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      songs.filterdSongs[index].artist ?? 'Unknown',
                      style: const TextStyle(
                        fontFamily: 'Gilroy',
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AddPlaylistDialog(
                            songs: Songs(
                              id: songs.filterdSongs[index].id,
                              title: songs.filterdSongs[index].title,
                              artist:
                                  songs.filterdSongs[index].artist ?? 'Unknown',
                              uri: songs.filterdSongs[index].uri ?? 'Unknown',
                            ),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.more_horiz,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      );
    });
  }
}
