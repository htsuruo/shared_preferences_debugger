# shared_preferences_debugger

A simple debug package for [shared_preferences](https://pub.dev/packages/shared_preferences).

This package shows and delete some `shared_preferences` values more easily.

![](https://user-images.githubusercontent.com/12729025/147811367-974e740a-4f58-4847-b256-f653a2790c4c.gif)

## Usage

Just use `SharedPreferencesDebugPage()` anywhere you want.

`SharedPreferencesDebugPage()` is wrapper of `Scaffold`, so it recommend used as new screen as below.

```dart
IconButton(
  onPressed: () {
    Navigator.of(context).push<void>(
      MaterialPageRoute(
        builder: (context) => const SharedPreferencesDebugPage(),
      ),
    );
  },
  icon: const Icon(Icons.bug_report),
),
```
