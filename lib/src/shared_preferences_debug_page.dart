import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences_debugger/src/service.dart';

class SharedPreferencesDebugPage extends StatelessWidget {
  const SharedPreferencesDebugPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return ChangeNotifierProvider(
      create: (context) => Service(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Shared Preference Debugger'),
          actions: [
            Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () async {
                  final provider = Provider.of<Service>(context, listen: false);
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
                    provider.deleteAll();
                  }
                },
              ),
            ),
          ],
        ),
        body: Consumer<Service>(
          builder: (context, v, _) => v.keyValues.isEmpty
              ? const Center(
                  child: Text('Shared Preferences Value is Empty'),
                )
              : ListView.separated(
                  itemCount: v.keyValues.length,
                  separatorBuilder: (context, _) => const Divider(height: 0),
                  itemBuilder: (context, index) {
                    final keyValue = v.keyValues[index];
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
                        onPressed: () =>
                            Provider.of<Service>(context, listen: false)
                                .delete(key: keyValue.key),
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
        ),
      ),
    );
  }
}
