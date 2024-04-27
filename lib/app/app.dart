import 'package:assisto/core/router/router.dart';
import 'package:assisto/core/theme/text_theme.dart';
import 'package:assisto/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final theme = MaterialTheme(GoogleFonts.interTextTheme(textTheme));
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: theme.lightContrast(),
      routerConfig: router,
    );
  }
}
