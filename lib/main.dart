import 'package:flutter/material.dart';
import 'package:music_player/config/get_context.dart';
import 'package:music_player/config/theme/app_colors.dart';
import 'package:music_player/provider/local_songs_controller.dart';
import 'package:music_player/provider/play_song_controller.dart';
import 'package:music_player/views/home.dart';
import 'package:provider/provider.dart';

void main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MusicApp());
}

class MusicApp extends StatelessWidget {
  const MusicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LocalSongs()),
        ChangeNotifierProvider(create: (context) => PlaySongController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Music',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.background,
            elevation: 0,
          ),
          bottomSheetTheme: const BottomSheetThemeData(
            backgroundColor: Colors.transparent,
          ),
          iconTheme: const IconThemeData(
            color: Colors.grey,
          ),
        ),
        navigatorKey: ctx,
        home: const HomeScreens(),
      ),
    );
  }
}
