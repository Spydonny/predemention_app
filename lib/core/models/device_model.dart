import 'package:flutter/material.dart';
import 'dart:math';

class DeviceModel {
  final String id;
  final String name;
  final String serialNumber;
  final String firmwareVersion;
  final int batteryLevel;
  final String status; // 'available', 'connected', 'disconnected', 'pairing'
  final int rssi;

  const DeviceModel({
    required this.id,
    required this.name,
    required this.serialNumber,
    required this.firmwareVersion,
    required this.batteryLevel,
    required this.status,
    required this.rssi,
  });

  static List<DeviceModel> get mockDevices => [
        DeviceModel(
          id: 'DEV-001',
          name: 'PreDemention GaitBand Pro',
          serialNumber: 'PD-GB-2024-A7843',
          firmwareVersion: '2.4.1',
          batteryLevel: 94,
          status: 'available',
          rssi: -42,
        ),
        DeviceModel(
          id: 'DEV-002',
          name: 'PreDemention GaitBand Lite',
          serialNumber: 'PD-GL-2024-B1290',
          firmwareVersion: '2.4.0',
          batteryLevel: 67,
          status: 'available',
          rssi: -58,
        ),
        DeviceModel(
          id: 'DEV-003',
          name: 'PreDemention Ankle Sensor',
          serialNumber: 'PD-AS-2024-C5521',
          firmwareVersion: '2.3.9',
          batteryLevel: 88,
          status: 'available',
          rssi: -51,
        ),
      ];
}

class SensorModel {
  final String id;
  final String name;
  final String type; // 'imu', 'semg'
  final String location; // body location
  final String status; // 'connected', 'weak_signal', 'disconnected'
  final double signalStrength;
  final int channel;

  const SensorModel({
    required this.id,
    required this.name,
    required this.type,
    required this.location,
    required this.status,
    required this.signalStrength,
    required this.channel,
  });

  Color get statusColor {
    switch (status) {
      case 'connected':
        return const Color(0xFF4E7B54); // muted green
      case 'weak_signal':
        return const Color(0xFFC08A3B); // ochre
      case 'disconnected':
        return const Color(0xFFB0533C); // clay
      default:
        return const Color(0xFF8B9385); // sage-gray
    }
  }

  String get statusLabel {
    switch (status) {
      case 'connected':
        return 'Connected';
      case 'weak_signal':
        return 'Weak Signal';
      case 'disconnected':
        return 'Disconnected';
      default:
        return 'Unknown';
    }
  }

  IconData get icon {
    switch (type) {
      case 'imu':
        return Icons.sensors_rounded;
      case 'semg':
        return Icons.monitor_heart_rounded;
      default:
        return Icons.device_unknown_rounded;
    }
  }

  static List<SensorModel> get mockSensors => [
        SensorModel(id: 'S01', name: 'IMU Right Hip', type: 'imu', location: 'Right hip', status: 'connected', signalStrength: 0.94, channel: 1),
        SensorModel(id: 'S02', name: 'IMU Left Hip', type: 'imu', location: 'Left hip', status: 'connected', signalStrength: 0.91, channel: 2),
        SensorModel(id: 'S03', name: 'IMU Right Knee', type: 'imu', location: 'Right knee', status: 'connected', signalStrength: 0.88, channel: 3),
        SensorModel(id: 'S04', name: 'IMU Left Knee', type: 'imu', location: 'Left knee', status: 'weak_signal', signalStrength: 0.62, channel: 4),
        SensorModel(id: 'S05', name: 'IMU Right Ankle', type: 'imu', location: 'Right ankle', status: 'connected', signalStrength: 0.95, channel: 5),
        SensorModel(id: 'S06', name: 'IMU Left Ankle', type: 'imu', location: 'Left ankle', status: 'connected', signalStrength: 0.92, channel: 6),
        SensorModel(id: 'S07', name: 'IMU Lumbar', type: 'imu', location: 'Lumbar (L5)', status: 'connected', signalStrength: 0.97, channel: 7),
        SensorModel(id: 'S08', name: 'sEMG Right VL', type: 'semg', location: 'Right vastus lateralis', status: 'connected', signalStrength: 0.89, channel: 8),
        SensorModel(id: 'S09', name: 'sEMG Left VL', type: 'semg', location: 'Left vastus lateralis', status: 'connected', signalStrength: 0.87, channel: 9),
        SensorModel(id: 'S10', name: 'sEMG Right TA', type: 'semg', location: 'Right tibialis anterior', status: 'weak_signal', signalStrength: 0.55, channel: 10),
        SensorModel(id: 'S11', name: 'sEMG Left TA', type: 'semg', location: 'Left tibialis anterior', status: 'connected', signalStrength: 0.90, channel: 11),
      ];

  static List<SensorModel> get connectedSensors => mockSensors
      .map((s) => SensorModel(
            id: s.id,
            name: s.name,
            type: s.type,
            location: s.location,
            status: 'connected',
            signalStrength: 0.85 + Random().nextDouble() * 0.15,
            channel: s.channel,
          ))
      .toList();
}

class AssistantModel {
  final String fullName;
  final String role;
  final String city;
  final String email;
  final String phone;
  final int totalVisits;
  final int assessmentsThisMonth;
  final double averageAssessmentTime;
  final double rating;
  final String? photoUrl;

  const AssistantModel({
    required this.fullName,
    required this.role,
    required this.city,
    required this.email,
    required this.phone,
    required this.totalVisits,
    required this.assessmentsThisMonth,
    required this.averageAssessmentTime,
    required this.rating,
    this.photoUrl,
  });

  String get initials {
    final parts = fullName.split(' ');
    if (parts.length >= 2) return '${parts[0][0]}${parts[1][0]}';
    return fullName[0];
  }

  AssistantModel copyWith({String? phone, String? email, String? city}) => AssistantModel(
        fullName: fullName,
        role: role,
        city: city ?? this.city,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        totalVisits: totalVisits,
        assessmentsThisMonth: assessmentsThisMonth,
        averageAssessmentTime: averageAssessmentTime,
        rating: rating,
        photoUrl: photoUrl,
      );

  static const mock = AssistantModel(
    fullName: 'Диас Нурланов',
    role: 'Старший ассистент',
    city: 'Алматы',
    email: 'dias.nurlanov@predemention.kz',
    phone: '+7 (777) 555-01-01',
    totalVisits: 847,
    assessmentsThisMonth: 32,
    averageAssessmentTime: 48.5,
    rating: 4.92,
  );
}


