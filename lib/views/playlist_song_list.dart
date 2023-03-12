import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/config/theme/app_colors.dart';
import 'package:music_player/data/hive_model/songs.dart';
import 'package:music_player/provider/play_song_controller.dart';
import 'package:music_player/views/components/glasses_button.dart';
import 'package:music_player/views/components/music_buttom_sheet.dart';
import 'package:music_player/views/music_details.dart';
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
    final id = useState(0);
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        centerTitle: true,
        title: const Text('Play List'),
        elevation: 0,
      ),
      body: Consumer<PlaySongController>(
        builder: (context, play, child) {
          return ListView.builder(
            itemCount: songs.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  onTap: () {
                    id.value = songs[index].id;
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
      bottomSheet: Consumer<PlaySongController>(
        builder: (context, play, child) {
          if (play.isPlay || play.isPause) {
            return InkWell(
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MusicDetail(songs: songs),
                  ),
                );
              },
              child: MusicButtomSheet(songs: songs),
            );
          }
          return const SizedBox();
        },
      ),
      floatingActionButton: !context.watch<PlaySongController>().isPlay
          ? Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GlassesButton(
                  onTap: () {
                    context.read<PlaySongController>().playSong(songs, 0);
                  },
                  icons: FeatherIcons.play,
                ),
                const SizedBox(height: 10),
                GlassesButton(
                  onTap: () {
                    context
                        .read<PlaySongController>()
                        .playSong(songs, 0, isShuffle: true);
                  },
                  icons: FeatherIcons.shuffle,
                ),
              ],
            )
          : null,
    );
  }
}
