import 'package:flutter/material.dart';

class AppTheme {
  // Metallic Color Palette
  static const Color chromeSilver = Color(0xFFE0E0E0);
  static const Color brushedSteel = Color(0xFF9E9E9E);
  static const Color gunmetal = Color(0xFF263238);
  static const Color industrialCyan = Color(0xFF00ACC1);
  static const Color brandPurple = Color.fromARGB(255, 64, 41, 148);
  static const Color alertRed = Color.fromARGB(255, 255, 10, 10);
  static const double showModalHeaderSize = 19;
  // static const Color gaugeOrange = Color(0xFFFF8F00); // For warnings/limits

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    // primaryColor: gunmetal,
    scaffoldBackgroundColor: const Color(0xFFF5F5F5), // Light Gray Industrial
    colorScheme: const ColorScheme.light(
      primary: gunmetal,
      secondary: industrialCyan,
      surface: chromeSilver,
      onSurface: Colors.black87,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: chromeSilver,
      // elevation: 4, // More shadow for a "heavy" metal feel
      iconTheme: IconThemeData(color: gunmetal),
      titleTextStyle: TextStyle(
        color: gunmetal,
        fontSize: 22,
        fontWeight: FontWeight.w900, // Heavy weight for industrial look
        letterSpacing: 1.2,
      ),
    ),
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 6,
      shadowColor: Colors.black45,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(
          color: brushedSteel,
          width: 1,
        ), // Beveled edge look
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: gunmetal,
        foregroundColor: chromeSilver,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: chromeSilver,
    scaffoldBackgroundColor: const Color(0xFF121212), // Deep Matte Black
    colorScheme: const ColorScheme.dark(
      primary: chromeSilver,
      secondary: industrialCyan,
      surface: Color(0xFF1E1E1E), // Darker Gunmetal
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1A1A1A),
      elevation: 0,
      iconTheme: IconThemeData(color: chromeSilver),
      titleTextStyle: TextStyle(
        color: chromeSilver,
        fontSize: 22,
        fontWeight: FontWeight.w900,
      ),
    ),
    cardTheme: CardThemeData(
      color: const Color(0xFF2C2C2C),
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0xFF444444), width: 1.5),
      ),
    ),
    // This makes the list dividers look like metal seams
    dividerTheme: const DividerThemeData(
      color: Color(0xFF444444),
      thickness: 0.1,
    ),
  );
}
