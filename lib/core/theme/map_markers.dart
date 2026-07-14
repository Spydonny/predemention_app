import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'app_colors.dart';

/// Map pins drawn from the brand palette instead of Google's saturated
/// default teardrops: a calm cream-ringed dot, so the markers read as ink
/// on the map rather than as a foreign UI layer.
class MapMarkers {
  MapMarkers._();

  static const double _canvas = 88;
  static final Map<int, BitmapDescriptor> _cache = {};

  /// A filled dot in [color] with a cream ring — used for patient visits,
  /// tinted by visit status.
  static Future<BitmapDescriptor> dot(Color color) => _build(
        cacheKey: Object.hash(color.toARGB32(), 'dot'),
        paint: (canvas, center) {
          canvas
            ..drawCircle(center, 28, Paint()..color = AppColors.paper)
            ..drawCircle(center, 22, Paint()..color = color);
        },
      );

  /// The assistant's own position — a cream dot inside the brand green, so
  /// it reads as "you" without competing with the patient pins.
  static Future<BitmapDescriptor> assistant() => _build(
        cacheKey: Object.hash(AppColors.primary.toARGB32(), 'assistant'),
        paint: (canvas, center) {
          canvas
            ..drawCircle(center, 28, Paint()..color = AppColors.paper)
            ..drawCircle(center, 22, Paint()..color = AppColors.primary)
            ..drawCircle(center, 8, Paint()..color = AppColors.paper);
        },
      );

  static Future<BitmapDescriptor> _build({
    required int cacheKey,
    required void Function(Canvas canvas, Offset center) paint,
  }) async {
    final cached = _cache[cacheKey];
    if (cached != null) return cached;

    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    const center = Offset(_canvas / 2, _canvas / 2);

    // Soft grounding shadow so the pin lifts off the map without a glow.
    canvas.drawCircle(
      center.translate(0, 2),
      28,
      Paint()
        ..color = const Color(0x30000000)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4),
    );
    paint(canvas, center);

    final image = await recorder.endRecording().toImage(_canvas.toInt(), _canvas.toInt());
    final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
    final descriptor = BitmapDescriptor.bytes(bytes!.buffer.asUint8List());
    _cache[cacheKey] = descriptor;
    return descriptor;
  }
}
