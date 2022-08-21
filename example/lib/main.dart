import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_debugger/shared_preferences_debugger.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shared preferences debugger',
      theme: ThemeData.from(
        colorScheme: const ColorScheme.light(),
      ),
      home: const _HomePage(),
    );
  }
}

class _HomePage extends StatelessWidget {
  const _HomePage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          runtimeType.toString(),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push<void>(
                MaterialPageRoute(
                  builder: (context) => const SharedPreferencesDebugPage(),
                  fullscreenDialog: true,
                ),
              );
            },
            icon: const Icon(Icons.bug_report),
          ),
        ],
      ),
      body: Center(
        child: OutlinedButton(
          onPressed: () async {
            final messenger = ScaffoldMessenger.of(context);
            final pref = await SharedPreferences.getInstance();
            final key = _generateRandomString(10);
            final value = _generateRandomString(30);
            final success = await pref.setString(key, value);
            // ignore: avoid_print
            print('Set keyValue: $success -> {$key, $value}');
            messenger
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text('Set keyValue: $success -> {$key, $value}'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
          },
          child: const Text('Add sample value'),
        ),
      ),
    );
  }
}

String _generateRandomString(int length) {
  const randomChars =
      'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  const charsLength = randomChars.length;
  final rand = Random();
  final codeUnits = List.generate(
    length,
    (index) {
      final n = rand.nextInt(charsLength);
      return randomChars.codeUnitAt(n);
    },
  );
  return String.fromCharCodes(codeUnits);
}
