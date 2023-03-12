import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:music_player/config/theme/app_colors.dart';
import 'package:music_player/provider/play_song_controller.dart';
import 'package:music_player/views/components/anim_icon.dart';
import 'package:music_player/views/components/music_button.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class MusicDetail extends StatelessWidget {
  final List songs;
  const MusicDetail({super.key, required this.songs});

  @override
  Widget build(BuildContext context) {
    final sz = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.grey,
          ),
        ),
      ),
      body: Consumer<PlaySongController>(
        builder: (context, play, child) {
          return Column(
            children: [
              Center(
                child: QueryArtworkWidget(
                  id: play.currentDetail.id,
                  type: ArtworkType.AUDIO,
                  artworkBorder: BorderRadius.circular(18),
                  artworkHeight: 250,
                  artworkWidth: 300,
                  artworkQuality: FilterQuality.high,
                  format: ArtworkFormat.PNG,
                  quality: 100,
                  nullArtworkWidget: SizedBox(
                    height: 250,
                    width: 300,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(18),
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
            ],
          );
        },
      ),
      bottomSheet: Container(
        height: sz.height * 0.4,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.black87.withOpacity(.3),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(28),
            topRight: Radius.circular(28),
          ),
        ),
        child: Consumer<PlaySongController>(
          builder: (context, play, child) {
            return Column(
              children: [
                ListTile(
                  title: Text(
                    play.currentDetail.title,
                    style: const TextStyle(
                      fontFamily: 'Gilroy',
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 24,
                    ),
                  ),
                  subtitle: Text(
                    play.currentDetail.artist ?? 'Unknown',
                    style: const TextStyle(
                      fontFamily: 'Gilroy',
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      height: 2,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                StreamBuilder<Duration>(
                    stream: play.audioPlayer.positionStream,
                    builder: (context, snapshot) {
                      return ProgressBar(
                        progress: play.audioPlayer.position,
                        total: play.audioPlayer.duration ?? play.lastDuration,
                        onSeek: play.audioPlayer.seek,
                        timeLabelLocation: TimeLabelLocation.below,
                        barCapShape: BarCapShape.round,
                        baseBarColor: AppColors.background,
                        progressBarColor: const Color(0xFF8070FF),
                        thumbColor: const Color(0xFF8070FF),
                        timeLabelTextStyle: const TextStyle(
                          fontFamily: 'Gilroy',
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                        timeLabelPadding: 8,
                        timeLabelType: TimeLabelType.totalTime,
                      );
                    }),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MusicButton(
                      icons: FeatherIcons.skipBack,
                      size: 28,
                      onPressed: () {
                        play.previousSong();
                      },
                    ),
                    Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: CustomIconAnim(
                          icons: AnimatedIcons.pause_play,
                          onPressed: () {
                            if (play.isPause) {
                              play.playSong(
                                  songs, play.audioPlayer.currentIndex!,
                                  duration: play.audioPlayer.position);
                            } else {
                              play.pauseSong();
                            }
                          },
                          colors: Colors.white,
                        ),
                      ),
                    ),
                    MusicButton(
                      icons: FeatherIcons.skipForward,
                      size: 28,
                      onPressed: () {
                        play.nextSong();
                      },
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
