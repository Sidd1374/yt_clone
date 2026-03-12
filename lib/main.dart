import 'package:flutter/material.dart';
import 'theme_yt.dart' as th;
import 'containerFrame.dart';

final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (_, ThemeMode currentMode, __) {
        return MaterialApp(
          title: 'Youtube Demo',
          debugShowCheckedModeBanner: false,
          theme: th.ytLightTheme,
          darkTheme: th.ytDarkTheme,
          themeMode: currentMode,
          home: const ContainerFrame(title: 'YouTube'),
        );
      },
    );
  }
}
