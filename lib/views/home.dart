import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:music_player/config/theme/app_colors.dart';
import 'package:music_player/provider/local_songs_controller.dart';
import 'package:music_player/provider/play_list_controller.dart';
import 'package:music_player/provider/play_song_controller.dart';
import 'package:music_player/views/components/custom_chip.dart';
import 'package:music_player/views/components/glasses_button.dart';
import 'package:music_player/views/components/music_buttom_sheet.dart';
import 'package:music_player/views/music_details.dart';
import 'package:music_player/views/playlist_song_list.dart';
import 'package:music_player/views/songs_screen.dart';
import 'package:provider/provider.dart';

class HomeScreens extends HookWidget {
  const HomeScreens({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<PlayListController>(context);
    List allSong = Provider.of<LocalSongs>(context, listen: false).allSongs;
    final isSelcted = useState({'songs': true, 'playlist': false});
    final pageController = usePageController(initialPage: 0);
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        centerTitle: true,
        title: const Text('My Music'),
        elevation: 0,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          SizedBox(
            height: 50,
            width: double.infinity,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                CustomChip(
                  isSelected: isSelcted.value['songs'],
                  lable: 'Songs',
                  onTap: () {
                    isSelcted.value = {'songs': true, 'playlist': false};
                    pageController.jumpToPage(0);
                  },
                ),
                CustomChip(
                  isSelected: isSelcted.value['playlist'],
                  lable: 'Playlist',
                  onTap: () {
                    isSelcted.value = {'songs': false, 'playlist': true};
                    pageController.jumpToPage(1);
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: PageView(
              controller: pageController,
              onPageChanged: (value) {
                if (value == 0) {
                  isSelcted.value = {'songs': true, 'playlist': false};
                }
                if (value == 1) {
                  isSelcted.value = {'songs': false, 'playlist': true};
                }
              },
              children: [
                const SongsScreen(),
                Consumer<PlayListController>(
                  builder: (context, playList, child) {
                    return ListView.builder(
                      itemCount: playList.playList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PlayListSongsScreen(
                                  songs: playList.playList[index].songList!,
                                ),
                              ),
                            );
                          },
                          title: Text(
                            playList.playList[index].listName,
                            style: const TextStyle(
                              fontFamily: 'Gilroy',
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              fontSize: 18,
                            ),
                          ),
                          subtitle: Text(
                            playList.playList[index].songList?.length
                                    .toString() ??
                                '0',
                            style: const TextStyle(
                              fontFamily: 'Gilroy',
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          )
        ],
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
                    builder: (context) => MusicDetail(songs: allSong),
                  ),
                );
              },
              child: MusicButtomSheet(songs: allSong),
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
                    context.read<PlaySongController>().playSong(allSong, 0);
                  },
                  icons: FeatherIcons.play,
                ),
                const SizedBox(height: 10),
                GlassesButton(
                  onTap: () {
                    context
                        .read<PlaySongController>()
                        .playSong(allSong, 0, isShuffle: true);
                  },
                  icons: FeatherIcons.shuffle,
                ),
              ],
            )
          : null,
    );
  }
}
