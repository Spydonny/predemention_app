import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../core/models/visit_model.dart';
import '../../../core/theme/map_styles.dart';
import '../../../l10n/generated/app_localizations.dart';

class HomeMap extends StatelessWidget {
  final List<VisitModel> visits;
  final bool darkMap;

  const HomeMap({super.key, required this.visits, this.darkMap = false});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    // Center on Almaty
    const center = LatLng(43.2380, 76.8829);

    final markers = visits.where((v) => v.status != VisitStatus.cancelled).map((v) {
      final hue = switch (v.status) {
        VisitStatus.completed => BitmapDescriptor.hueGreen,
        VisitStatus.inProgress || VisitStatus.arriving => BitmapDescriptor.hueCyan,
        _ => BitmapDescriptor.hueAzure,
      };

      return Marker(
        markerId: MarkerId(v.id),
        position: LatLng(v.patient.lat, v.patient.lng),
        infoWindow: InfoWindow(
          title: v.patient.fullName,
          snippet: '${v.status.label(context)} • ${v.scheduledTime.hour}:${v.scheduledTime.minute.toString().padLeft(2, '0')}',
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(hue),
      );
    }).toSet();

    // Assistant marker
    markers.add(
      Marker(
        markerId: const MarkerId('assistant'),
        position: const LatLng(43.2567, 76.9285),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
        infoWindow: InfoWindow(title: l10n.mapYouAreHere),
      ),
    );

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(28)),
      child: Stack(
        fit: StackFit.expand,
        children: [
          GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: center,
              zoom: 12,
            ),
            style: darkMap ? MapStyles.dark : null,
            markers: markers,
            myLocationEnabled: false,
            zoomControlsEnabled: false,
            mapToolbarEnabled: false,
            compassEnabled: false,
          ),
        ],
      ),
    );
  }
}
