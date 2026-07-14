import 'package:flutter/material.dart';

/// Google Maps JSON styles cut from the app's own palette, so the map reads
/// as part of the printed cream/green page rather than a foreign Google
/// surface. POI icons and transit labels are switched off — the map is a
/// quiet ground for the visit markers, not a place to browse.
class MapStyles {
  MapStyles._();

  /// Cream paper, sand roads, muted sage parks, soft green-grey water.
  static const String light = '''
[
  {"elementType": "geometry", "stylers": [{"color": "#EDE6D3"}]},
  {"elementType": "labels.icon", "stylers": [{"visibility": "off"}]},
  {"elementType": "labels.text.fill", "stylers": [{"color": "#5A6657"}]},
  {"elementType": "labels.text.stroke", "stylers": [{"color": "#F5EFE0"}]},
  {"featureType": "administrative", "elementType": "geometry.stroke", "stylers": [{"color": "#D6CBAF"}]},
  {"featureType": "administrative.land_parcel", "elementType": "labels", "stylers": [{"visibility": "off"}]},
  {"featureType": "administrative.locality", "elementType": "labels.text.fill", "stylers": [{"color": "#253026"}]},
  {"featureType": "landscape.natural", "elementType": "geometry", "stylers": [{"color": "#E7E0CB"}]},
  {"featureType": "poi", "elementType": "geometry", "stylers": [{"color": "#E3DAC1"}]},
  {"featureType": "poi", "elementType": "labels.text.fill", "stylers": [{"color": "#8B9385"}]},
  {"featureType": "poi.park", "elementType": "geometry", "stylers": [{"color": "#D8E0CC"}]},
  {"featureType": "poi.park", "elementType": "labels.text.fill", "stylers": [{"color": "#4E7B54"}]},
  {"featureType": "road", "elementType": "geometry", "stylers": [{"color": "#F5EFE0"}]},
  {"featureType": "road", "elementType": "geometry.stroke", "stylers": [{"color": "#DDD3BA"}]},
  {"featureType": "road", "elementType": "labels.text.fill", "stylers": [{"color": "#8B9385"}]},
  {"featureType": "road.arterial", "elementType": "geometry", "stylers": [{"color": "#F7F2E5"}]},
  {"featureType": "road.highway", "elementType": "geometry", "stylers": [{"color": "#E6DDC3"}]},
  {"featureType": "road.highway", "elementType": "geometry.stroke", "stylers": [{"color": "#D0C3A2"}]},
  {"featureType": "road.highway", "elementType": "labels.text.fill", "stylers": [{"color": "#5A6657"}]},
  {"featureType": "transit", "elementType": "geometry", "stylers": [{"color": "#E3DAC1"}]},
  {"featureType": "transit", "elementType": "labels", "stylers": [{"visibility": "off"}]},
  {"featureType": "water", "elementType": "geometry", "stylers": [{"color": "#C6D2C4"}]},
  {"featureType": "water", "elementType": "labels.text.fill", "stylers": [{"color": "#7C8A76"}]}
]
''';

  /// The same page at night: charcoal-green ground, elevated "paper" roads,
  /// cream ink. Mirrors AppColors' dark tokens.
  static const String dark = '''
[
  {"elementType": "geometry", "stylers": [{"color": "#1B211C"}]},
  {"elementType": "labels.icon", "stylers": [{"visibility": "off"}]},
  {"elementType": "labels.text.fill", "stylers": [{"color": "#B9C2B2"}]},
  {"elementType": "labels.text.stroke", "stylers": [{"color": "#1B211C"}]},
  {"featureType": "administrative", "elementType": "geometry.stroke", "stylers": [{"color": "#3A453A"}]},
  {"featureType": "administrative.land_parcel", "elementType": "labels", "stylers": [{"visibility": "off"}]},
  {"featureType": "administrative.locality", "elementType": "labels.text.fill", "stylers": [{"color": "#EFE9D8"}]},
  {"featureType": "landscape.natural", "elementType": "geometry", "stylers": [{"color": "#1F261F"}]},
  {"featureType": "poi", "elementType": "geometry", "stylers": [{"color": "#252D26"}]},
  {"featureType": "poi", "elementType": "labels.text.fill", "stylers": [{"color": "#7C8A76"}]},
  {"featureType": "poi.park", "elementType": "geometry", "stylers": [{"color": "#22301F"}]},
  {"featureType": "poi.park", "elementType": "labels.text.fill", "stylers": [{"color": "#6FA377"}]},
  {"featureType": "road", "elementType": "geometry", "stylers": [{"color": "#2A322B"}]},
  {"featureType": "road", "elementType": "geometry.stroke", "stylers": [{"color": "#1B211C"}]},
  {"featureType": "road", "elementType": "labels.text.fill", "stylers": [{"color": "#7C8A76"}]},
  {"featureType": "road.arterial", "elementType": "geometry", "stylers": [{"color": "#2F382F"}]},
  {"featureType": "road.highway", "elementType": "geometry", "stylers": [{"color": "#3A453A"}]},
  {"featureType": "road.highway", "elementType": "geometry.stroke", "stylers": [{"color": "#232A24"}]},
  {"featureType": "road.highway", "elementType": "labels.text.fill", "stylers": [{"color": "#D9A24C"}]},
  {"featureType": "transit", "elementType": "geometry", "stylers": [{"color": "#252D26"}]},
  {"featureType": "transit", "elementType": "labels", "stylers": [{"visibility": "off"}]},
  {"featureType": "water", "elementType": "geometry", "stylers": [{"color": "#131C16"}]},
  {"featureType": "water", "elementType": "labels.text.fill", "stylers": [{"color": "#4C7A70"}]}
]
''';

  /// The map follows the app's theme; the "dark map" setting can force the
  /// night style even while the app itself is light.
  static String forContext(BuildContext context, {required bool preferDark}) {
    final isDark = preferDark || Theme.of(context).brightness == Brightness.dark;
    return isDark ? dark : light;
  }
}
