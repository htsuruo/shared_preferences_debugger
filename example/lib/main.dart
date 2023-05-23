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
    const title = 'Shared preferences debugger';
    return MaterialApp(
      title: title,
      theme: ThemeData.from(
        useMaterial3: true,
        colorScheme: const ColorScheme.light(),
      ),
      home: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(title),
              actions: [
                IconButton(
                  color: Theme.of(context).colorScheme.primary,
                  onPressed: () {
                    Navigator.of(context).push<void>(
                      MaterialPageRoute(
                        builder: (context) =>
                            const SharedPreferencesDebugPage(),
                        fullscreenDialog: true,
                      ),
                    );
                  },
                  icon: const Icon(Icons.bug_report),
                ),
              ],
            ),
            body: Center(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.add),
                label: const Text('Add sample value'),
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
                        content:
                            Text('Set keyValue: $success -> {$key, $value}'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                },
              ),
            ),
          );
        },
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
