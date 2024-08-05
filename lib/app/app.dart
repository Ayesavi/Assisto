import 'package:assisto/core/remote_config/remote_config_service.dart';
import 'package:assisto/core/router/router.dart';
import 'package:assisto/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(routerProvider);
    final theme = MaterialTheme(Theme.of(context).textTheme);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: theme.light(),
      darkTheme:
          RemoteConfigKeys.enableDarkMode.value<bool>() ? theme.dark() : null,
      routerConfig: router,
    );
  }
}
