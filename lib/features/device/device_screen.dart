import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/models/device_model.dart';
import '../../l10n/generated/app_localizations.dart';

class DeviceScreen extends StatefulWidget {
  final String visitId;

  const DeviceScreen({super.key, required this.visitId});

  @override
  State<DeviceScreen> createState() => _DeviceScreenState();
}

class _DeviceScreenState extends State<DeviceScreen> with TickerProviderStateMixin {
  bool _scanning = false;
  bool _connecting = false;
  String? _connectedDeviceId;
  final List<DeviceModel> _foundDevices = [];

  late AnimationController _scanController;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _scanController = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat();
    _pulseController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500))..repeat(reverse: true);
    _startScan();
  }

  @override
  void dispose() {
    _scanController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  Future<void> _startScan() async {
    setState(() => _scanning = true);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      setState(() {
        _foundDevices.addAll(DeviceModel.mockDevices);
        _scanning = false;
      });
    }
  }

  Future<void> _connectDevice(DeviceModel device) async {
    setState(() => _connecting = true);
    await Future.delayed(const Duration(milliseconds: 1800));
    if (mounted) {
      setState(() {
        _connecting = false;
        _connectedDeviceId = device.id;
      });
      await Future.delayed(const Duration(milliseconds: 600));
      if (mounted) {
        context.push('/sensors/${widget.visitId}');
      }
    }
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
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
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
                          l10n.deviceScreenTitle,
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: palette.textPrimary),
                        ),
                        Text(
                          _scanning ? l10n.deviceSearching : _connectedDeviceId != null ? l10n.deviceConnected : l10n.deviceChooseDevice,
                          style: TextStyle(fontSize: 13, color: palette.textSecondary),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Bluetooth animation
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: AnimatedBuilder(
                animation: _pulseController,
                builder: (context, _) {
                  return Container(
                    width: 100 + _pulseController.value * 30,
                    height: 100 + _pulseController.value * 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (_connectedDeviceId != null ? palette.success : palette.primary).withAlpha((30 * (1 - _pulseController.value * 0.7)).round()),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.bluetooth_rounded,
                        size: 44,
                        color: _connectedDeviceId != null ? palette.success : palette.primary,
                      ),
                    ),
                  );
                },
              ),
            ),

            // Connected device info
            if (_connectedDeviceId != null) ...[
              _ConnectedDeviceCard(
                device: _foundDevices.firstWhere((d) => d.id == _connectedDeviceId),
              ),
              const Spacer(),
            ] else ...[
              // Device list
              Expanded(
                child: _scanning
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            RotationTransition(
                              turns: _scanController,
                              child: Icon(Icons.sync_rounded, size: 32, color: palette.primary),
                            ),
                            const SizedBox(height: 16),
                            Text(l10n.deviceScanning, style: TextStyle(fontSize: 15, color: palette.textSecondary)),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: _foundDevices.length,
                        itemBuilder: (_, i) => _DeviceCard(
                          device: _foundDevices[i],
                          onTap: () => _connectDevice(_foundDevices[i]),
                          disabled: _connecting,
                        ),
                      ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _ConnectedDeviceCard extends StatelessWidget {
  final DeviceModel device;

  const _ConnectedDeviceCard({required this.device});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final palette = context.palette;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: palette.paper,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: palette.success.withAlpha(100)),
              boxShadow: [BoxShadow(color: palette.success.withAlpha(20), blurRadius: 20, offset: const Offset(0, 8))],
            ),
            child: Column(
              children: [
                Icon(Icons.check_circle_rounded, size: 48, color: palette.success),
                const SizedBox(height: 12),
                Text(l10n.deviceConnectedTitle, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: palette.textPrimary)),
                const SizedBox(height: 20),
                _DevInfoRow(icon: Icons.devices_rounded, label: l10n.deviceFieldDevice, value: device.name),
                const SizedBox(height: 12),
                _DevInfoRow(icon: Icons.qr_code_rounded, label: l10n.deviceFieldSerial, value: device.serialNumber),
                const SizedBox(height: 12),
                _DevInfoRow(icon: Icons.update_rounded, label: l10n.deviceFieldFirmware, value: device.firmwareVersion),
                const SizedBox(height: 12),
                _DevInfoRow(
                  icon: Icons.battery_charging_full_rounded,
                  label: l10n.deviceFieldBattery,
                  value: '${device.batteryLevel}%',
                  valueColor: device.batteryLevel > 20 ? palette.success : palette.error,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            l10n.deviceGoingToSensors,
            style: TextStyle(fontSize: 14, color: palette.textSecondary),
          ),
        ],
      ),
    );
  }
}

class _DeviceCard extends StatelessWidget {
  final DeviceModel device;
  final VoidCallback onTap;
  final bool disabled;

  const _DeviceCard({required this.device, required this.onTap, required this.disabled});

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return GestureDetector(
      onTap: disabled ? null : onTap,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: disabled ? 0.5 : 1,
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: palette.paper,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: palette.border.withAlpha(128)),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: palette.primary.withAlpha(20),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(Icons.bluetooth_rounded, color: palette.primary, size: 24),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(device.name, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: palette.textPrimary)),
                    const SizedBox(height: 4),
                    Text(device.serialNumber, style: TextStyle(fontSize: 12, color: palette.textSecondary)),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.signal_cellular_alt_rounded, size: 14, color: device.rssi > -50 ? palette.success : palette.warning),
                      const SizedBox(width: 4),
                      Text('${device.rssi} dBm', style: TextStyle(fontSize: 12, color: palette.textSecondary)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.battery_charging_full_rounded, size: 14, color: palette.success),
                      const SizedBox(width: 4),
                      Text('${device.batteryLevel}%', style: TextStyle(fontSize: 12, color: palette.textSecondary)),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DevInfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;

  const _DevInfoRow({required this.icon, required this.label, required this.value, this.valueColor});

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return Row(
      children: [
        Icon(icon, size: 18, color: palette.textTertiary),
        const SizedBox(width: 10),
        Expanded(child: Text(label, style: TextStyle(fontSize: 13, color: palette.textSecondary))),
        Text(value, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: valueColor ?? palette.textPrimary)),
      ],
    );
  }
}
