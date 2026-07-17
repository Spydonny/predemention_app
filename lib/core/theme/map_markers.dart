import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'app_colors.dart';

/// Map pins drawn from the brand palette instead of Google's saturated
/// default teardrops: a calm cream-ringed dot, so the markers read as ink
/// on the map rather than as a foreign UI layer.
///
/// On the night map the grounding shadow would vanish into the dark ground,
/// so dark pins swap it for a soft cream "lantern glow" halo, and the
/// assistant dot uses the brightened night green for contrast.
class MapMarkers {
  MapMarkers._();

  static const double _canvas = 88;
  static final Map<int, BitmapDescriptor> _cache = {};

  /// A filled dot in [color] with a cream ring — used for patient visits,
  /// tinted by visit status.
  static Future<BitmapDescriptor> dot(Color color, {bool dark = false}) => _build(
        cacheKey: Object.hash(color.toARGB32(), 'dot', dark),
        dark: dark,
        paint: (canvas, center) {
          canvas
            ..drawCircle(center, 28, Paint()..color = dark ? AppColors.darkTextPrimary : AppColors.paper)
            ..drawCircle(center, 22, Paint()..color = color);
        },
      );

  /// The assistant's own position — a cream dot inside the brand green, so
  /// it reads as "you" without competing with the patient pins.
  static Future<BitmapDescriptor> assistant({bool dark = false}) => _build(
        cacheKey: Object.hash('assistant', dark),
        dark: dark,
        paint: (canvas, center) {
          final ring = dark ? AppColors.darkTextPrimary : AppColors.paper;
          final fill = dark ? AppColors.darkPrimary : AppColors.primary;
          canvas
            ..drawCircle(center, 28, Paint()..color = ring)
            ..drawCircle(center, 22, Paint()..color = fill)
            ..drawCircle(center, 8, Paint()..color = ring);
        },
      );

  static Future<BitmapDescriptor> _build({
    required int cacheKey,
    required bool dark,
    required void Function(Canvas canvas, Offset center) paint,
  }) async {
    final cached = _cache[cacheKey];
    if (cached != null) return cached;

    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    const center = Offset(_canvas / 2, _canvas / 2);

    if (dark) {
      // Lantern glow — lifts the pin off the night map where a shadow can't.
      canvas.drawCircle(
        center,
        32,
        Paint()
          ..color = AppColors.darkTextPrimary.withAlpha(70)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 7),
      );
    } else {
      // Soft grounding shadow so the pin lifts off the map without a glow.
      canvas.drawCircle(
        center.translate(0, 2),
        28,
        Paint()
          ..color = const Color(0x30000000)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4),
      );
    }
    paint(canvas, center);

    final image = await recorder.endRecording().toImage(_canvas.toInt(), _canvas.toInt());
    final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
    final descriptor = BitmapDescriptor.bytes(bytes!.buffer.asUint8List());
    _cache[cacheKey] = descriptor;
    return descriptor;
  }
}
