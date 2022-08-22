import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

typedef PrefMap = MapEntry<String, Object?>;

class SharedPreferencesDebugPage extends StatefulWidget {
  const SharedPreferencesDebugPage({super.key});

  @override
  State<SharedPreferencesDebugPage> createState() =>
      _SharedPreferencesDebugPageState();
}

class _SharedPreferencesDebugPageState
    extends State<SharedPreferencesDebugPage> {
  late SharedPreferences _prefs;
  List<PrefMap> _keyValues = [];

  void _updateKeyValues() {
    setState(() {
      _keyValues = _prefs
          .getKeys()
          .map(
            (key) => MapEntry(key, _prefs.get(key)),
          )
          .toList()
        ..sort((a, b) => a.key.compareTo(b.key));
    });
  }

  @override
  void initState() {
    super.initState();
    Future(() async {
      _prefs = await SharedPreferences.getInstance();
      _updateKeyValues();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shared Preference Debugger'),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                final res = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Confirm'),
                        content: const Text('Delete all?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context, false);
                            },
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context, true);
                            },
                            child: const Text('OK'),
                          )
                        ],
                      ),
                    ) ??
                    false;
                if (res) {
                  _prefs.getKeys().forEach((key) {
                    _prefs.remove(key);
                  });
                  _updateKeyValues();
                }
              },
            ),
          ),
        ],
      ),
      body: _keyValues.isEmpty
          ? const Center(
              child: Text('Shared Preferences Value is Empty'),
            )
          : ListView.separated(
              itemCount: _keyValues.length,
              separatorBuilder: (context, _) => const Divider(height: 0),
              itemBuilder: (context, index) {
                final keyValue = _keyValues[index];
                final value = keyValue.value.toString();
                return ListTile(
                  visualDensity: VisualDensity.compact,
                  title: Text(keyValue.key),
                  subtitle: Text(
                    value,
                    style: theme.textTheme.bodyText2!.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: colorScheme.error,
                    ),
                    onPressed: () {
                      _prefs.remove(keyValue.key);
                      _updateKeyValues();
                    },
                  ),
                  onTap: () {
                    final messenger = ScaffoldMessenger.of(context);
                    Clipboard.setData(
                      ClipboardData(text: value),
                    );
                    messenger
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        SnackBar(
                          content: Text('Copied: $value'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                  },
                );
              },
            ),
    );
  }
}
