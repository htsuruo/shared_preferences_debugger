import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences_debugger/service.dart';

class PrefDebug extends StatelessWidget {
  const PrefDebug({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return ChangeNotifierProvider(
      create: (context) => Service(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Shared Preference'),
          actions: [
            Builder(
              builder: (context) => IconButton(
                onPressed:
                    Provider.of<Service>(context, listen: false).deleteAll,
                icon: const Icon(Icons.delete),
              ),
            ),
          ],
        ),
        body: Consumer<Service>(
          builder: (context, v, _) => v.keyValues.isEmpty
              ? const Center(
                  child: Text('Shared Preferences is Empty'),
                )
              : ListView.separated(
                  itemBuilder: (context, index) {
                    final keyValue = v.keyValues[index];
                    return ListTile(
                      visualDensity: VisualDensity.compact,
                      title: Text(keyValue.key),
                      subtitle: Text(
                        keyValue.value.toString(),
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
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const Divider(height: 0),
                  itemCount: v.keyValues.length,
                ),
        ),
      ),
    );
  }
}
