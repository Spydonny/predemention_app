/// Google Maps JSON styles matching the app's editorial cream/green identity.
class MapStyles {
  MapStyles._();

  /// Standard Google "Night" style, applied when the user enables the
  /// "Тёмная тема карты" setting.
  static const String dark = '''
[
  {"elementType": "geometry", "stylers": [{"color": "#1b211c"}]},
  {"elementType": "labels.text.stroke", "stylers": [{"color": "#1b211c"}]},
  {"elementType": "labels.text.fill", "stylers": [{"color": "#8ec3b9"}]},
  {"featureType": "administrative.locality", "elementType": "labels.text.fill", "stylers": [{"color": "#d6cbaf"}]},
  {"featureType": "poi", "elementType": "labels.text.fill", "stylers": [{"color": "#6b9080"}]},
  {"featureType": "poi.park", "elementType": "geometry", "stylers": [{"color": "#243528"}]},
  {"featureType": "poi.park", "elementType": "labels.text.fill", "stylers": [{"color": "#4e7b54"}]},
  {"featureType": "road", "elementType": "geometry", "stylers": [{"color": "#2a322b"}]},
  {"featureType": "road", "elementType": "geometry.stroke", "stylers": [{"color": "#1b211c"}]},
  {"featureType": "road", "elementType": "labels.text.fill", "stylers": [{"color": "#7c8a76"}]},
  {"featureType": "road.highway", "elementType": "geometry", "stylers": [{"color": "#3a453a"}]},
  {"featureType": "road.highway", "elementType": "labels.text.fill", "stylers": [{"color": "#d9a24c"}]},
  {"featureType": "transit", "elementType": "geometry", "stylers": [{"color": "#2a322b"}]},
  {"featureType": "water", "elementType": "geometry", "stylers": [{"color": "#13251a"}]},
  {"featureType": "water", "elementType": "labels.text.fill", "stylers": [{"color": "#4c7a70"}]}
]
''';
}
