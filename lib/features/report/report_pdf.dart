import 'dart:typed_data';

import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../core/models/assessment_model.dart';
import '../../l10n/generated/app_localizations.dart';

const _primary = PdfColor.fromInt(0xFF2E5A44);
const _paper = PdfColor.fromInt(0xFFF5EFE0);
const _surface = PdfColor.fromInt(0xFFEDE6D3);
const _textPrimary = PdfColor.fromInt(0xFF253026);
const _textSecondary = PdfColor.fromInt(0xFF5A6657);
const _success = PdfColor.fromInt(0xFF4E7B54);
const _warning = PdfColor.fromInt(0xFFC08A3B);
const _error = PdfColor.fromInt(0xFFB0533C);
const _info = PdfColor.fromInt(0xFF4C7A70);
const _border = PdfColor.fromInt(0xFFD6CBAF);

Future<Uint8List> buildReportPdf({
  required ReportModel report,
  required AppLocalizations l10n,
  required String localeCode,
}) async {
  final regular = await PdfGoogleFonts.notoSansRegular();
  final bold = await PdfGoogleFonts.notoSansBold();
  final semiBold = await PdfGoogleFonts.notoSansSemiBold();

  final dateFormat = DateFormat('dd.MM.yyyy HH:mm', localeCode);
  final timeFormat = DateFormat('HH:mm:ss', localeCode);
  final riskColor = report.riskScore < 30
      ? _success
      : report.riskScore < 60
          ? _warning
          : _error;

  final doc = pw.Document(
    theme: pw.ThemeData.withFont(
      base: regular,
      bold: bold,
    ),
  );

  doc.addPage(
    pw.MultiPage(
      pageTheme: pw.PageTheme(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        theme: pw.ThemeData.withFont(base: regular, bold: bold),
        buildBackground: (context) => pw.FullPage(
          ignoreMargins: true,
          child: pw.Container(color: _surface),
        ),
      ),
      build: (context) => [
        _buildHeader(report, dateFormat, regular, bold, semiBold),
        pw.SizedBox(height: 20),
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Expanded(
              child: _buildScoreCard(
                title: 'Risk Score',
                value: '${report.riskScore.toStringAsFixed(1)}%',
                level: report.riskLevel,
                color: riskColor,
                bold: bold,
                semiBold: semiBold,
                regular: regular,
              ),
            ),
            pw.SizedBox(width: 12),
            pw.Expanded(
              child: _buildScoreCard(
                title: 'Confidence',
                value: '${report.confidence.toStringAsFixed(1)}%',
                level: report.confidenceLevel,
                color: _info,
                bold: bold,
                semiBold: semiBold,
                regular: regular,
              ),
            ),
          ],
        ),
        pw.SizedBox(height: 20),
        _sectionTitle(l10n.sectionConclusion, semiBold),
        pw.SizedBox(height: 8),
        _contentCard(
          child: pw.Text(
            report.conclusion,
            style: pw.TextStyle(font: regular, fontSize: 11, height: 1.6, color: _textPrimary),
          ),
        ),
        pw.SizedBox(height: 16),
        _sectionTitle(l10n.sectionKeyObservations, semiBold),
        pw.SizedBox(height: 8),
        _contentCard(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              for (final obs in report.keyObservations) ...[
                pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Container(
                      width: 6,
                      height: 6,
                      margin: const pw.EdgeInsets.only(top: 5),
                      decoration: const pw.BoxDecoration(color: _warning, shape: pw.BoxShape.circle),
                    ),
                    pw.SizedBox(width: 8),
                    pw.Expanded(
                      child: pw.Text(
                        obs,
                        style: pw.TextStyle(font: regular, fontSize: 10.5, height: 1.5, color: _textPrimary),
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(height: 8),
              ],
            ],
          ),
        ),
        pw.SizedBox(height: 16),
        _sectionTitle(l10n.sectionMetrics, semiBold),
        pw.SizedBox(height: 8),
        _buildMetricsTable(report.metrics, regular, semiBold),
        pw.SizedBox(height: 16),
        _sectionTitle(l10n.sectionRecommendations, semiBold),
        pw.SizedBox(height: 8),
        _contentCard(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              for (var i = 0; i < report.recommendations.length; i++) ...[
                pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Container(
                      width: 20,
                      height: 20,
                      alignment: pw.Alignment.center,
                      decoration: pw.BoxDecoration(
                        color: PdfColor.fromInt(0x332E5A44),
                        borderRadius: pw.BorderRadius.circular(6),
                      ),
                      child: pw.Text(
                        '${i + 1}',
                        style: pw.TextStyle(font: semiBold, fontSize: 10, color: _primary),
                      ),
                    ),
                    pw.SizedBox(width: 8),
                    pw.Expanded(
                      child: pw.Text(
                        report.recommendations[i],
                        style: pw.TextStyle(font: regular, fontSize: 10.5, height: 1.5, color: _textPrimary),
                      ),
                    ),
                  ],
                ),
                if (i < report.recommendations.length - 1) pw.SizedBox(height: 8),
              ],
            ],
          ),
        ),
        pw.SizedBox(height: 16),
        _sectionTitle(l10n.sectionTimeline, semiBold),
        pw.SizedBox(height: 8),
        _buildTimeline(report.timeline, l10n, timeFormat, regular, semiBold),
      ],
    ),
  );

  return doc.save();
}

pw.Widget _buildHeader(
  ReportModel report,
  DateFormat dateFormat,
  pw.Font regular,
  pw.Font bold,
  pw.Font semiBold,
) {
  return pw.Container(
    padding: const pw.EdgeInsets.all(20),
    decoration: pw.BoxDecoration(
      color: _primary,
      borderRadius: pw.BorderRadius.circular(16),
    ),
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Row(
          children: [
            pw.Text(
              'predemention',
              style: pw.TextStyle(font: bold, fontSize: 16, color: _paper),
            ),
            pw.Spacer(),
            pw.Container(
              padding: const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: pw.BoxDecoration(
                color: PdfColor.fromInt(0x33F5EFE0),
                borderRadius: pw.BorderRadius.circular(8),
              ),
              child: pw.Text(
                report.id,
                style: pw.TextStyle(font: semiBold, fontSize: 10, color: _paper),
              ),
            ),
          ],
        ),
        pw.SizedBox(height: 14),
        pw.Text(
          report.patientName,
          style: pw.TextStyle(font: bold, fontSize: 22, color: _paper),
        ),
        pw.SizedBox(height: 4),
        pw.Text(
          'ID: ${report.patientId} • ${dateFormat.format(report.createdAt)}',
          style: pw.TextStyle(font: regular, fontSize: 11, color: PdfColor.fromInt(0xCCF5EFE0)),
        ),
      ],
    ),
  );
}

pw.Widget _buildScoreCard({
  required String title,
  required String value,
  required String level,
  required PdfColor color,
  required pw.Font bold,
  required pw.Font semiBold,
  required pw.Font regular,
}) {
  return pw.Container(
    padding: const pw.EdgeInsets.all(16),
    decoration: pw.BoxDecoration(
      color: _paper,
      borderRadius: pw.BorderRadius.circular(14),
      border: pw.Border.all(color: color, width: 0.8),
    ),
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(title, style: pw.TextStyle(font: semiBold, fontSize: 10, color: _textSecondary)),
        pw.SizedBox(height: 6),
        pw.Text(value, style: pw.TextStyle(font: bold, fontSize: 24, color: color)),
        pw.SizedBox(height: 4),
        pw.Container(
          padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: pw.BoxDecoration(
            color: PdfColor(color.red, color.green, color.blue, 0.15),
            borderRadius: pw.BorderRadius.circular(6),
          ),
          child: pw.Text(level, style: pw.TextStyle(font: semiBold, fontSize: 9, color: color)),
        ),
      ],
    ),
  );
}

pw.Widget _sectionTitle(String title, pw.Font semiBold) {
  return pw.Text(
    title,
    style: pw.TextStyle(font: semiBold, fontSize: 13, color: _textPrimary),
  );
}

pw.Widget _contentCard({required pw.Widget child}) {
  return pw.Container(
    width: double.infinity,
    padding: const pw.EdgeInsets.all(16),
    decoration: pw.BoxDecoration(
      color: _paper,
      borderRadius: pw.BorderRadius.circular(14),
      border: pw.Border.all(color: _border, width: 0.6),
    ),
    child: child,
  );
}

pw.Widget _buildMetricsTable(
  Map<String, double> metrics,
  pw.Font regular,
  pw.Font semiBold,
) {
  final entries = metrics.entries.toList();
  return pw.Container(
    padding: const pw.EdgeInsets.all(16),
    decoration: pw.BoxDecoration(
      color: _paper,
      borderRadius: pw.BorderRadius.circular(14),
      border: pw.Border.all(color: _border, width: 0.6),
    ),
    child: pw.Column(
      children: [
        for (var i = 0; i < entries.length; i++) ...[
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                entries[i].key,
                style: pw.TextStyle(font: regular, fontSize: 10.5, color: _textSecondary),
              ),
              pw.Text(
                '${entries[i].value.toStringAsFixed(1)} ${_metricUnit(entries[i].key)}',
                style: pw.TextStyle(font: semiBold, fontSize: 10.5, color: _textPrimary),
              ),
            ],
          ),
          if (i < entries.length - 1)
            pw.Padding(
              padding: const pw.EdgeInsets.symmetric(vertical: 8),
              child: pw.Divider(color: _border, height: 0.5),
            ),
        ],
      ],
    ),
  );
}

pw.Widget _buildTimeline(
  ReportTimeline timeline,
  AppLocalizations l10n,
  DateFormat timeFormat,
  pw.Font regular,
  pw.Font semiBold,
) {
  final events = [
    (l10n.timelineStarted, timeline.startedAt),
    (l10n.timelineSensorCheck, timeline.sensorCheckCompleted),
    (l10n.timelineWalkingDone, timeline.walkingCompleted),
    (l10n.timelineUploadDone, timeline.uploadCompleted),
    (l10n.timelineAnalysisDone, timeline.analysisCompleted),
    (l10n.timelineReportGenerated, timeline.reportGenerated),
  ];

  return _contentCard(
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < events.length; i++) ...[
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Container(
                width: 8,
                height: 8,
                margin: const pw.EdgeInsets.only(top: 4),
                decoration: const pw.BoxDecoration(color: _primary, shape: pw.BoxShape.circle),
              ),
              pw.SizedBox(width: 10),
              pw.Expanded(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      events[i].$1,
                      style: pw.TextStyle(font: semiBold, fontSize: 10.5, color: _textPrimary),
                    ),
                    pw.Text(
                      timeFormat.format(events[i].$2),
                      style: pw.TextStyle(font: regular, fontSize: 9.5, color: _textSecondary),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (i < events.length - 1) pw.SizedBox(height: 10),
        ],
      ],
    ),
  );
}

String _metricUnit(String key) {
  switch (key) {
    case 'Walking Speed':
      return 'м/с';
    case 'Cadence':
      return 'ш/мин';
    case 'Stride Length':
      return 'м';
    case 'Asymmetry':
      return '%';
    case 'Double Support':
      return '%';
    case 'Stance Phase':
      return '%';
    case 'Swing Phase':
      return '%';
    case 'Step Count':
      return '';
    case 'Signal Quality':
      return '%';
    default:
      return '';
  }
}
