import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:music_player/views/components/music_button.dart';

class MusicButtomSheet extends StatelessWidget {
  final bool isPlay;
  final VoidCallback closeBtn;
  const MusicButtomSheet({
    Key? key,
    required this.isPlay,
    required this.closeBtn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(seconds: 2),
      height: isPlay ? 60 : 0,
      child: GlassContainer(
        width: double.infinity,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    margin: const EdgeInsets.only(left: 16, right: 8),
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Text(
                        'Song Title',
                        style: TextStyle(
                          fontFamily: 'Gilroy',
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'Artist Name',
                        style: TextStyle(
                          fontFamily: 'Gilroy',
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MusicButton(
                    icons: FeatherIcons.skipBack,
                    size: 22,
                    onPressed: () {},
                  ),
                  MusicButton(
                    icons: Icons.play_arrow_rounded,
                    onPressed: () {},
                    colors: Colors.white,
                  ),
                  MusicButton(
                    icons: FeatherIcons.skipForward,
                    size: 22,
                    onPressed: () {},
                  ),
                  MusicButton(
                    icons: Icons.close,
                    size: 20,
                    onPressed: closeBtn,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
