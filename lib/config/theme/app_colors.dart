import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      scaffoldBackgroundColor: const Color(0xFF1F222B),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF1F222B),
        elevation: 0,
        centerTitle: true,
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.transparent,
      ),
      iconTheme: const IconThemeData(
        color: Colors.grey,
      ),
    );
  }
}
