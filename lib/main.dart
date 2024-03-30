import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:music_player/config/get_context.dart';
import 'package:music_player/config/theme/app_colors.dart';
import 'package:music_player/provider/local_songs_controller.dart';
import 'package:music_player/provider/play_list_controller.dart';
import 'package:music_player/provider/play_song_controller.dart';
import 'package:music_player/views/home.dart';
import 'package:provider/provider.dart';

void main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(DevicePreview(
      enabled: false,
      builder: (context) {
        return const MusicApp();
      }));
}

class MusicApp extends StatelessWidget {
  const MusicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LocalSongs()),
        ChangeNotifierProvider(create: (context) => PlaySongController()),
        ChangeNotifierProvider(create: (context) => PlayListController()),
      ],
      child: MaterialApp(
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        debugShowCheckedModeBanner: false,
        title: 'Muzic',
        theme: AppTheme.theme,
        navigatorKey: ctx,
        home: const HomeScreens(),
      ),
    );
  }
}
