import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/app_scaffold.dart';
import '../../core/models/assessment_model.dart';
import '../../core/models/visit_model.dart';
import '../../core/providers/app_providers.dart';
import '../../l10n/generated/app_localizations.dart';
import 'report_actions.dart';

class ReportScreen extends ConsumerWidget {
  final String reportId;

  const ReportScreen({super.key, required this.reportId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final palette = context.palette;
    final liveReport = ref.watch(assessmentReportProvider);

    final ReportModel report;
    if (liveReport != null && liveReport.id == reportId) {
      // Report from a session the user actually just completed.
      report = liveReport;
    } else {
      final visits = VisitModel.getAllVisits();
      final visit = visits.firstWhere(
        (v) => (v.assessmentId ?? '') == reportId || reportId.contains(v.id),
        orElse: () => visits.first,
      );
      report = ReportModel.mockReport(visit.patient.id, visit.patient.fullName, reportId);
    }

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
              title: Text(l10n.reportScreenTitle),
              actions: [
                IconButton(icon: const Icon(Icons.share_rounded), onPressed: () => sendReportToDoctor(report)),
                IconButton(icon: const Icon(Icons.more_vert_rounded), onPressed: () => showReportActionsSheet(context, report)),
              ],
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Report Header
                    _ReportHeader(report: report),
                    const SizedBox(height: 20),

                    // Risk Score & Confidence
                    Row(
                      children: [
                        Expanded(
                          child: _ScoreCard(
                            title: 'Risk Score',
                            value: '${report.riskScore.toStringAsFixed(1)}%',
                            level: report.riskLevel,
                            color: report.riskScore < 30
                                ? palette.success
                                : report.riskScore < 60
                                    ? palette.warning
                                    : palette.error,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _ScoreCard(
                            title: 'Confidence',
                            value: '${report.confidence.toStringAsFixed(1)}%',
                            level: report.confidenceLevel,
                            color: palette.info,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Conclusion
                    SectionHeader(title: l10n.sectionConclusion),
                    const SizedBox(height: 12),
                    _ContentCard(child: Text(report.conclusion, style: TextStyle(fontSize: 14, color: palette.textPrimary, height: 1.6))),
                    const SizedBox(height: 20),

                    // Key Observations
                    SectionHeader(title: l10n.sectionKeyObservations),
                    const SizedBox(height: 12),
                    _ContentCard(
                      child: Column(
                        children: report.keyObservations.map((obs) => Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.circle, size: 6, color: palette.warning),
                                  const SizedBox(width: 10),
                                  Expanded(child: Text(obs, style: TextStyle(fontSize: 13, color: palette.textPrimary, height: 1.5))),
                                ],
                              ),
                            )).toList(),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Metrics
                    SectionHeader(title: l10n.sectionMetrics),
                    const SizedBox(height: 12),
                    _MetricsGrid(metrics: report.metrics),
                    const SizedBox(height: 20),

                    // Recommendations
                    SectionHeader(title: l10n.sectionRecommendations),
                    const SizedBox(height: 12),
                    _ContentCard(
                      child: Column(
                        children: report.recommendations.asMap().entries.map((e) => Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      color: palette.primary.withAlpha(20),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text('${e.key + 1}', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: palette.primary)),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(child: Text(e.value, style: TextStyle(fontSize: 13, color: palette.textPrimary, height: 1.5))),
                                ],
                              ),
                            )).toList(),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Timeline
                    SectionHeader(title: l10n.sectionTimeline),
                    const SizedBox(height: 12),
                    _TimelineCard(timeline: report.timeline),
                    const SizedBox(height: 24),

                    // Action buttons
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 52,
                            child: OutlinedButton.icon(
                              onPressed: () => saveReportAsPdf(context, report),
                              icon: const Icon(Icons.picture_as_pdf_rounded),
                              label: Text(l10n.savePdfButton),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: SizedBox(
                            height: 52,
                            child: ElevatedButton.icon(
                              onPressed: () => sendReportToDoctor(report),
                              icon: const Icon(Icons.send_rounded),
                              label: Text(l10n.sendToDoctorButton),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                foregroundColor: AppColors.paper,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                              ),
                            ),
                          ),
                        ),
                      ],
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

class _ReportHeader extends StatelessWidget {
  final ReportModel report;

  const _ReportHeader({required this.report});

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('predemention', style: AppTheme.display(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.paper, letterSpacing: -0.4)),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.paper.withAlpha(30),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(report.id, style: const TextStyle(fontSize: 12, color: AppColors.paper, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(report.patientName, style: AppTheme.display(fontSize: 24, fontWeight: FontWeight.w600, color: AppColors.paper, letterSpacing: -0.4)),
          const SizedBox(height: 4),
          Text(
            'ID: ${report.patientId} • ${DateFormat('dd.MM.yyyy HH:mm', locale).format(report.createdAt)}',
            style: TextStyle(fontSize: 13, color: AppColors.paper.withAlpha(200)),
          ),
        ],
      ),
    );
  }
}

class _ScoreCard extends StatelessWidget {
  final String title;
  final String value;
  final String level;
  final Color color;

  const _ScoreCard({required this.title, required this.value, required this.level, required this.color});

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: palette.paper,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: color.withAlpha(80)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: palette.textSecondary)),
          const SizedBox(height: 8),
          Text(value, style: AppTheme.figure(fontSize: 30, fontWeight: FontWeight.w600, color: color)),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(color: color.withAlpha(20), borderRadius: BorderRadius.circular(6)),
            child: Text(level, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: color)),
          ),
        ],
      ),
    );
  }
}

class _ContentCard extends StatelessWidget {
  final Widget child;

  const _ContentCard({required this.child});

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: palette.paper,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: palette.border.withAlpha(100)),
      ),
      child: child,
    );
  }
}

class _MetricsGrid extends StatelessWidget {
  final Map<String, double> metrics;

  const _MetricsGrid({required this.metrics});

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: palette.paper,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: palette.border.withAlpha(100)),
      ),
      child: Column(
        children: metrics.entries.map((e) {
          final isLast = metrics.entries.last.key == e.key;
          final unit = _getUnit(e.key);
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(e.key, style: TextStyle(fontSize: 13, color: palette.textSecondary)),
                  Text(
                    '${e.value.toStringAsFixed(1)} $unit',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: palette.textPrimary),
                  ),
                ],
              ),
              if (!isLast) const Divider(height: 20),
            ],
          );
        }).toList(),
      ),
    );
  }

  String _getUnit(String key) {
    switch (key) {
      case 'Walking Speed': return 'м/с';
      case 'Cadence': return 'ш/мин';
      case 'Stride Length': return 'м';
      case 'Asymmetry': return '%';
      case 'Double Support': return '%';
      case 'Stance Phase': return '%';
      case 'Swing Phase': return '%';
      case 'Step Count': return '';
      case 'Signal Quality': return '%';
      default: return '';
    }
  }
}

class _TimelineCard extends StatelessWidget {
  final ReportTimeline timeline;

  const _TimelineCard({required this.timeline});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final palette = context.palette;
    final locale = Localizations.localeOf(context).languageCode;
    final events = [
      (l10n.timelineStarted, timeline.startedAt, Icons.play_circle_rounded, palette.primary),
      (l10n.timelineSensorCheck, timeline.sensorCheckCompleted, Icons.sensors_rounded, palette.info),
      (l10n.timelineWalkingDone, timeline.walkingCompleted, Icons.directions_walk_rounded, palette.success),
      (l10n.timelineUploadDone, timeline.uploadCompleted, Icons.cloud_upload_rounded, palette.secondaryInk),
      (l10n.timelineAnalysisDone, timeline.analysisCompleted, Icons.analytics_rounded, palette.warning),
      (l10n.timelineReportGenerated, timeline.reportGenerated, Icons.description_rounded, palette.primary),
    ];

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: palette.paper,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: palette.border.withAlpha(100)),
      ),
      child: Column(
        children: events.asMap().entries.map((e) {
          final isLast = e.key == events.length - 1;
          return IntrinsicHeight(
            child: Row(
              children: [
                Column(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: e.value.$4.withAlpha(20),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(e.value.$3, size: 18, color: e.value.$4),
                    ),
                    if (!isLast)
                      Expanded(
                        child: Container(
                          width: 2,
                          color: palette.border,
                          margin: const EdgeInsets.symmetric(vertical: 4),
                        ),
                      ),
                  ],
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: isLast ? 0 : 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(e.value.$1, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: palette.textPrimary)),
                        const SizedBox(height: 2),
                        Text(
                          DateFormat('HH:mm:ss', locale).format(e.value.$2),
                          style: TextStyle(fontSize: 11, color: palette.textTertiary),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
