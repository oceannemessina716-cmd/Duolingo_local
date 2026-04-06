import 'dart:ui';

/// Facteur d’opacité appliqué via [Color.withValues] (remplacement de l’API dépréciée sur [Color]).
extension ColorAlphaFactor on Color {
  /// Même effet visuel que l’ancienne multiplication d’alpha par [factor] (0–1).
  Color alphaFactor(double factor) {
    return withValues(alpha: (a * factor).clamp(0.0, 1.0));
  }
}
