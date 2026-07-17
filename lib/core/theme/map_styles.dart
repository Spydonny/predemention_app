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
  {"featureType": "poi.medical", "elementType": "geometry", "stylers": [{"color": "#DDE3C9"}]},
  {"featureType": "poi.medical", "elementType": "labels.text.fill", "stylers": [{"color": "#4E7B54"}]},
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

  /// The same survey at night, read by lantern light: moss-black ground,
  /// roads engraved a shade lighter, highways inked in warm brass, parks
  /// moonlit, water near-black. Mirrors AppColors' dark tokens.
  static const String dark = '''
[
  {"elementType": "geometry", "stylers": [{"color": "#14190F"}]},
  {"elementType": "labels.icon", "stylers": [{"visibility": "off"}]},
  {"elementType": "labels.text.fill", "stylers": [{"color": "#BCC4A6"}]},
  {"elementType": "labels.text.stroke", "stylers": [{"color": "#0F130B"}]},
  {"featureType": "administrative", "elementType": "geometry.stroke", "stylers": [{"color": "#3D462E"}]},
  {"featureType": "administrative.land_parcel", "elementType": "labels", "stylers": [{"visibility": "off"}]},
  {"featureType": "administrative.locality", "elementType": "labels.text.fill", "stylers": [{"color": "#F1EAD1"}]},
  {"featureType": "landscape.natural", "elementType": "geometry", "stylers": [{"color": "#171D11"}]},
  {"featureType": "poi", "elementType": "geometry", "stylers": [{"color": "#1D2416"}]},
  {"featureType": "poi", "elementType": "labels.text.fill", "stylers": [{"color": "#848E6D"}]},
  {"featureType": "poi.medical", "elementType": "geometry", "stylers": [{"color": "#25301E"}]},
  {"featureType": "poi.medical", "elementType": "labels.text.fill", "stylers": [{"color": "#92C8A3"}]},
  {"featureType": "poi.park", "elementType": "geometry", "stylers": [{"color": "#1B2A16"}]},
  {"featureType": "poi.park", "elementType": "labels.text.fill", "stylers": [{"color": "#7DAE7C"}]},
  {"featureType": "road", "elementType": "geometry", "stylers": [{"color": "#232B1B"}]},
  {"featureType": "road", "elementType": "geometry.stroke", "stylers": [{"color": "#14190F"}]},
  {"featureType": "road", "elementType": "labels.text.fill", "stylers": [{"color": "#848E6D"}]},
  {"featureType": "road.arterial", "elementType": "geometry", "stylers": [{"color": "#2B3421"}]},
  {"featureType": "road.highway", "elementType": "geometry", "stylers": [{"color": "#453E27"}]},
  {"featureType": "road.highway", "elementType": "geometry.stroke", "stylers": [{"color": "#2A2618"}]},
  {"featureType": "road.highway", "elementType": "labels.text.fill", "stylers": [{"color": "#DCA855"}]},
  {"featureType": "transit", "elementType": "geometry", "stylers": [{"color": "#1D2416"}]},
  {"featureType": "transit", "elementType": "labels", "stylers": [{"visibility": "off"}]},
  {"featureType": "water", "elementType": "geometry", "stylers": [{"color": "#0C120D"}]},
  {"featureType": "water", "elementType": "labels.text.fill", "stylers": [{"color": "#5E8A7C"}]}
]
''';

  /// The map follows the app's theme; the "dark map" setting can force the
  /// night style even while the app itself is light.
  static String forContext(BuildContext context, {required bool preferDark}) {
    final isDark = preferDark || Theme.of(context).brightness == Brightness.dark;
    return isDark ? dark : light;
  }
}
