import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// The PreDemention brand mark.
///
/// Renders `assets/images/logo.png` clipped to a rounded square. If the asset
/// is missing it falls back to the previous placeholder glyph so the UI never
/// breaks.
class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
    required this.size,
    this.borderRadius,
    this.fallbackColor = AppColors.primary,
  });

  final double size;
  final double? borderRadius;
  final Color fallbackColor;

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? size * 0.28;
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Image.asset(
        'assets/images/logo.png',
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Icon(
          Icons.psychology_rounded,
          size: size * 0.56,
          color: fallbackColor,
        ),
      ),
    );
  }
}
