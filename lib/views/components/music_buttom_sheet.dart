import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:music_player/provider/play_song_controller.dart';
import 'package:music_player/views/components/anim_icon.dart';
import 'package:music_player/views/components/music_button.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class MusicButtomSheet extends StatelessWidget {
  final List songs;
  const MusicButtomSheet({
    super.key,
    required this.songs,
  });

  @override
  Widget build(BuildContext context) {
    final sz = MediaQuery.of(context).size;
    return Consumer<PlaySongController>(
      builder: (context, play, child) {
        return AnimatedContainer(
          duration: const Duration(seconds: 3),
          height: play.isPlay ? 60 : 0,
          child: GlassContainer(
            width: double.infinity,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  bottom: 0,
                  top: 0,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16, right: 8),
                        child: QueryArtworkWidget(
                          id: play.currentDetail.id,
                          type: ArtworkType.AUDIO,
                          artworkBorder: BorderRadius.circular(8),
                          artworkHeight: 50,
                          artworkWidth: 50,
                          nullArtworkWidget: SizedBox(
                            height: 50,
                            width: 50,
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
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Flexible(
                            child: SizedBox(
                              width: sz.width * 0.3,
                              child: Text(
                                play.currentDetail.title,
                                style: const TextStyle(
                                  fontFamily: 'Gilroy',
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 16,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          Flexible(
                            child: SizedBox(
                              width: sz.width * 0.3,
                              child: Text(
                                play.currentDetail.artist ?? 'Unknown',
                                style: const TextStyle(
                                  fontFamily: 'Gilroy',
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MusicButton(
                        icons: FeatherIcons.skipBack,
                        size: 22,
                        onPressed: () {
                          play.previousSong();
                        },
                      ),
                      CustomIconAnim(
                        onPressed: () {
                          if (play.isPause) {
                            play.playSong(songs, play.audioPlayer.currentIndex!,
                                duration: play.audioPlayer.position);
                          } else {
                            play.pauseSong();
                          }
                        },
                        icons: AnimatedIcons.pause_play,
                        colors: Colors.white,
                      ),
                      MusicButton(
                        icons: FeatherIcons.skipForward,
                        size: 22,
                        onPressed: () {
                          play.nextSong();
                        },
                      ),
                      MusicButton(
                        icons: Icons.close,
                        size: 20,
                        onPressed: () {
                          play.stopSong();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
