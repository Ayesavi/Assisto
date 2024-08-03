import 'package:assisto/core/router/router.dart';
import 'package:assisto/core/services/notification_service/notification_service.dart';
import 'package:assisto/core/services/notification_service/notification_service_provider.dart';
import 'package:assisto/core/services/permission_service/permission_service_provider.dart';
import 'package:assisto/core/theme/theme.dart';
import 'package:assisto/shared/show_snackbar.dart';
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
      darkTheme: theme.dark(),
      routerConfig: router,
    );
  }
}
