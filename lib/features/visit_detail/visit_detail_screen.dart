import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/map_styles.dart';
import '../../core/widgets/app_scaffold.dart';
import '../../core/providers/app_providers.dart';
import '../../core/providers/settings_provider.dart';
import '../../core/models/visit_model.dart';
import '../../l10n/generated/app_localizations.dart';
import 'widgets/visit_actions_sheet.dart';

class VisitDetailScreen extends ConsumerWidget {
  final String visitId;

  const VisitDetailScreen({super.key, required this.visitId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final palette = context.palette;
    final visits = ref.watch(allVisitsProvider);
    final visit = visits.where((v) => v.id == visitId).firstOrNull;
    final darkMap = ref.watch(settingsControllerProvider).darkMap;

    if (visit == null) {
      return Scaffold(
        body: Center(child: Text(l10n.visitNotFound)),
      );
    }

    final patientPos = LatLng(visit.patient.lat, visit.patient.lng);
    final assistantPos = LatLng(visit.assistantLat, visit.assistantLng);
    final midLat = (patientPos.latitude + assistantPos.latitude) / 2;
    final midLng = (patientPos.longitude + assistantPos.longitude) / 2;
    final locale = Localizations.localeOf(context).languageCode;

    return Scaffold(
      backgroundColor: palette.surface,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              pinned: true,
              backgroundColor: palette.surface,
              surfaceTintColor: Colors.transparent,
              title: Text(visit.patient.fullName),
              actions: [
                IconButton(
                  icon: const Icon(Icons.more_vert_rounded),
                  onPressed: () => showVisitActionsSheet(context, visit.patient),
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Status & Time
                    Row(
                      children: [
                        StatusBadge(label: visit.status.label(context), color: visit.status.color),
                        const Spacer(),
                        Icon(Icons.access_time_rounded, size: 16, color: palette.textTertiary),
                        const SizedBox(width: 4),
                        Text(
                          DateFormat('dd MMM HH:mm', locale).format(visit.scheduledTime),
                          style: TextStyle(fontSize: 13, color: palette.textSecondary),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Map Card
                    _MapCard(
                      patientPos: patientPos,
                      assistantPos: assistantPos,
                      midLat: midLat,
                      midLng: midLng,
                      patientName: visit.patient.fullName,
                      distanceKm: visit.distanceKm,
                      arrivalMinutes: visit.estimatedArrivalMinutes,
                      patientLat: visit.patient.lat,
                      patientLng: visit.patient.lng,
                      darkMap: darkMap,
                    ),
                    const SizedBox(height: 20),

                    // Patient Info
                    SectionHeader(title: l10n.sectionPatient),
                    const SizedBox(height: 12),
                    _PatientInfoCard(patient: visit.patient),
                    const SizedBox(height: 20),

                    // Contacts
                    SectionHeader(title: l10n.sectionContacts),
                    const SizedBox(height: 12),
                    _ContactCard(patient: visit.patient),
                    const SizedBox(height: 20),

                    // Notes
                    if (visit.notes != null && visit.notes!.isNotEmpty) ...[
                      SectionHeader(title: l10n.sectionNotes),
                      const SizedBox(height: 12),
                      _NotesCard(notes: visit.notes!),
                      const SizedBox(height: 20),
                    ],

                    // Conditions
                    SectionHeader(title: l10n.sectionConditions),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: visit.patient.conditions.map((c) => Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              color: palette.surfaceVariant,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(c, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: palette.textPrimary)),
                          )).toList(),
                    ),
                    const SizedBox(height: 24),

                    // Action Button
                    if (visit.status == VisitStatus.scheduled ||
                        visit.status == VisitStatus.inTransit ||
                        visit.status == VisitStatus.arriving)
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton.icon(
                          onPressed: () => context.push('/device/${visit.id}'),
                          icon: const Icon(Icons.bluetooth_connected_rounded),
                          label: Text(l10n.startAssessmentButton),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: AppColors.paper,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          ),
                        ),
                      ),
                    if (visit.status == VisitStatus.inProgress)
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton.icon(
                          onPressed: () => context.push('/assessment/${visit.id}'),
                          icon: const Icon(Icons.biotech_rounded),
                          label: Text(l10n.continueAssessmentButton),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: palette.success,
                            foregroundColor: AppColors.paper,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          ),
                        ),
                      ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MapCard extends StatelessWidget {
  final LatLng patientPos;
  final LatLng assistantPos;
  final double midLat, midLng;
  final String patientName;
  final double distanceKm;
  final int arrivalMinutes;
  final double patientLat, patientLng;
  final bool darkMap;

  const _MapCard({
    required this.patientPos,
    required this.assistantPos,
    required this.midLat,
    required this.midLng,
    required this.patientName,
    required this.distanceKm,
    required this.arrivalMinutes,
    required this.patientLat,
    required this.patientLng,
    required this.darkMap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final palette = context.palette;
    return Container(
      decoration: BoxDecoration(
        color: palette.paper,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withAlpha(8), blurRadius: 16, offset: const Offset(0, 6))],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          SizedBox(
            height: 200,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(target: LatLng(midLat, midLng), zoom: 14),
              style: darkMap ? MapStyles.dark : null,
              markers: {
                Marker(
                  markerId: const MarkerId('patient'),
                  position: patientPos,
                  icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
                  infoWindow: InfoWindow(title: patientName),
                ),
                Marker(
                  markerId: const MarkerId('assistant'),
                  position: assistantPos,
                  icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
                  infoWindow: InfoWindow(title: l10n.mapYouAreHere),
                ),
              },
              zoomControlsEnabled: false,
              mapToolbarEnabled: false,
              compassEnabled: false,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    _InfoChip(icon: Icons.straighten_rounded, label: l10n.distanceKmLabel(distanceKm.toStringAsFixed(1))),
                    const SizedBox(width: 12),
                    _InfoChip(icon: Icons.timer_outlined, label: l10n.etaMinutesLabel(arrivalMinutes)),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () => _openMaps(patientLat, patientLng),
                    icon: const Icon(Icons.directions_rounded),
                    label: Text(l10n.buildRouteButton),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _openMaps(double lat, double lng) async {
    final url = 'https://www.google.com/maps/dir/?api=1&destination=$lat,$lng';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: palette.surfaceVariant,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: palette.primary),
          const SizedBox(width: 6),
          Text(label, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: palette.textPrimary)),
        ],
      ),
    );
  }
}

class _PatientInfoCard extends StatelessWidget {
  final PatientModel patient;

  const _PatientInfoCard({required this.patient});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final palette = context.palette;
    final locale = Localizations.localeOf(context).languageCode;
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: palette.paper,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: palette.border.withAlpha(100)),
      ),
      child: Column(
        children: [
          _InfoRow(icon: Icons.person_rounded, label: l10n.fieldFullName, value: patient.fullName),
          const Divider(height: 24),
          _InfoRow(
            icon: Icons.cake_rounded,
            label: l10n.fieldAge,
            value: l10n.fieldAgeValue(patient.age, patient.gender == 'M' ? l10n.genderMale : l10n.genderFemale),
          ),
          const Divider(height: 24),
          _InfoRow(icon: Icons.location_on_outlined, label: l10n.fieldAddress, value: patient.address),
          const Divider(height: 24),
          _InfoRow(icon: Icons.local_hospital_rounded, label: l10n.fieldRegistered, value: DateFormat('dd MMMM yyyy', locale).format(patient.registeredAt)),
        ],
      ),
    );
  }
}

class _ContactCard extends StatelessWidget {
  final PatientModel patient;

  const _ContactCard({required this.patient});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final palette = context.palette;
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: palette.paper,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: palette.border.withAlpha(100)),
      ),
      child: Column(
        children: [
          _InfoRow(icon: Icons.call_rounded, label: l10n.fieldPhone, value: patient.phone),
          const Divider(height: 24),
          _InfoRow(icon: Icons.email_rounded, label: l10n.fieldEmail, value: patient.email),
          const Divider(height: 24),
          _InfoRow(icon: Icons.location_city_rounded, label: l10n.fieldCity, value: patient.city),
          if (patient.emergencyContact != null) ...[
            const Divider(height: 24),
            _InfoRow(icon: Icons.emergency_rounded, label: l10n.fieldEmergencyContact, value: '${patient.emergencyContact}\n${patient.emergencyPhone}'),
          ],
        ],
      ),
    );
  }
}

class _NotesCard extends StatelessWidget {
  final String notes;

  const _NotesCard({required this.notes});

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFEFE4C8),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: palette.warning.withAlpha(80)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.notes_rounded, color: palette.warning, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(notes, style: TextStyle(fontSize: 14, color: palette.textPrimary, height: 1.5)),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: palette.surfaceVariant,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 18, color: palette.textSecondary),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: TextStyle(fontSize: 11, color: palette.textTertiary, fontWeight: FontWeight.w500)),
              const SizedBox(height: 2),
              Text(value, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: palette.textPrimary)),
            ],
          ),
        ),
      ],
    );
  }
}
