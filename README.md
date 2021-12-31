# shared_preferences_debugger

A simple debug package for [shared_preferences](https://pub.dev/packages/shared_preferences) value.

This package shows and delete some `shared_preferences` values more easily.

## Usage

Just use `SharedPreferencesDebugPage()` anywhere you want.

`SharedPreferencesDebugPage()` is wrapper of `Scaffold`, so it recommend used as new screen as below.

```dart
ElevatedButton(
  onPressed: () => Navigator.push(
    context,
    MaterialPageRoute<void>(
      builder: (context) => SharedPreferencesDebugPage(),
    ),
  ),
  child: Text('Show shared_preferences value'),
),
```
