import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/app_scaffold.dart';
import '../../core/models/device_model.dart';
import '../../core/models/assessment_model.dart';
import '../../core/providers/app_providers.dart';
import '../../l10n/generated/app_localizations.dart';

class AssessmentScreen extends ConsumerStatefulWidget {
  final String visitId;

  const AssessmentScreen({super.key, required this.visitId});

  @override
  ConsumerState<AssessmentScreen> createState() => _AssessmentScreenState();
}

class _AssessmentScreenState extends ConsumerState<AssessmentScreen> with TickerProviderStateMixin {
  bool _running = false;
  bool _paused = false;
  int _elapsedSeconds = 0;
  Timer? _timer;
  DateTime? _startedAt;

  // Live metrics
  double _riskScore = 38.5;
  double _confidence = 0.88;
  double _walkingSpeed = 0.94;
  double _cadence = 97.3;
  double _asymmetry = 7.8;
  int _steps = 0;
  int _lostPackets = 0;
  double _signalQuality = 98.2;

  // Chart data
  final List<FlSpot> _imuAccelX = [];
  final List<FlSpot> _imuGyroZ = [];
  final List<FlSpot> _semgCh1 = [];
  int _dataIndex = 0;

  final Random _random = Random();
  final List<SensorModel> _sensors = SensorModel.connectedSensors;

  late AnimationController _recordingPulse;
  late AnimationController _progressAnim;

  @override
  void initState() {
    super.initState();
    _recordingPulse = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000))..repeat(reverse: true);
    _progressAnim = AnimationController(vsync: this, duration: const Duration(seconds: 120));
  }

  @override
  void dispose() {
    _timer?.cancel();
    _recordingPulse.dispose();
    _progressAnim.dispose();
    super.dispose();
  }

  void _start() {
    setState(() {
      _running = true;
      _paused = false;
      _steps = 0;
      _lostPackets = 0;
      _startedAt = DateTime.now();
    });
    _recordingPulse.repeat(reverse: true);
    _progressAnim.forward(from: 0);
    _timer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      _updateData();
    });
  }

  void _pause() {
    setState(() => _paused = true);
    _timer?.cancel();
    _recordingPulse.stop();
    _progressAnim.stop();
  }

  void _resume() {
    setState(() => _paused = false);
    _recordingPulse.repeat(reverse: true);
    _timer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      _updateData();
    });
  }

  void _finish() {
    _timer?.cancel();
    _recordingPulse.stop();
    _progressAnim.stop();
    setState(() => _running = false);

    ref.read(assessmentSessionProvider.notifier).state = AssessmentSessionData(
      visitId: widget.visitId,
      startedAt: _startedAt ?? DateTime.now().subtract(Duration(seconds: _elapsedSeconds)),
      endedAt: DateTime.now(),
      riskScore: _riskScore,
      confidence: _confidence,
      walkingSpeed: _walkingSpeed,
      cadence: _cadence,
      asymmetry: _asymmetry,
      stepCount: _steps,
      lostPackets: _lostPackets,
      signalQuality: _signalQuality,
    );

    // Navigate to AI processing
    context.push('/processing/${widget.visitId}');
  }

  void _updateData() {
    if (_paused) return;

    setState(() {
      _dataIndex++;
      _elapsedSeconds = _dataIndex ~/ 10;

      // Update metrics
      _riskScore += _normRand(0, 0.2);
      _riskScore = _riskScore.clamp(20, 80);
      _confidence += _normRand(0, 0.1);
      _confidence = _confidence.clamp(0.70, 0.99);
      _walkingSpeed += _normRand(0, 0.015);
      _walkingSpeed = _walkingSpeed.clamp(0.7, 1.5);
      _cadence += _normRand(0, 0.2);
      _cadence = _cadence.clamp(80, 120);
      _asymmetry += _normRand(0, 0.08);
      _asymmetry = _asymmetry.clamp(3, 15);
      if (_random.nextDouble() < 0.02) _lostPackets++;
      _signalQuality += _normRand(0, 0.03);
      _signalQuality = _signalQuality.clamp(90, 100);

      // Steps every ~0.5s
      if (_dataIndex % 5 == 0) _steps++;

      // Chart data
      _imuAccelX.add(FlSpot(_dataIndex.toDouble(), _normRand(0, 0.2)));
      _imuGyroZ.add(FlSpot(_dataIndex.toDouble(), _normRand(0, 6)));
      _semgCh1.add(FlSpot(_dataIndex.toDouble(), _random.nextDouble() * 0.04));

      // Keep last 100 points
      if (_imuAccelX.length > 150) {
        _imuAccelX.removeAt(0);
        _imuGyroZ.removeAt(0);
        _semgCh1.removeAt(0);
      }
    });
  }

  double _normRand(double mean, double stddev) {
    final u1 = _random.nextDouble();
    final u2 = _random.nextDouble();
    return mean + sqrt(-2.0 * log(u1)) * cos(2.0 * pi * u2) * stddev;
  }

  String _formatTime(int seconds) {
    final m = seconds ~/ 60;
    final s = seconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final palette = context.palette;
    return Scaffold(
      backgroundColor: palette.surface,
      body: SafeArea(
        child: Column(
          children: [
            // Top bar
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
              child: Row(
                children: [
                  if (!_running)
                    IconButton(
                      icon: const Icon(Icons.arrow_back_rounded),
                      onPressed: () => context.pop(),
                    ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(l10n.assessmentScreenTitle, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: palette.textPrimary)),
                        Row(
                          children: [
                            if (_running) ...[
                              AnimatedBuilder(
                                animation: _recordingPulse,
                                builder: (context, _) => Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: _paused ? palette.warning : palette.error,
                                    shape: BoxShape.circle,
                                    boxShadow: !_paused ? [
                                      BoxShadow(color: palette.error.withAlpha(_recordingPulse.value > 0.5 ? 80 : 20), blurRadius: 6)
                                    ] : null,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 6),
                            ],
                            Text(
                              _running ? (_paused ? l10n.assessmentPaused : l10n.assessmentRecording) : l10n.assessmentReady,
                              style: TextStyle(fontSize: 13, color: _running ? palette.error : palette.textSecondary),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Timer
                  if (_running)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: palette.surfaceVariant,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        _formatTime(_elapsedSeconds),
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: palette.textPrimary, fontFamily: 'monospace'),
                      ),
                    ),
                ],
              ),
            ),

            // Progress bar
            if (_running)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(3),
                  child: LinearProgressIndicator(
                    value: (_elapsedSeconds / 120).clamp(0, 1),
                    minHeight: 4,
                    backgroundColor: palette.surfaceVariant,
                    valueColor: AlwaysStoppedAnimation(palette.primary),
                  ),
                ),
              ),

            // Content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
                child: Column(
                  children: [
                    // Top metrics row
                    Row(
                      children: [
                        Expanded(
                          child: MetricsCard(
                            label: 'Risk Score',
                            value: _riskScore.toStringAsFixed(1),
                            unit: '%',
                            icon: Icons.warning_rounded,
                            iconColor: _riskScore > 50 ? palette.error : palette.warning,
                            color: _riskScore > 50 ? palette.error : palette.warning,
                            trend: _riskScore > 45 ? '+2.3%' : 'stable',
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: MetricsCard(
                            label: 'Confidence',
                            value: '${(_confidence * 100).toStringAsFixed(1)}%',
                            icon: Icons.shield_rounded,
                            iconColor: palette.info,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // Quick metrics
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: palette.paper,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: palette.border.withAlpha(100)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(l10n.sectionMetrics, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: palette.textPrimary)),
                          const SizedBox(height: 14),
                          Row(
                            children: [
                              _QuickMetric(label: l10n.metricSpeed, value: _walkingSpeed.toStringAsFixed(2), unit: 'м/с', icon: Icons.speed_rounded),
                              _QuickMetric(label: l10n.metricCadence, value: _cadence.toStringAsFixed(1), unit: 'ш/мин', icon: Icons.directions_walk_rounded),
                              _QuickMetric(label: l10n.metricAsymmetry, value: _asymmetry.toStringAsFixed(1), unit: '%', icon: Icons.balance_rounded, valueColor: _asymmetry > 10 ? palette.error : null),
                              _QuickMetric(label: l10n.metricSteps, value: '$_steps', icon: Icons.directions_walk_rounded),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              _QuickMetric(label: l10n.metricQuality, value: _signalQuality.toStringAsFixed(1), unit: '%', icon: Icons.signal_cellular_alt_rounded, valueColor: _signalQuality > 95 ? palette.success : palette.warning),
                              _QuickMetric(label: l10n.metricLostPackets, value: '$_lostPackets', icon: Icons.wifi_off_rounded, valueColor: _lostPackets > 5 ? palette.error : null),
                              const Spacer(flex: 1),
                              const Spacer(flex: 1),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // IMU Chart
                    _ChartCard(
                      title: 'IMU — Accelerometer X',
                      color: palette.info,
                      spots: _imuAccelX,
                      unit: 'g',
                    ),
                    const SizedBox(height: 12),

                    // Gyro Chart
                    _ChartCard(
                      title: 'IMU — Gyroscope Z',
                      color: palette.secondaryInk,
                      spots: _imuGyroZ,
                      unit: '°/s',
                    ),
                    const SizedBox(height: 12),

                    // sEMG Chart
                    _ChartCard(
                      title: 'sEMG — Channel 1',
                      color: palette.success,
                      spots: _semgCh1,
                      unit: 'mV',
                    ),
                    const SizedBox(height: 16),

                    // Sensor indicators
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: palette.paper,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: palette.border.withAlpha(100)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(l10n.sectionSensors, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: palette.textPrimary)),
                              const Spacer(),
                              Text(
                                l10n.sensorsConnectedCount(_sensors.length, _sensors.length),
                                style: TextStyle(fontSize: 12, color: palette.success, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 6,
                            runSpacing: 6,
                            children: _sensors.map((s) => Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: palette.surfaceVariant,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: palette.success.withAlpha(80)),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(width: 6, height: 6, decoration: BoxDecoration(color: palette.success, shape: BoxShape.circle)),
                                      const SizedBox(width: 5),
                                      Text(
                                        s.name,
                                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: palette.textPrimary),
                                      ),
                                    ],
                                  ),
                                )).toList(),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Bottom spacing for buttons
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),

            // Bottom buttons
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: palette.paper,
                boxShadow: [
                  BoxShadow(color: Colors.black.withAlpha(8), blurRadius: 20, offset: const Offset(0, -4)),
                ],
              ),
              child: SafeArea(
                top: false,
                child: Row(
                  children: [
                    if (!_running) ...[
                      // Start button
                      Expanded(
                        child: SizedBox(
                          height: 56,
                          child: ElevatedButton.icon(
                            onPressed: _start,
                            icon: const Icon(Icons.play_arrow_rounded),
                            label: Text(l10n.startAssessmentButton),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: palette.success,
                              foregroundColor: AppColors.paper,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            ),
                          ),
                        ),
                      ),
                    ] else ...[
                      // Pause/Resume
                      Expanded(
                        child: SizedBox(
                          height: 52,
                          child: OutlinedButton.icon(
                            onPressed: _paused ? _resume : _pause,
                            icon: Icon(_paused ? Icons.play_arrow_rounded : Icons.pause_rounded),
                            label: Text(_paused ? l10n.assessmentResume : l10n.assessmentPaused),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Finish
                      Expanded(
                        child: SizedBox(
                          height: 52,
                          child: ElevatedButton.icon(
                            onPressed: _finish,
                            icon: const Icon(Icons.stop_rounded),
                            label: Text(l10n.assessmentFinish),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: palette.error,
                              foregroundColor: AppColors.paper,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            ),
                          ),
                        ),
                      ),
                    ],
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

class _QuickMetric extends StatelessWidget {
  final String label;
  final String value;
  final String? unit;
  final IconData icon;
  final Color? valueColor;

  const _QuickMetric({required this.label, required this.value, this.unit, required this.icon, this.valueColor});

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return Expanded(
      child: Column(
        children: [
          Icon(icon, size: 16, color: palette.textTertiary),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Flexible(
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: valueColor ?? palette.textPrimary,
                    letterSpacing: -0.2,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              if (unit != null) ...[
                const SizedBox(width: 2),
                Text(
                  unit!,
                  style: TextStyle(fontSize: 10, color: palette.textTertiary),
                ),
              ],
            ],
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(fontSize: 10, color: palette.textTertiary, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _ChartCard extends StatelessWidget {
  final String title;
  final Color color;
  final List<FlSpot> spots;
  final String unit;

  const _ChartCard({required this.title, required this.color, required this.spots, required this.unit});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final palette = context.palette;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: palette.paper,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: palette.border.withAlpha(100)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
              const SizedBox(width: 8),
              Text(title, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: palette.textPrimary)),
              const Spacer(),
              Text(unit, style: TextStyle(fontSize: 11, color: palette.textTertiary)),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 120,
            child: spots.isEmpty
                ? Center(child: Text(l10n.chartWaitingForData, style: TextStyle(color: palette.textTertiary, fontSize: 13)))
                : LineChart(
                    LineChartData(
                      minX: spots.isEmpty ? 0 : spots.first.x,
                      maxX: spots.isEmpty ? 150 : spots.last.x,
                      minY: _minY(spots),
                      maxY: _maxY(spots),
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: false,
                        horizontalInterval: _interval(spots),
                        getDrawingHorizontalLine: (value) => FlLine(
                          color: palette.border.withAlpha(80),
                          strokeWidth: 1,
                        ),
                      ),
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 36,
                            getTitlesWidget: (value, meta) => Text(
                              value.toStringAsFixed(1),
                              style: TextStyle(fontSize: 9, color: palette.textTertiary),
                            ),
                          ),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 22,
                            interval: 50,
                            getTitlesWidget: (value, meta) => Text(
                              '${value.toInt()}',
                              style: TextStyle(fontSize: 9, color: palette.textTertiary),
                            ),
                          ),
                        ),
                        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      ),
                      borderData: FlBorderData(show: false),
                      lineBarsData: [
                        LineChartBarData(
                          spots: spots,
                          isCurved: true,
                          color: color,
                          barWidth: 1.5,
                          dotData: const FlDotData(show: false),
                          belowBarData: BarAreaData(
                            show: true,
                            color: color.withAlpha(25),
                          ),
                        ),
                      ],
                      lineTouchData: const LineTouchData(enabled: false),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  double _minY(List<FlSpot> spots) {
    if (spots.isEmpty) return -1;
    final minVal = spots.map((s) => s.y).reduce((a, b) => a < b ? a : b);
    return minVal - (minVal.abs() * 0.2 + 0.01);
  }

  double _maxY(List<FlSpot> spots) {
    if (spots.isEmpty) return 1;
    final maxVal = spots.map((s) => s.y).reduce((a, b) => a > b ? a : b);
    return maxVal + (maxVal.abs() * 0.2 + 0.01);
  }

  double _interval(List<FlSpot> spots) {
    if (spots.isEmpty) return 0.5;
    final range = _maxY(spots) - _minY(spots);
    return range <= 0 ? 0.5 : range / 4;
  }
}
