import 'package:flutter/material.dart';
import 'package:music_player/views/home.dart';

void main(List<String> args) {
  runApp(const MusicApp());
}

class MusicApp extends StatelessWidget {
  const MusicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Music',
      home: HomeScreens(),
    );
  }
}
