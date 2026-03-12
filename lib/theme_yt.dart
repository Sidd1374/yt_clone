import 'package:flutter/material.dart';

// custom color set for youtube theme
class YtColors extends ThemeExtension<YtColors> {
  final Color background;
  final Color surface;
  final Color surfaceVariant;
  final Color textPrimary;
  final Color textSecondary;
  final Color textDisabled;
  final Color iconActive;
  final Color iconInactive;
  final Color chipBg;
  final Color chipSelectedBg;
  final Color chipSelectedText;
  final Color divider;
  final Color overlay;
  final Color red;

  const YtColors({
    required this.background,
    required this.surface,
    required this.surfaceVariant,
    required this.textPrimary,
    required this.textSecondary,
    required this.textDisabled,
    required this.iconActive,
    required this.iconInactive,
    required this.chipBg,
    required this.chipSelectedBg,
    required this.chipSelectedText,
    required this.divider,
    required this.overlay,
    required this.red,
  });

  @override
  ThemeExtension<YtColors> copyWith() => this;

  @override
  ThemeExtension<YtColors> lerp(
    covariant ThemeExtension<YtColors>? other,
    double t,
  ) => this;
}

// extension for easy access via context.yt
extension YtThemeExtension on BuildContext {
  YtColors get yt => Theme.of(this).extension<YtColors>()!;
}

// light theme colors
final _lightColors = YtColors(
  background: const Color(0xFFFFFFFF),
  surface: const Color(0xFFFFFFFF),
  surfaceVariant: const Color(0xFFF2F2F2),
  textPrimary: const Color(0xFF0F0F0F),
  textSecondary: const Color(0xFF606060),
  textDisabled: const Color(0xFF909090),
  iconActive: const Color(0xFF0F0F0F),
  iconInactive: const Color(0xFF0F0F0F),
  chipBg: const Color(0xFF000000).withAlpha(13),
  chipSelectedBg: const Color(0xFF0F0F0F),
  chipSelectedText: const Color(0xFFFFFFFF),
  divider: const Color(0xFF000000).withAlpha(26),
  overlay: const Color(0x80000000),
  red: const Color(0xFFFF0000),
);

// dark theme colors
const _darkColors = YtColors(
  background: Color(0xFF000000),
  surface: Color(0xFF0F0F0F),
  surfaceVariant: Color(0xFF212121),
  textPrimary: Color(0xFFFFFFFF),
  textSecondary: Color(0xFFAAAAAA),
  textDisabled: Color(0xFF717171),
  iconActive: Color(0xFFFFFFFF),
  iconInactive: Color(0xFFFFFFFF),
  chipBg: Color(0xFF272727),
  chipSelectedBg: Color(0xFFF1F1F1),
  chipSelectedText: Color(0xFF0F0F0F),
  divider: Color(0xFF383838),
  overlay: Color(0x80000000),
  red: Color(0xFFFF0000),
);

final ThemeData ytLightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: _lightColors.background,
  appBarTheme: AppBarTheme(
    backgroundColor: _lightColors.background,
    elevation: 0,
    iconTheme: IconThemeData(color: _lightColors.iconActive),
    titleTextStyle: TextStyle(
      color: _lightColors.textPrimary,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    backgroundColor: _lightColors.background,
    selectedItemColor: _lightColors.iconActive,
    unselectedItemColor: _lightColors.iconInactive,
    selectedLabelStyle: const TextStyle(fontSize: 10),
    unselectedLabelStyle: const TextStyle(fontSize: 10),
  ),
  dividerColor: _lightColors.divider,
  extensions: [_lightColors],
);

final ThemeData ytDarkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: _darkColors.background,
  appBarTheme: AppBarTheme(
    backgroundColor: _darkColors.background,
    elevation: 0,
    iconTheme: IconThemeData(color: _darkColors.iconActive),
    titleTextStyle: TextStyle(
      color: _darkColors.textPrimary,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    backgroundColor: _darkColors.background,
    selectedItemColor: _darkColors.iconActive,
    unselectedItemColor: _darkColors.iconInactive,
    selectedLabelStyle: const TextStyle(fontSize: 10),
    unselectedLabelStyle: const TextStyle(fontSize: 10),
  ),
  dividerColor: _darkColors.divider,
  extensions: [_darkColors],
);
