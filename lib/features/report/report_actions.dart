import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/models/assessment_model.dart';
import '../../core/theme/app_colors.dart';
import '../../l10n/generated/app_localizations.dart';

String buildReportPlainText(ReportModel report) {
  final buffer = StringBuffer()
    ..writeln('PreDemention — ${report.patientName}')
    ..writeln('${report.id} • ${DateFormat('dd.MM.yyyy HH:mm').format(report.createdAt)}')
    ..writeln()
    ..writeln('Risk Score: ${report.riskScore.toStringAsFixed(1)}% (${report.riskLevel})')
    ..writeln('Confidence: ${report.confidence.toStringAsFixed(1)}% (${report.confidenceLevel})')
    ..writeln()
    ..writeln('Conclusion:')
    ..writeln(report.conclusion)
    ..writeln()
    ..writeln('Key observations:');
  for (final o in report.keyObservations) {
    buffer.writeln('- $o');
  }
  buffer
    ..writeln()
    ..writeln('Recommendations:');
  for (final r in report.recommendations) {
    buffer.writeln('- $r');
  }
  buffer
    ..writeln()
    ..writeln('Metrics:');
  for (final entry in report.metrics.entries) {
    buffer.writeln('- ${entry.key}: ${entry.value.toStringAsFixed(1)}');
  }
  return buffer.toString();
}

Future<void> sendReportToDoctor(ReportModel report) {
  return launchUrl(
    Uri(
      scheme: 'mailto',
      queryParameters: {
        'subject': 'PreDemention — ${report.patientName}',
        'body': buildReportPlainText(report),
      },
    ),
  );
}

Future<void> copyReportToClipboard(BuildContext context, ReportModel report) async {
  await Clipboard.setData(ClipboardData(text: buildReportPlainText(report)));
  if (!context.mounted) return;
  final l10n = AppLocalizations.of(context)!;
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.reportCopiedSnackbar)));
}

void showReportActionsSheet(BuildContext context, ReportModel report) {
  final l10n = AppLocalizations.of(context)!;
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
                child: Text(l10n.reportActionsSheetTitle, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: palette.textTertiary)),
              ),
            ),
            ListTile(
              leading: Icon(Icons.send_rounded, color: palette.primary),
              title: Text(l10n.reportActionSend),
              onTap: () {
                Navigator.pop(sheetContext);
                sendReportToDoctor(report);
              },
            ),
            ListTile(
              leading: Icon(Icons.copy_rounded, color: palette.primary),
              title: Text(l10n.reportActionCopy),
              onTap: () {
                Navigator.pop(sheetContext);
                copyReportToClipboard(context, report);
              },
            ),
            const SizedBox(height: 8),
          ],
        ),
      );
    },
  );
}
