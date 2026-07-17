import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../core/models/visit_model.dart';
import '../../../core/theme/map_styles.dart';
import '../../../core/theme/map_markers.dart';
import '../../../l10n/generated/app_localizations.dart';

class HomeMap extends StatefulWidget {
  final List<VisitModel> visits;
  final bool darkMap;

  const HomeMap({super.key, required this.visits, this.darkMap = false});

  @override
  State<HomeMap> createState() => _HomeMapState();
}

class _HomeMapState extends State<HomeMap> {
  Map<VisitStatus, BitmapDescriptor> _statusIcons = {};
  BitmapDescriptor? _assistantIcon;
  bool? _loadedDark;

  // Marker darkness must track the map style (darkMap setting OR app theme),
  // and the theme is only readable after initState — so load here.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final dark = widget.darkMap || Theme.of(context).brightness == Brightness.dark;
    if (dark != _loadedDark) {
      _loadedDark = dark;
      _loadIcons(dark: dark);
    }
  }

  Future<void> _loadIcons({required bool dark}) async {
    final icons = <VisitStatus, BitmapDescriptor>{};
    for (final status in VisitStatus.values) {
      icons[status] = await MapMarkers.dot(status.color, dark: dark);
    }
    final assistant = await MapMarkers.assistant(dark: dark);
    if (!mounted || dark != _loadedDark) return;
    setState(() {
      _statusIcons = icons;
      _assistantIcon = assistant;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    // Center on Almaty
    const center = LatLng(43.2380, 76.8829);

    final markers = widget.visits.where((v) => v.status != VisitStatus.cancelled).map((v) {
      return Marker(
        markerId: MarkerId(v.id),
        position: LatLng(v.patient.lat, v.patient.lng),
        infoWindow: InfoWindow(
          title: v.patient.fullName,
          snippet: '${v.status.label(context)} • ${v.scheduledTime.hour}:${v.scheduledTime.minute.toString().padLeft(2, '0')}',
        ),
        icon: _statusIcons[v.status] ?? BitmapDescriptor.defaultMarker,
      );
    }).toSet();

    // Assistant marker
    markers.add(
      Marker(
        markerId: const MarkerId('assistant'),
        position: const LatLng(43.2567, 76.9285),
        icon: _assistantIcon ?? BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(title: l10n.mapYouAreHere),
      ),
    );

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(28)),
      child: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: center,
          zoom: 12,
        ),
        style: MapStyles.forContext(context, preferDark: widget.darkMap),
        markers: markers,
        myLocationEnabled: false,
        zoomControlsEnabled: false,
        mapToolbarEnabled: false,
        compassEnabled: false,
      ),
    );
  }
}
