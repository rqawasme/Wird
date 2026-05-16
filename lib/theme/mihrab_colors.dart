import 'package:flutter/material.dart';

/// Raw palette tokens. Widgets should never reach for these directly — go
/// through `Theme.of(context).colorScheme` or the [MihrabThemeExtension].
/// Kept here only to centralise the source of truth for both schemes.
class MihrabPalette {
  const MihrabPalette._();

  // Light (Mihrab)
  static const Color primaryDeepTeal = Color(0xFF0F3D3E);
  static const Color secondaryWarmSand = Color(0xFFE8DCC4);
  static const Color background = Color(0xFFFAF7F0);
  static const Color cardSurface = Color(0xFFFFFFFF);
  static const Color accentBrass = Color(0xFFC9A961);
  static const Color textPrimaryLight = Color(0xFF1A1A1A);
  static const Color textMutedLight = Color(0xFF6B6356);
  static const Color borderSubtleLight = Color(0x1F0F3D3E); // teal @ 12%
  static const Color doneBadgeBgLight = Color(0x140F3D3E); // teal @ 8%
  static const Color todoBadgeBgLight = Color(0xFFC9A961);
  static const Color todoBadgeFgLight = Color(0xFF4A3A1A);

  // Dark (lamp-lit room)
  static const Color backgroundDark = Color(0xFF0A1414);
  static const Color surfaceDark = Color(0xFF152222);
  static const Color borderSubtleDark = Color(0xFF1F2E2E);
  static const Color textPrimaryDark = Color(0xFFFAF7F0);
  static const Color textMutedDark = Color(0xFF8A9292);
  static const Color accentBrassDark = Color(0xFFD4B574);
  static const Color doneBadgeBgDark = Color(0x24D4B574); // ~14%
  static const Color doneBadgeFgDark = Color(0xFFD4B574);
  static const Color todoBadgeBgDark = Color(0xFFD4B574);
  static const Color todoBadgeFgDark = Color(0xFF3D2E12);
}

ColorScheme buildLightScheme() => const ColorScheme(
      brightness: Brightness.light,
      primary: MihrabPalette.primaryDeepTeal,
      onPrimary: MihrabPalette.background,
      primaryContainer: MihrabPalette.secondaryWarmSand,
      onPrimaryContainer: MihrabPalette.primaryDeepTeal,
      secondary: MihrabPalette.accentBrass,
      onSecondary: MihrabPalette.todoBadgeFgLight,
      secondaryContainer: MihrabPalette.secondaryWarmSand,
      onSecondaryContainer: MihrabPalette.textPrimaryLight,
      tertiary: MihrabPalette.accentBrass,
      onTertiary: MihrabPalette.textPrimaryLight,
      error: Color(0xFFB3261E),
      onError: MihrabPalette.background,
      surface: MihrabPalette.cardSurface,
      onSurface: MihrabPalette.textPrimaryLight,
      surfaceContainerHighest: MihrabPalette.background,
      surfaceContainerHigh: MihrabPalette.background,
      surfaceContainer: MihrabPalette.background,
      surfaceContainerLow: MihrabPalette.background,
      surfaceContainerLowest: MihrabPalette.cardSurface,
      onSurfaceVariant: MihrabPalette.textMutedLight,
      outline: MihrabPalette.borderSubtleLight,
      outlineVariant: MihrabPalette.borderSubtleLight,
      shadow: Color(0x00000000),
      scrim: Color(0x66000000),
      inverseSurface: MihrabPalette.primaryDeepTeal,
      onInverseSurface: MihrabPalette.background,
      inversePrimary: MihrabPalette.accentBrass,
    );

ColorScheme buildDarkScheme() => const ColorScheme(
      brightness: Brightness.dark,
      primary: MihrabPalette.accentBrassDark,
      onPrimary: MihrabPalette.todoBadgeFgDark,
      primaryContainer: MihrabPalette.surfaceDark,
      onPrimaryContainer: MihrabPalette.accentBrassDark,
      secondary: MihrabPalette.accentBrassDark,
      onSecondary: MihrabPalette.todoBadgeFgDark,
      secondaryContainer: MihrabPalette.surfaceDark,
      onSecondaryContainer: MihrabPalette.textPrimaryDark,
      tertiary: MihrabPalette.accentBrassDark,
      onTertiary: MihrabPalette.todoBadgeFgDark,
      error: Color(0xFFF2B8B5),
      onError: Color(0xFF601410),
      surface: MihrabPalette.surfaceDark,
      onSurface: MihrabPalette.textPrimaryDark,
      surfaceContainerHighest: MihrabPalette.surfaceDark,
      surfaceContainerHigh: MihrabPalette.surfaceDark,
      surfaceContainer: MihrabPalette.surfaceDark,
      surfaceContainerLow: MihrabPalette.backgroundDark,
      surfaceContainerLowest: MihrabPalette.backgroundDark,
      onSurfaceVariant: MihrabPalette.textMutedDark,
      outline: MihrabPalette.borderSubtleDark,
      outlineVariant: MihrabPalette.borderSubtleDark,
      shadow: Color(0x00000000),
      scrim: Color(0x99000000),
      inverseSurface: MihrabPalette.background,
      onInverseSurface: MihrabPalette.primaryDeepTeal,
      inversePrimary: MihrabPalette.primaryDeepTeal,
    );
