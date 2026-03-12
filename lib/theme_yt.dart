import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class YtText {
  static const appBarTitle = TextStyle(
    fontSize: 19,
    fontWeight: FontWeight.w800,
  );
  static const videoTitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );
  static const videoMeta = TextStyle(fontSize: 13, fontWeight: FontWeight.w600);
  static const sectionHeader = TextStyle(
    fontSize: 19,
    fontWeight: FontWeight.w800,
  );
  static const shortsTitle = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w700,
  );
  static const shortsMeta = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w600,
  );
  static const body = TextStyle(fontSize: 14, fontWeight: FontWeight.w600);
  static const bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
  );
  static const label = TextStyle(fontSize: 13, fontWeight: FontWeight.w700);
  static const caption = TextStyle(fontSize: 12, fontWeight: FontWeight.w600);
  static const button = TextStyle(fontSize: 14, fontWeight: FontWeight.w800);
  static const settingsSection = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w800,
  );
  static const settingsItem = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
  );
}

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
  textTheme: GoogleFonts.robotoTextTheme(),
  primaryTextTheme: GoogleFonts.robotoTextTheme(),
  scaffoldBackgroundColor: _lightColors.background,
  iconTheme: IconThemeData(color: _lightColors.iconActive, size: 26),
  appBarTheme: AppBarTheme(
    backgroundColor: _lightColors.background,
    elevation: 0,
    iconTheme: IconThemeData(color: _lightColors.iconActive, size: 26),
    actionsIconTheme: IconThemeData(color: _lightColors.iconActive, size: 26),
    titleTextStyle: YtText.appBarTitle.copyWith(
      color: _lightColors.textPrimary,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    backgroundColor: _lightColors.background,
    selectedItemColor: _lightColors.iconActive,
    unselectedItemColor: _lightColors.iconInactive,
    selectedLabelStyle: const TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w600,
    ),
    unselectedLabelStyle: const TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w600,
    ),
  ),
  listTileTheme: const ListTileThemeData(
    minLeadingWidth: 24,
    contentPadding: EdgeInsets.symmetric(horizontal: 20),
  ),
  dividerColor: _lightColors.divider,
  extensions: [_lightColors],
);

final ThemeData ytDarkTheme = ThemeData(
  brightness: Brightness.dark,
  textTheme: GoogleFonts.robotoTextTheme(ThemeData.dark().textTheme),
  primaryTextTheme: GoogleFonts.robotoTextTheme(ThemeData.dark().textTheme),
  scaffoldBackgroundColor: _darkColors.background,
  iconTheme: IconThemeData(color: _darkColors.iconActive, size: 26),
  appBarTheme: AppBarTheme(
    backgroundColor: _darkColors.background,
    elevation: 0,
    iconTheme: IconThemeData(color: _darkColors.iconActive, size: 26),
    actionsIconTheme: IconThemeData(color: _darkColors.iconActive, size: 26),
    titleTextStyle: YtText.appBarTitle.copyWith(color: _darkColors.textPrimary),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    backgroundColor: _darkColors.background,
    selectedItemColor: _darkColors.iconActive,
    unselectedItemColor: _darkColors.iconInactive,
    selectedLabelStyle: const TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w600,
    ),
    unselectedLabelStyle: const TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w600,
    ),
  ),
  listTileTheme: const ListTileThemeData(
    minLeadingWidth: 24,
    contentPadding: EdgeInsets.symmetric(horizontal: 20),
  ),
  dividerColor: _darkColors.divider,
  extensions: [_darkColors],
);
