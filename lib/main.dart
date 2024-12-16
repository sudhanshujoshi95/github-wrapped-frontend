import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:github_wrapped/screens/user_input_screen.dart';

void main() {
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    Zone.current.handleUncaughtError(details.exception, details.stack!);
  };

  runZonedGuarded(() {
    runApp(const MyApp());
  }, (error, stack) {
    if (kDebugMode) {
      print('Uncaught error: $error');
    }
    if (kDebugMode) {
      print(stack);
    }
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GitHub Wrapped',
      home: UsernameInputScreen(),
    );
  }
}
