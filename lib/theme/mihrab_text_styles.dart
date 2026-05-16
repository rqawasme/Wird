import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Typography tokens that fall outside the Material 3 [TextTheme]. Arabic and
/// transliteration styles live here so the Arabic font can be swapped in a
/// single place when a bundled font replaces the system fallback.
@immutable
class MihrabTextStyles extends ThemeExtension<MihrabTextStyles> {
  const MihrabTextStyles({
    required this.arabic,
    required this.arabicLarge,
    required this.transliteration,
    required this.translation,
    required this.virtues,
    required this.sourceCitation,
  });

  /// Standard Arabic body style. Larger than English body — Arabic glyphs
  /// rely on relative size to be readable. TODO(wird): swap the fontFamily
  /// when a proper Arabic font is bundled.
  final TextStyle arabic;
  final TextStyle arabicLarge;
  final TextStyle transliteration;
  final TextStyle translation;
  final TextStyle virtues;
  final TextStyle sourceCitation;

  static MihrabTextStyles forBrightness(Brightness brightness, ColorScheme scheme) {
    final muted = scheme.onSurfaceVariant;
    final onSurface = scheme.onSurface;
    return MihrabTextStyles(
      arabic: TextStyle(
        fontFamily: null,
        fontSize: 24,
        height: 1.6,
        color: onSurface,
        fontWeight: FontWeight.w500,
      ),
      arabicLarge: TextStyle(
        fontFamily: null,
        fontSize: 32,
        height: 1.7,
        color: onSurface,
        fontWeight: FontWeight.w500,
      ),
      transliteration: GoogleFonts.poppins(
        fontSize: 15,
        fontStyle: FontStyle.italic,
        color: muted,
        height: 1.4,
      ),
      translation: GoogleFonts.poppins(
        fontSize: 16,
        height: 1.5,
        color: onSurface,
      ),
      virtues: GoogleFonts.poppins(
        fontSize: 13,
        height: 1.5,
        color: muted,
      ),
      sourceCitation: GoogleFonts.poppins(
        fontSize: 12,
        fontStyle: FontStyle.italic,
        color: muted,
      ),
    );
  }

  @override
  MihrabTextStyles copyWith({
    TextStyle? arabic,
    TextStyle? arabicLarge,
    TextStyle? transliteration,
    TextStyle? translation,
    TextStyle? virtues,
    TextStyle? sourceCitation,
  }) {
    return MihrabTextStyles(
      arabic: arabic ?? this.arabic,
      arabicLarge: arabicLarge ?? this.arabicLarge,
      transliteration: transliteration ?? this.transliteration,
      translation: translation ?? this.translation,
      virtues: virtues ?? this.virtues,
      sourceCitation: sourceCitation ?? this.sourceCitation,
    );
  }

  @override
  MihrabTextStyles lerp(ThemeExtension<MihrabTextStyles>? other, double t) {
    if (other is! MihrabTextStyles) return this;
    return MihrabTextStyles(
      arabic: TextStyle.lerp(arabic, other.arabic, t)!,
      arabicLarge: TextStyle.lerp(arabicLarge, other.arabicLarge, t)!,
      transliteration: TextStyle.lerp(transliteration, other.transliteration, t)!,
      translation: TextStyle.lerp(translation, other.translation, t)!,
      virtues: TextStyle.lerp(virtues, other.virtues, t)!,
      sourceCitation: TextStyle.lerp(sourceCitation, other.sourceCitation, t)!,
    );
  }
}

extension MihrabTextStylesLookup on BuildContext {
  MihrabTextStyles get mihrabText => Theme.of(this).extension<MihrabTextStyles>()!;
}
