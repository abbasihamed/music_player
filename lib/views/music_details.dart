import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:music_player/config/theme/app_colors.dart';
import 'package:music_player/views/components/music_button.dart';

class MusicDetail extends StatelessWidget {
  const MusicDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final sz = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(),
      body: Column(
        children: [
          Center(
            child: Container(
              height: 250,
              width: 300,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Image.asset('assets/images/song-place.png'),
            ),
          ),
        ],
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
        child: Column(
          children: [
            const ListTile(
              title: Text(
                'Artist Name',
                style: TextStyle(
                  fontFamily: 'Gilroy',
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 24,
                ),
              ),
              subtitle: Text(
                'Song Name',
                style: TextStyle(
                  fontFamily: 'Gilroy',
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  height: 2,
                ),
              ),
            ),
            const SizedBox(height: 24),
            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: const LinearProgressIndicator(
                value: .5,
                backgroundColor: AppColors.background,
                color: Color(0xFF8070FF),
                minHeight: 10,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  '02:13',
                  style: TextStyle(
                    fontFamily: 'Gilroy',
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
                Text(
                  '04:01',
                  style: TextStyle(
                    fontFamily: 'Gilroy',
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MusicButton(
                  icons: FeatherIcons.skipBack,
                  size: 28,
                  onPressed: () {},
                ),
                Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: MusicButton(
                      icons: Icons.play_arrow_rounded,
                      onPressed: () {},
                      size: 32,
                      colors: Colors.white,
                    ),
                  ),
                ),
                MusicButton(
                  icons: FeatherIcons.skipForward,
                  size: 28,
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
