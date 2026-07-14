import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/models/visit_model.dart';
import '../../../l10n/generated/app_localizations.dart';

void showVisitActionsSheet(BuildContext context, PatientModel patient) {
  final l10n = AppLocalizations.of(context);

  showModalBottomSheet(
    context: context,
    backgroundColor: context.palette.paper,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
    builder: (sheetContext) {
      final palette = sheetContext.palette;
      return SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(l10n.moreMenuTitle, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: palette.textTertiary)),
              ),
            ),
            ListTile(
              leading: Icon(Icons.call_rounded, color: palette.primary),
              title: Text(l10n.moreMenuCallPatient),
              onTap: () {
                Navigator.pop(sheetContext);
                launchUrl(Uri(scheme: 'tel', path: patient.phone));
              },
            ),
            ListTile(
              leading: Icon(Icons.email_rounded, color: palette.primary),
              title: Text(l10n.moreMenuEmailPatient),
              onTap: () {
                Navigator.pop(sheetContext);
                launchUrl(Uri(scheme: 'mailto', path: patient.email));
              },
            ),
            if (patient.emergencyContact != null && patient.emergencyPhone != null)
              ListTile(
                leading: Icon(Icons.emergency_rounded, color: palette.error),
                title: Text(l10n.moreMenuCallEmergencyContact(patient.emergencyContact!)),
                onTap: () {
                  Navigator.pop(sheetContext);
                  launchUrl(Uri(scheme: 'tel', path: patient.emergencyPhone));
                },
              ),
            const SizedBox(height: 8),
          ],
        ),
      );
    },
  );
}
