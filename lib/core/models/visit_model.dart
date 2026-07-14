import 'package:flutter/material.dart';
import 'dart:math';
import '../../l10n/generated/app_localizations.dart';

class PatientModel {
  final String id;
  final String fullName;
  final int age;
  final String gender;
  final String phone;
  final String email;
  final String address;
  final String city;
  final double lat;
  final double lng;
  final String notes;
  final String? photoUrl;
  final DateTime registeredAt;
  final List<String> conditions;
  final String? emergencyContact;
  final String? emergencyPhone;

  const PatientModel({
    required this.id,
    required this.fullName,
    required this.age,
    required this.gender,
    required this.phone,
    required this.email,
    required this.address,
    required this.city,
    required this.lat,
    required this.lng,
    required this.notes,
    this.photoUrl,
    required this.registeredAt,
    required this.conditions,
    this.emergencyContact,
    this.emergencyPhone,
  });

  String get initials {
    final parts = fullName.split(' ');
    if (parts.length >= 2) return '${parts[0][0]}${parts[1][0]}';
    return fullName[0];
  }

  static List<PatientModel> get mockPatients => [
        PatientModel(
          id: 'P001',
          fullName: 'Аскар Мухамеджанов',
          age: 72,
          gender: 'M',
          phone: '+7 (777) 123-45-67',
          email: 'askar.m@email.kz',
          address: 'ул. Толе би, 156, кв. 42',
          city: 'Алматы',
          lat: 43.2380,
          lng: 76.8829,
          notes: 'Пациент жалуется на легкую забывчивость. Рекомендовано регулярное наблюдение.',
          registeredAt: DateTime(2024, 6, 15),
          conditions: ['MCI', 'Hypertension'],
          emergencyContact: 'Айгуль Мухамеджанова',
          emergencyPhone: '+7 (777) 999-88-77',
        ),
        PatientModel(
          id: 'P002',
          fullName: 'Светлана Ибраева',
          age: 68,
          gender: 'F',
          phone: '+7 (701) 234-56-78',
          email: 'svetlana.i@email.kz',
          address: 'пр. Абая, 89, кв. 15',
          city: 'Алматы',
          lat: 43.2523,
          lng: 76.9345,
          notes: 'Изменения походки заметны последние 3 месяца. Необходимо полное обследование.',
          registeredAt: DateTime(2024, 8, 3),
          conditions: ['Early Alzheimer\'s', 'Osteoarthritis'],
        ),
        PatientModel(
          id: 'P003',
          fullName: 'Канат Нургалиев',
          age: 75,
          gender: 'M',
          phone: '+7 (702) 345-67-89',
          email: 'kanat.n@email.kz',
          address: 'ул. Сатпаева, 34, кв. 7',
          city: 'Астана',
          lat: 51.1282,
          lng: 71.4165,
          notes: 'Пациент после инсульта. Требуется мониторинг восстановления.',
          registeredAt: DateTime(2024, 4, 20),
          conditions: ['Post-Stroke', 'Diabetes Type 2'],
          emergencyContact: 'Динара Нургалиева',
          emergencyPhone: '+7 (702) 111-22-33',
        ),
        PatientModel(
          id: 'P004',
          fullName: 'Гульнара Садыкова',
          age: 70,
          gender: 'F',
          phone: '+7 (777) 456-78-90',
          email: 'gulnara.s@email.kz',
          address: 'мкр. Самал-2, д. 12, кв. 88',
          city: 'Алматы',
          lat: 43.2290,
          lng: 76.9550,
          notes: 'Первичное обследование. Родственники заметили изменения в походке.',
          registeredAt: DateTime(2024, 9, 10),
          conditions: ['Suspected MCI'],
          emergencyContact: 'Нурлан Садыков',
          emergencyPhone: '+7 (777) 333-44-55',
        ),
        PatientModel(
          id: 'P005',
          fullName: 'Бахытжан Тулегенов',
          age: 78,
          gender: 'M',
          phone: '+7 (701) 567-89-01',
          email: 'bahytzhan.t@email.kz',
          address: 'пр. Республики, 45, кв. 23',
          city: 'Усть-Каменогорск',
          lat: 49.9486,
          lng: 82.6283,
          notes: 'Повторное обследование через 3 месяца. Сравнение динамики.',
          registeredAt: DateTime(2024, 5, 28),
          conditions: ['MCI', 'Parkinson\'s Disease'],
        ),
        PatientModel(
          id: 'P006',
          fullName: 'Ольга Петрова',
          age: 65,
          gender: 'F',
          phone: '+7 (702) 678-90-12',
          email: 'olga.p@email.kz',
          address: 'ул. Кабанбай батыра, 78, кв. 56',
          city: 'Астана',
          lat: 51.1482,
          lng: 71.4055,
          notes: 'Жалобы на частые падения.',
          registeredAt: DateTime(2024, 7, 14),
          conditions: ['Balance Disorder', 'Osteoporosis'],
        ),
        PatientModel(
          id: 'P007',
          fullName: 'Ерлан Ахметов',
          age: 73,
          gender: 'M',
          phone: '+7 (777) 789-01-23',
          email: 'yerlan.a@email.kz',
          address: 'ул. Жибек Жолы, 112, кв. 3',
          city: 'Шымкент',
          lat: 42.3176,
          lng: 69.5922,
          notes: 'Пациент из отдаленного района. Выездное обследование.',
          registeredAt: DateTime(2024, 10, 1),
          conditions: ['MCI', 'Coronary Artery Disease'],
        ),
        PatientModel(
          id: 'P008',
          fullName: 'Айжан Токтарова',
          age: 69,
          gender: 'F',
          phone: '+7 (701) 890-12-34',
          email: 'aizhan.t@email.kz',
          address: 'ул. Бухар-Жырау, 67, кв. 31',
          city: 'Караганда',
          lat: 49.8067,
          lng: 73.0854,
          notes: 'Контрольное обследование после курса терапии.',
          registeredAt: DateTime(2024, 3, 15),
          conditions: ['MCI', 'Hypothyroidism'],
        ),
      ];
}

enum VisitStatus {
  scheduled,
  inTransit,
  arriving,
  inProgress,
  completed,
  cancelled,
}

extension VisitStatusExtension on VisitStatus {
  String label(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    switch (this) {
      case VisitStatus.scheduled:
        return l10n.statusScheduled;
      case VisitStatus.inTransit:
        return l10n.statusInTransit;
      case VisitStatus.arriving:
        return l10n.statusArriving;
      case VisitStatus.inProgress:
        return l10n.statusInProgress;
      case VisitStatus.completed:
        return l10n.statusCompleted;
      case VisitStatus.cancelled:
        return l10n.statusCancelled;
    }
  }

  Color get color {
    // Muted, earthy status palette — distinguishable but never bright.
    switch (this) {
      case VisitStatus.scheduled:
        return const Color(0xFF8A8168); // taupe — planned
      case VisitStatus.inTransit:
      case VisitStatus.arriving:
        return const Color(0xFFC08A3B); // ochre — en route
      case VisitStatus.inProgress:
        return const Color(0xFF5B8A63); // sage — active
      case VisitStatus.completed:
        return const Color(0xFF3B6B49); // deep green — done
      case VisitStatus.cancelled:
        return const Color(0xFFB0533C); // clay — cancelled
    }
  }

  IconData get icon {
    switch (this) {
      case VisitStatus.scheduled:
        return Icons.schedule_rounded;
      case VisitStatus.inTransit:
        return Icons.directions_car_rounded;
      case VisitStatus.arriving:
        return Icons.location_on_rounded;
      case VisitStatus.inProgress:
        return Icons.biotech_rounded;
      case VisitStatus.completed:
        return Icons.check_circle_rounded;
      case VisitStatus.cancelled:
        return Icons.cancel_rounded;
    }
  }
}

class VisitModel {
  final String id;
  final PatientModel patient;
  final DateTime scheduledTime;
  final DateTime? actualStartTime;
  final DateTime? actualEndTime;
  final VisitStatus status;
  final String? notes;
  final double assistantLat;
  final double assistantLng;
  final String? assessmentId;

  const VisitModel({
    required this.id,
    required this.patient,
    required this.scheduledTime,
    this.actualStartTime,
    this.actualEndTime,
    required this.status,
    this.notes,
    required this.assistantLat,
    required this.assistantLng,
    this.assessmentId,
  });

  double get distanceKm {
    final dLat = (patient.lat - assistantLat) * pi / 180;
    final dLng = (patient.lng - assistantLng) * pi / 180;
    final a = sin(dLat / 2) * sin(dLat / 2) +
        cos(patient.lat * pi / 180) *
            cos(assistantLat * pi / 180) *
            sin(dLng / 2) *
            sin(dLng / 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return 6371 * c;
  }

  int get estimatedArrivalMinutes {
    final dist = distanceKm;
    if (dist <= 0.1) return 1;
    final speedKmh = 40.0;
    return (dist / speedKmh * 60).ceil();
  }

  static PatientModel _findPatient(String id) =>
      PatientModel.mockPatients.firstWhere((p) => p.id == id);

  static List<VisitModel> getTodayVisits() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    return [
      VisitModel(
        id: 'V001',
        patient: _findPatient('P001'),
        scheduledTime: today.add(const Duration(hours: 9, minutes: 0)),
        status: VisitStatus.scheduled,
        assistantLat: 43.2567,
        assistantLng: 76.9285,
        notes: 'Утренний визит, пациент просил не опаздывать.',
      ),
      VisitModel(
        id: 'V002',
        patient: _findPatient('P002'),
        scheduledTime: today.add(const Duration(hours: 11, minutes: 30)),
        status: VisitStatus.inTransit,
        assistantLat: 43.2400,
        assistantLng: 76.9200,
        actualStartTime: today.add(const Duration(hours: 11, minutes: 15)),
        notes: 'Пациентка в хорошем настроении. Подготовить новое устройство.',
      ),
      VisitModel(
        id: 'V003',
        patient: _findPatient('P003'),
        scheduledTime: today.add(const Duration(hours: 14, minutes: 0)),
        status: VisitStatus.scheduled,
        assistantLat: 43.2567,
        assistantLng: 76.9285,
        notes: 'Повторный визит после инсульта. Особое внимание к асимметрии.',
      ),
      VisitModel(
        id: 'V004',
        patient: _findPatient('P004'),
        scheduledTime: today.add(const Duration(hours: 16, minutes: 0)),
        status: VisitStatus.inProgress,
        actualStartTime: today.add(const Duration(hours: 15, minutes: 50)),
        assistantLat: 43.2290,
        assistantLng: 76.9550,
      ),
    ];
  }

  static List<VisitModel> getAllVisits() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    return [
      ...getTodayVisits(),
      VisitModel(
        id: 'V005',
        patient: _findPatient('P005'),
        scheduledTime: yesterday.add(const Duration(hours: 10, minutes: 0)),
        actualStartTime: yesterday.add(const Duration(hours: 10, minutes: 5)),
        actualEndTime: yesterday.add(const Duration(hours: 10, minutes: 55)),
        status: VisitStatus.completed,
        assistantLat: 49.9486,
        assistantLng: 82.6283,
        assessmentId: 'A003',
      ),
      VisitModel(
        id: 'V006',
        patient: _findPatient('P006'),
        scheduledTime: yesterday.add(const Duration(hours: 13, minutes: 0)),
        actualStartTime: yesterday.add(const Duration(hours: 13, minutes: 10)),
        actualEndTime: yesterday.add(const Duration(hours: 14, minutes: 5)),
        status: VisitStatus.completed,
        assistantLat: 51.1482,
        assistantLng: 71.4055,
        assessmentId: 'A004',
      ),
      VisitModel(
        id: 'V007',
        patient: _findPatient('P007'),
        scheduledTime: today.add(const Duration(hours: 18, minutes: 0)),
        status: VisitStatus.scheduled,
        assistantLat: 43.2567,
        assistantLng: 76.9285,
      ),
      VisitModel(
        id: 'V008',
        patient: _findPatient('P008'),
        scheduledTime: today.subtract(const Duration(days: 2)).add(const Duration(hours: 10, minutes: 0)),
        actualStartTime: today.subtract(const Duration(days: 2)).add(const Duration(hours: 10, minutes: 0)),
        actualEndTime: today.subtract(const Duration(days: 2)).add(const Duration(hours: 10, minutes: 50)),
        status: VisitStatus.completed,
        assistantLat: 49.8067,
        assistantLng: 73.0854,
        assessmentId: 'A005',
      ),
    ];
  }
}
