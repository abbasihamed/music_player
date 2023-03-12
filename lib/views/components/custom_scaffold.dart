import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:music_player/config/theme/app_colors.dart';
import 'package:music_player/provider/play_song_controller.dart';
import 'package:music_player/views/components/glasses_button.dart';
import 'package:music_player/views/components/music_buttom_sheet.dart';
import 'package:music_player/views/music_details.dart';
import 'package:provider/provider.dart';

class CustomScaffold extends StatelessWidget {
  final Widget body;
  final String appBarTitle;
  final List songList;
  const CustomScaffold({
    super.key,
    required this.body,
    required this.appBarTitle,
    required this.songList,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (Rect bounds) => const LinearGradient(
            colors: <Color>[Colors.white, Colors.blue, Colors.blueAccent],
          ).createShader(
            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
          ),
          child: Text(appBarTitle),
        ),
      ),
      body: body,
      bottomSheet: Consumer<PlaySongController>(
        builder: (context, play, child) {
          if (play.isPlay || play.isPause) {
            return InkWell(
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MusicDetail(songs: songList),
                  ),
                );
              },
              child: MusicButtomSheet(songs: songList),
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
                    context.read<PlaySongController>().playSong(songList, 0);
                  },
                  icons: FeatherIcons.play,
                ),
                const SizedBox(height: 10),
                GlassesButton(
                  onTap: () {
                    context
                        .read<PlaySongController>()
                        .playSong(songList, 0, isShuffle: true);
                  },
                  icons: FeatherIcons.shuffle,
                ),
              ],
            )
          : null,
    );
  }
}
