# shared_preferences_debugger

This package is designed to simplify the debugging of the [shared_preferences](https://pub.dev/packages/shared_preferences) plugin package.

By using this package, you can easily **display**, **copy to clipboard**, and **delete** the data stored in shared_preferences.

| Sample |
| --- |
| <img src="https://user-images.githubusercontent.com/12729025/240113167-86a04a37-ba1f-404c-b92a-cab7fcc64963.gif" width="400"> |

## Usage

Just use `SharedPreferencesDebugPage()` anywhere you want.

`SharedPreferencesDebugPage()` is wrapper of `Scaffold`, so it is recommend to use as new screen like following code..

```dart
IconButton(
  icon: const Icon(Icons.bug_report),
  onPressed: () {
    Navigator.of(context).push<void>(
      MaterialPageRoute(
        builder: (context) => const SharedPreferencesDebugPage(),
      ),
    );
  },
),
```
