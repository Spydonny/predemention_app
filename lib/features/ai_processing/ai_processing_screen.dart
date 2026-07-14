import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/models/assessment_model.dart';
import '../../core/providers/app_providers.dart';
import '../../l10n/generated/app_localizations.dart';

enum _StepKind { uploading, syncing, preprocessing, extracting, spatiotemporal, symmetry, inference, normative, risk, report }

extension on _StepKind {
  IconData get icon => switch (this) {
        _StepKind.uploading => Icons.cloud_upload_rounded,
        _StepKind.syncing => Icons.sync_rounded,
        _StepKind.preprocessing => Icons.tune_rounded,
        _StepKind.extracting => Icons.analytics_rounded,
        _StepKind.spatiotemporal => Icons.speed_rounded,
        _StepKind.symmetry => Icons.balance_rounded,
        _StepKind.inference => Icons.memory_rounded,
        _StepKind.normative => Icons.storage_rounded,
        _StepKind.risk => Icons.assessment_rounded,
        _StepKind.report => Icons.description_rounded,
      };

  String label(AppLocalizations l10n) => switch (this) {
        _StepKind.uploading => l10n.aiStepUploading,
        _StepKind.syncing => l10n.aiStepSyncing,
        _StepKind.preprocessing => l10n.aiStepPreprocessing,
        _StepKind.extracting => l10n.aiStepExtracting,
        _StepKind.spatiotemporal => l10n.aiStepSpatiotemporal,
        _StepKind.symmetry => l10n.aiStepSymmetry,
        _StepKind.inference => l10n.aiStepInference,
        _StepKind.normative => l10n.aiStepNormative,
        _StepKind.risk => l10n.aiStepRisk,
        _StepKind.report => l10n.aiStepReport,
      };
}

class AiProcessingScreen extends ConsumerStatefulWidget {
  final String visitId;

  const AiProcessingScreen({super.key, required this.visitId});

  @override
  ConsumerState<AiProcessingScreen> createState() => _AiProcessingScreenState();
}

class _AiProcessingScreenState extends ConsumerState<AiProcessingScreen> with TickerProviderStateMixin {
  final List<_Step> _steps = _StepKind.values.map((k) => _Step(kind: k)).toList();

  bool _completed = false;
  late AnimationController _glowController;
  late AnimationController _checkController;

  @override
  void initState() {
    super.initState();
    _glowController = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat(reverse: true);
    _checkController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _startProcessing();
  }

  @override
  void dispose() {
    _glowController.dispose();
    _checkController.dispose();
    super.dispose();
  }

  Future<void> _startProcessing() async {
    DateTime? uploadCompleted;
    DateTime? analysisCompleted;

    for (int i = 0; i < _steps.length; i++) {
      await Future.delayed(Duration(milliseconds: 700 + (i * 50)));
      if (!mounted) return;

      setState(() {
        _steps[i].progress = 1.0;
      });
      // "Uploading sensor data..." is step 0, "Running neural network inference..." is step 6.
      if (i == 0) uploadCompleted = DateTime.now();
      if (i == 6) analysisCompleted = DateTime.now();
    }

    await Future.delayed(const Duration(milliseconds: 800));
    if (!mounted) return;

    setState(() => _completed = true);
    _checkController.forward();

    final l10n = AppLocalizations.of(context);
    final reportId = _buildReport(
      uploadCompleted: uploadCompleted ?? DateTime.now(),
      analysisCompleted: analysisCompleted ?? DateTime.now(),
      defaultPatientName: l10n.sectionPatient,
    );

    await Future.delayed(const Duration(milliseconds: 1500));
    if (!mounted) return;

    context.go('/report/$reportId');
  }

  String _buildReport({required DateTime uploadCompleted, required DateTime analysisCompleted, required String defaultPatientName}) {
    final reportId = 'RPT-${widget.visitId}-001';
    final session = ref.read(assessmentSessionProvider);
    if (session == null || session.visitId != widget.visitId) {
      // No live session recorded (e.g. deep-linked here) — leave the fixed
      // mock as the fallback the report screen already knows how to render.
      return reportId;
    }

    final visit = ref.read(allVisitsProvider).where((v) => v.id == widget.visitId).firstOrNull;
    final report = ReportModel.fromAssessment(
      reportId: reportId,
      patientId: visit?.patient.id ?? 'UNKNOWN',
      patientName: visit?.patient.fullName ?? defaultPatientName,
      session: session,
      uploadCompleted: uploadCompleted,
      analysisCompleted: analysisCompleted,
    );
    ref.read(assessmentReportProvider.notifier).state = report;
    return reportId;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final palette = context.palette;
    return Scaffold(
      backgroundColor: palette.surface,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animated icon
                AnimatedBuilder(
                  animation: _glowController,
                  builder: (context, _) {
                    final glow = _glowController.value;
                    return Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (_completed ? palette.success : palette.primary).withAlpha((30 + glow * 20).round()),
                        boxShadow: [
                          BoxShadow(
                            color: (_completed ? palette.success : palette.primary).withAlpha((40 + glow * 20).round()),
                            blurRadius: 30 + glow * 20,
                          ),
                        ],
                      ),
                      child: _completed
                          ? ScaleTransition(
                              scale: _checkController.drive(Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: Curves.elasticOut))),
                              child: Icon(Icons.check_circle_rounded, size: 64, color: palette.success),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.psychology_rounded, size: 48, color: palette.primary),
                                const SizedBox(height: 6),
                                Text('AI', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: palette.primary)),
                              ],
                            ),
                    );
                  },
                ),
                const SizedBox(height: 32),

                // Title
                Text(
                  _completed ? l10n.aiProcessingComplete : l10n.aiProcessingTitle,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: palette.textPrimary, letterSpacing: -0.3),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  _completed ? l10n.aiProcessingReportReady : l10n.aiProcessingSubtitle,
                  style: TextStyle(fontSize: 14, color: palette.textSecondary),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 36),

                // Steps
                ..._steps.map((step) => _StepWidget(step: step)),
                const SizedBox(height: 24),

                if (!_completed)
                  SizedBox(
                    width: 32,
                    height: 32,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: palette.primary,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Step {
  final _StepKind kind;
  double progress = 0;

  _Step({required this.kind});
}

class _StepWidget extends StatelessWidget {
  final _Step step;

  const _StepWidget({required this.step});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final palette = context.palette;
    final isCompleted = step.progress >= 1.0;

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 400),
      opacity: isCompleted ? 0.6 : 1.0,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 14),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: isCompleted
                    ? palette.success.withAlpha(20)
                    : palette.surfaceVariant,
                borderRadius: BorderRadius.circular(12),
              ),
              child: isCompleted
                  ? Icon(Icons.check_rounded, size: 18, color: palette.success)
                  : Icon(step.kind.icon, size: 18, color: palette.textTertiary),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                step.kind.label(l10n),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: isCompleted ? FontWeight.w500 : FontWeight.w600,
                  color: isCompleted ? palette.textSecondary : palette.textPrimary,
                  decoration: isCompleted ? TextDecoration.lineThrough : null,
                ),
              ),
            ),
            if (!isCompleted)
              SizedBox(
                width: 14,
                height: 14,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation(palette.primary),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
