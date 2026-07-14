import 'package:flutter/material.dart';

/// PreDemention brand palette.
///
/// Philosophy (from brand references): a printed scientific page, not a
/// dashboard. Warm cream paper, deep natural green as the "ink" and the
/// single focal accent, muted earthy semantics. No bright health-tech
/// teal/blue/purple, no heavy shadows — hierarchy comes from ink, hairline
/// rules and negative space.
class AppColors {
  AppColors._();

  // --- Brand green (ink & focal panels) ---
  static const primary = Color(0xFF2E5A44);
  static const primaryLight = Color(0xFF3F7357);
  static const primaryDark = Color(0xFF21402E);

  // --- Surfaces: cream / paper ---
  static const surface = Color(0xFFEDE6D3); // warm cream background
  static const surfaceVariant = Color(0xFFE3DAC1); // sand — inputs, chips, quiet fills
  static const paper = Color(0xFFF5EFE0); // ivory card ("sheet" on the cream desk)
  static const cardBackground = paper;

  // --- Semantic (muted, earthy) ---
  static const success = Color(0xFF4E7B54); // muted green
  static const warning = Color(0xFFC08A3B); // ochre
  static const error = Color(0xFFB0533C); // clay / terracotta
  static const info = Color(0xFF4C7A70); // muted pine (never blue)

  // --- Ink ---
  static const textPrimary = Color(0xFF253026); // deep green-black
  static const textSecondary = Color(0xFF5A6657);
  static const textTertiary = Color(0xFF8B9385);
  static const textOnPrimary = Color(0xFFF3ECD9); // cream ink on green

  // --- Lines ---
  static const border = Color(0xFFD6CBAF); // sand hairline
  static const divider = Color(0xFFE4DAC0);

  // --- Risk scale ---
  static const riskLow = Color(0xFF4E7B54);
  static const riskMedium = Color(0xFFC08A3B);
  static const riskHigh = Color(0xFFB0533C);

  // --- Soft beige highlight (the active-badge tone in the brand deck) ---
  static const accent = Color(0xFFE6DDC3);

  // --- Secondary data hue, for charts/timelines that need a second ink ---
  static const secondaryInk = Color(0xFFA66A43); // bronze / terracotta, replaces old purple

  static ColorScheme get colorScheme => ColorScheme.fromSeed(
        seedColor: primary,
        brightness: Brightness.light,
        primary: primary,
        onPrimary: textOnPrimary,
        secondary: primaryLight,
        onSecondary: textOnPrimary,
        surface: surface,
        onSurface: textPrimary,
        error: error,
        onError: textOnPrimary,
      );

  // ============================================================
  // Dark companion — a considered dark edition of the same
  // editorial-paper identity, not a naive inversion. Deep
  // charcoal-green "desk", elevated dark "paper" cards, warm
  // cream ink, a brightened brand green for contrast.
  // ============================================================

  static const darkSurface = Color(0xFF1B211C); // deep charcoal-green desk
  static const darkSurfaceVariant = Color(0xFF2A322B);
  static const darkPaper = Color(0xFF232A24); // elevated card sheet
  static const darkBorder = Color(0xFF3A453A);
  static const darkDivider = Color(0xFF2E362D);

  static const darkTextPrimary = Color(0xFFEFE9D8); // warm cream ink
  static const darkTextSecondary = Color(0xFFB9C2B2);
  static const darkTextTertiary = Color(0xFF7C8A76);
  static const darkTextOnPrimary = Color(0xFF13251A);

  static const darkPrimary = Color(0xFF5B9873); // brightened for contrast on dark
  static const darkPrimaryLight = Color(0xFF7BB392);
  static const darkPrimaryDark = Color(0xFF3F7357);

  static const darkSuccess = Color(0xFF6FA377);
  static const darkWarning = Color(0xFFD9A24C);
  static const darkError = Color(0xFFC97056);
  static const darkInfo = Color(0xFF6FA79C);

  static ColorScheme get darkColorScheme => ColorScheme.fromSeed(
        seedColor: darkPrimary,
        brightness: Brightness.dark,
        primary: darkPrimary,
        onPrimary: darkTextOnPrimary,
        secondary: darkPrimaryLight,
        onSecondary: darkTextOnPrimary,
        surface: darkSurface,
        onSurface: darkTextPrimary,
        error: darkError,
        onError: darkTextOnPrimary,
      );
}

/// A bundle of the theme-adaptive tokens screens actually paint with.
/// Brand-fixed values (the green focal-panel color, risk-scale colors)
/// intentionally stay literal `AppColors.X` at call sites rather than
/// routing through here — they are brand constants, not surface tokens.
class AppPalette {
  final Color surface;
  final Color surfaceVariant;
  final Color paper;
  final Color border;
  final Color divider;
  final Color textPrimary;
  final Color textSecondary;
  final Color textTertiary;
  final Color textOnPrimary;
  final Color primary;
  final Color primaryLight;
  final Color primaryDark;
  final Color accent;
  final Color secondaryInk;
  final Color success;
  final Color warning;
  final Color error;
  final Color info;

  const AppPalette({
    required this.surface,
    required this.surfaceVariant,
    required this.paper,
    required this.border,
    required this.divider,
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.textOnPrimary,
    required this.primary,
    required this.primaryLight,
    required this.primaryDark,
    required this.accent,
    required this.secondaryInk,
    required this.success,
    required this.warning,
    required this.error,
    required this.info,
  });

  static const light = AppPalette(
    surface: AppColors.surface,
    surfaceVariant: AppColors.surfaceVariant,
    paper: AppColors.paper,
    border: AppColors.border,
    divider: AppColors.divider,
    textPrimary: AppColors.textPrimary,
    textSecondary: AppColors.textSecondary,
    textTertiary: AppColors.textTertiary,
    textOnPrimary: AppColors.textOnPrimary,
    primary: AppColors.primary,
    primaryLight: AppColors.primaryLight,
    primaryDark: AppColors.primaryDark,
    accent: AppColors.accent,
    secondaryInk: AppColors.secondaryInk,
    success: AppColors.success,
    warning: AppColors.warning,
    error: AppColors.error,
    info: AppColors.info,
  );

  static const dark = AppPalette(
    surface: AppColors.darkSurface,
    surfaceVariant: AppColors.darkSurfaceVariant,
    paper: AppColors.darkPaper,
    border: AppColors.darkBorder,
    divider: AppColors.darkDivider,
    textPrimary: AppColors.darkTextPrimary,
    textSecondary: AppColors.darkTextSecondary,
    textTertiary: AppColors.darkTextTertiary,
    textOnPrimary: AppColors.darkTextOnPrimary,
    primary: AppColors.darkPrimary,
    primaryLight: AppColors.darkPrimaryLight,
    primaryDark: AppColors.darkPrimaryDark,
    accent: AppColors.accent,
    secondaryInk: AppColors.secondaryInk,
    success: AppColors.darkSuccess,
    warning: AppColors.darkWarning,
    error: AppColors.darkError,
    info: AppColors.darkInfo,
  );
}

extension AppPaletteX on BuildContext {
  AppPalette get palette => Theme.of(this).brightness == Brightness.dark ? AppPalette.dark : AppPalette.light;
}
