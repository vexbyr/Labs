import 'package:flutter/material.dart';
import 'screens/catalog_screen.dart';

void main() => runApp(const SmartCatalogApp());

class SmartCatalogApp extends StatelessWidget {
  const SmartCatalogApp({super.key});

  @override
  Widget build(BuildContext context) {
    const ink = Color(0xFF252238);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MODO — Wear your mood',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFFFFDF9),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF8B72E8)),
        textTheme: ThemeData.light().textTheme.apply(bodyColor: ink, displayColor: ink),
        snackBarTheme: SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
          backgroundColor: ink,
          contentTextStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ),
      home: const CatalogScreen(),
    );
  }
}
