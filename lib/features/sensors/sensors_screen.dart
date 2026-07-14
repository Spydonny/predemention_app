import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/models/device_model.dart';
import '../../l10n/generated/app_localizations.dart';

class SensorsScreen extends StatefulWidget {
  final String visitId;

  const SensorsScreen({super.key, required this.visitId});

  @override
  State<SensorsScreen> createState() => _SensorsScreenState();
}

class _SensorsScreenState extends State<SensorsScreen> with SingleTickerProviderStateMixin {
  final List<SensorModel> _sensors = SensorModel.mockSensors;
  final List<bool> _checked = List.generate(11, (i) => i < 9);
  bool _checking = false;

  late AnimationController _checkController;

  @override
  void initState() {
    super.initState();
    _checkController = AnimationController(vsync: this, duration: const Duration(seconds: 3));
  }

  @override
  void dispose() {
    _checkController.dispose();
    super.dispose();
  }

  Future<void> _runCheck() async {
    setState(() {
      _checking = true;
    });
    _checkController.forward(from: 0);

    for (int i = 0; i < _sensors.length; i++) {
      await Future.delayed(const Duration(milliseconds: 350));
      if (mounted) {
        setState(() {
          // Re-scanning resolves any weak-signal/disconnected sensors.
          _checked[i] = true;
          if (_checked[i]) {
            _sensors[i] = SensorModel(
              id: _sensors[i].id,
              name: _sensors[i].name,
              type: _sensors[i].type,
              location: _sensors[i].location,
              status: 'connected',
              signalStrength: 0.85 + (0.15 * (i % 3)),
              channel: _sensors[i].channel,
            );
          }
        });
      }
    }

    await Future.delayed(const Duration(milliseconds: 500));
    if (mounted) {
      setState(() {
        _checking = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final palette = context.palette;
    final allConnected = _checked.every((c) => c);

    return Scaffold(
      backgroundColor: palette.surface,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_rounded),
                    onPressed: () => context.pop(),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.sensorsScreenTitle,
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: palette.textPrimary),
                        ),
                        Text(
                          l10n.sensorsActiveCount(_checked.where((c) => c).length, _sensors.length),
                          style: TextStyle(fontSize: 13, color: palette.textSecondary),
                        ),
                      ],
                    ),
                  ),
                  // Progress circle
                  SizedBox(
                    width: 44,
                    height: 44,
                    child: CircularProgressIndicator(
                      value: _checked.where((c) => c).length / _sensors.length,
                      strokeWidth: 3,
                      backgroundColor: palette.surfaceVariant,
                      valueColor: AlwaysStoppedAnimation(
                        allConnected ? palette.success : palette.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Connection status
            if (_checking)
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: LinearProgressIndicator(
                  backgroundColor: palette.surfaceVariant,
                  valueColor: AlwaysStoppedAnimation(palette.primary),
                ),
              ),

            // Sensor list
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _sensors.length,
                itemBuilder: (_, i) => _SensorTile(
                  sensor: _sensors[i],
                  checked: _checked[i],
                  index: i,
                ),
              ),
            ),

            // Bottom actions
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton.icon(
                      onPressed: allConnected
                          ? () => context.push('/assessment/${widget.visitId}')
                          : (_checking ? null : _runCheck),
                      icon: Icon(allConnected ? Icons.play_arrow_rounded : Icons.refresh_rounded),
                      label: Text(allConnected ? l10n.startAssessmentButton : (_checking ? l10n.sensorsChecking : l10n.sensorsCheckButton)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: allConnected ? palette.success : palette.primary,
                        foregroundColor: AppColors.paper,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        disabledBackgroundColor: palette.surfaceVariant,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SensorTile extends StatelessWidget {
  final SensorModel sensor;
  final bool checked;
  final int index;

  const _SensorTile({required this.sensor, required this.checked, required this.index});

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final color = checked
        ? palette.success
        : sensor.status == 'weak_signal'
            ? palette.warning
            : palette.error;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: palette.paper,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withAlpha(checked ? 60 : 120),
          width: checked ? 1 : 1.5,
        ),
        boxShadow: checked
            ? null
            : [BoxShadow(color: color.withAlpha(20), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Row(
        children: [
          // Icon
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: color.withAlpha(20),
              borderRadius: BorderRadius.circular(12),
            ),
            child: checked
                ? Icon(Icons.check_circle_rounded, color: palette.success, size: 22)
                : Icon(sensor.icon, color: color, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  sensor.name,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: palette.textPrimary),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Text(
                      sensor.type.toUpperCase(),
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: sensor.type == 'imu' ? palette.info : palette.secondaryInk),
                    ),
                    const SizedBox(width: 8),
                    Text('Ch ${sensor.channel}', style: TextStyle(fontSize: 11, color: palette.textTertiary)),
                    const SizedBox(width: 8),
                    Text(sensor.location, style: TextStyle(fontSize: 11, color: palette.textTertiary)),
                  ],
                ),
              ],
            ),
          ),
          // Status
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                checked ? 'Connected' : sensor.statusLabel,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: color),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _SignalBars(strength: sensor.signalStrength, color: color),
                  const SizedBox(width: 4),
                  Text(
                    '${(sensor.signalStrength * 100).round()}%',
                    style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SignalBars extends StatelessWidget {
  final double strength;
  final Color color;

  const _SignalBars({required this.strength, required this.color});

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: List.generate(4, (i) {
        final active = strength > (i * 0.25);
        return Container(
          width: 3,
          height: 6.0 + i * 3,
          margin: const EdgeInsets.symmetric(horizontal: 1),
          decoration: BoxDecoration(
            color: active ? color : palette.border,
            borderRadius: BorderRadius.circular(1),
          ),
        );
      }),
    );
  }
}
