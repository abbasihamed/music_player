import 'package:flutter/material.dart';
import 'package:music_player/views/home.dart';

void main(List<String> args) {
  runApp(const MusicApp());
}

class MusicApp extends StatelessWidget {
  const MusicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Music',
      theme: ThemeData(
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Colors.transparent,
        ),
        iconTheme: const IconThemeData(
          color: Colors.grey,
        ),
      ),
      home: const HomeScreens(),
    );
  }
}
