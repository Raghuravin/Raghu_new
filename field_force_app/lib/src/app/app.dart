import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../config/app_config.dart';
import 'router.dart';

class FieldForceApp extends ConsumerWidget {
  const FieldForceApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final config = ref.watch(appConfigProvider);

    final baseTheme = ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: config.isProd ? Colors.blueGrey : Colors.indigo,
        brightness: Brightness.light,
      ),
      useMaterial3: true,
      scaffoldBackgroundColor: const Color(0xFFF8F9FB),
      textTheme: GoogleFonts.poppinsTextTheme(),
      appBarTheme: const AppBarTheme(centerTitle: false),
    );

    return MaterialApp.router(
      title: 'Field-Force Management',
      debugShowCheckedModeBanner: !config.isProd,
      theme: baseTheme,
      routerConfig: router,
    );
  }
}
