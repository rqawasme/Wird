import 'package:flutter/material.dart';

import 'mihrab_colors.dart';

/// Brand-specific tokens that do not map cleanly onto Material 3 [ColorScheme].
/// Access via `Theme.of(context).extension<MihrabThemeExtension>()!`.
@immutable
class MihrabThemeExtension extends ThemeExtension<MihrabThemeExtension> {
  const MihrabThemeExtension({
    required this.doneBadgeBackground,
    required this.doneBadgeForeground,
    required this.todoBadgeBackground,
    required this.todoBadgeForeground,
    required this.streakChipBackground,
    required this.streakChipForeground,
    required this.borderSubtle,
    required this.mutedForeground,
    required this.playerBackground,
    required this.playerOnBackground,
    required this.playerAccent,
  });

  final Color doneBadgeBackground;
  final Color doneBadgeForeground;
  final Color todoBadgeBackground;
  final Color todoBadgeForeground;
  final Color streakChipBackground;
  final Color streakChipForeground;
  final Color borderSubtle;
  final Color mutedForeground;

  /// Background of the focused player surface. In light mode this is the
  /// contemplative deep-teal dimming; in dark mode it matches the rest of
  /// the app to read as one lamp-lit room.
  final Color playerBackground;
  final Color playerOnBackground;
  final Color playerAccent;

  static const MihrabThemeExtension light = MihrabThemeExtension(
    doneBadgeBackground: MihrabPalette.doneBadgeBgLight,
    doneBadgeForeground: MihrabPalette.primaryDeepTeal,
    todoBadgeBackground: MihrabPalette.todoBadgeBgLight,
    todoBadgeForeground: MihrabPalette.todoBadgeFgLight,
    streakChipBackground: MihrabPalette.primaryDeepTeal,
    streakChipForeground: MihrabPalette.accentBrass,
    borderSubtle: MihrabPalette.borderSubtleLight,
    mutedForeground: MihrabPalette.textMutedLight,
    playerBackground: MihrabPalette.primaryDeepTeal,
    playerOnBackground: MihrabPalette.background,
    playerAccent: MihrabPalette.accentBrass,
  );

  static const MihrabThemeExtension dark = MihrabThemeExtension(
    doneBadgeBackground: MihrabPalette.doneBadgeBgDark,
    doneBadgeForeground: MihrabPalette.doneBadgeFgDark,
    todoBadgeBackground: MihrabPalette.todoBadgeBgDark,
    todoBadgeForeground: MihrabPalette.todoBadgeFgDark,
    streakChipBackground: MihrabPalette.surfaceDark,
    streakChipForeground: MihrabPalette.accentBrassDark,
    borderSubtle: MihrabPalette.borderSubtleDark,
    mutedForeground: MihrabPalette.textMutedDark,
    playerBackground: MihrabPalette.backgroundDark,
    playerOnBackground: MihrabPalette.textPrimaryDark,
    playerAccent: MihrabPalette.accentBrassDark,
  );

  @override
  MihrabThemeExtension copyWith({
    Color? doneBadgeBackground,
    Color? doneBadgeForeground,
    Color? todoBadgeBackground,
    Color? todoBadgeForeground,
    Color? streakChipBackground,
    Color? streakChipForeground,
    Color? borderSubtle,
    Color? mutedForeground,
    Color? playerBackground,
    Color? playerOnBackground,
    Color? playerAccent,
  }) {
    return MihrabThemeExtension(
      doneBadgeBackground: doneBadgeBackground ?? this.doneBadgeBackground,
      doneBadgeForeground: doneBadgeForeground ?? this.doneBadgeForeground,
      todoBadgeBackground: todoBadgeBackground ?? this.todoBadgeBackground,
      todoBadgeForeground: todoBadgeForeground ?? this.todoBadgeForeground,
      streakChipBackground: streakChipBackground ?? this.streakChipBackground,
      streakChipForeground: streakChipForeground ?? this.streakChipForeground,
      borderSubtle: borderSubtle ?? this.borderSubtle,
      mutedForeground: mutedForeground ?? this.mutedForeground,
      playerBackground: playerBackground ?? this.playerBackground,
      playerOnBackground: playerOnBackground ?? this.playerOnBackground,
      playerAccent: playerAccent ?? this.playerAccent,
    );
  }

  @override
  MihrabThemeExtension lerp(ThemeExtension<MihrabThemeExtension>? other, double t) {
    if (other is! MihrabThemeExtension) return this;
    return MihrabThemeExtension(
      doneBadgeBackground: Color.lerp(doneBadgeBackground, other.doneBadgeBackground, t)!,
      doneBadgeForeground: Color.lerp(doneBadgeForeground, other.doneBadgeForeground, t)!,
      todoBadgeBackground: Color.lerp(todoBadgeBackground, other.todoBadgeBackground, t)!,
      todoBadgeForeground: Color.lerp(todoBadgeForeground, other.todoBadgeForeground, t)!,
      streakChipBackground: Color.lerp(streakChipBackground, other.streakChipBackground, t)!,
      streakChipForeground: Color.lerp(streakChipForeground, other.streakChipForeground, t)!,
      borderSubtle: Color.lerp(borderSubtle, other.borderSubtle, t)!,
      mutedForeground: Color.lerp(mutedForeground, other.mutedForeground, t)!,
      playerBackground: Color.lerp(playerBackground, other.playerBackground, t)!,
      playerOnBackground: Color.lerp(playerOnBackground, other.playerOnBackground, t)!,
      playerAccent: Color.lerp(playerAccent, other.playerAccent, t)!,
    );
  }
}

extension MihrabThemeExtensionLookup on BuildContext {
  MihrabThemeExtension get mihrab => Theme.of(this).extension<MihrabThemeExtension>()!;
}
