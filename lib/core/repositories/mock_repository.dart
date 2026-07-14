import 'dart:async';
import 'dart:math';
import '../models/visit_model.dart';
import '../models/device_model.dart';
import '../models/assessment_model.dart';

class MockRepository {
  static final MockRepository _instance = MockRepository._();
  factory MockRepository() => _instance;
  MockRepository._();

  final Random _random = Random();

  // --- Visits ---
  List<VisitModel> getAllVisits() => VisitModel.getAllVisits();
  List<VisitModel> getTodayVisits() => VisitModel.getTodayVisits();

  // --- Devices ---
  List<DeviceModel> getMockDevices() => DeviceModel.mockDevices;

  Future<List<DeviceModel>> scanDevices() async {
    await Future.delayed(const Duration(seconds: 2));
    return DeviceModel.mockDevices;
  }

  Future<bool> connectDevice(String deviceId) async {
    await Future.delayed(const Duration(milliseconds: 1800));
    return true;
  }

  // --- Sensors ---
  List<SensorModel> getMockSensors() => SensorModel.mockSensors;

  Future<bool> checkAllSensors() async {
    final results = <Future<bool>>[];
    for (final _ in SensorModel.mockSensors) {
      results.add(Future.delayed(
        Duration(milliseconds: 300 + _random.nextInt(500)),
        () => _random.nextDouble() > 0.05,
      ));
    }
    final checks = await Future.wait(results);
    return checks.every((c) => c);
  }

  // --- Report ---
  ReportModel generateReport(String patientId, String patientName, String assessmentId) {
    return ReportModel.mockReport(patientId, patientName, assessmentId);
  }

  // --- Live Data Simulation ---
  Stream<Map<String, double>> get imuStream async* {
    while (true) {
      await Future.delayed(const Duration(milliseconds: 50));
      yield {
        'accel_x': _normRandom(0.0, 0.15),
        'accel_y': _normRandom(0.0, 0.12),
        'accel_z': _normRandom(9.81, 0.1),
        'gyro_x': _normRandom(0.0, 5.0),
        'gyro_y': _normRandom(0.0, 5.0),
        'gyro_z': _normRandom(0.0, 3.0),
      };
    }
  }

  Stream<Map<String, double>> get semgStream async* {
    while (true) {
      await Future.delayed(const Duration(milliseconds: 30));
      yield {
        'ch1': _positiveRandom(0.02),
        'ch2': _positiveRandom(0.015),
        'ch3': _positiveRandom(0.025),
        'ch4': _positiveRandom(0.018),
      };
    }
  }

  Stream<Map<String, double>> get gaitMetrics async* {
    double riskScore = 35.0;
    double confidence = 0.85;
    double walkingSpeed = 0.95;
    double cadence = 96.0;
    double asymmetry = 7.5;
    double stepCount = 0;
    double lostPackets = 0;
    double signalQuality = 98.5;

    while (true) {
      await Future.delayed(const Duration(milliseconds: 500));
      riskScore += _normRandom(0, 0.3);
      riskScore = riskScore.clamp(20, 80);
      confidence += _normRandom(0, 0.2);
      confidence = confidence.clamp(0.7, 0.99);
      walkingSpeed += _normRandom(0, 0.02);
      walkingSpeed = walkingSpeed.clamp(0.7, 1.4);
      cadence += _normRandom(0, 0.3);
      cadence = cadence.clamp(80, 115);
      asymmetry += _normRandom(0, 0.1);
      asymmetry = asymmetry.clamp(3, 15);
      stepCount++;
      if (_random.nextDouble() < 0.02) lostPackets++;
      signalQuality += _normRandom(0, 0.05);
      signalQuality = signalQuality.clamp(90, 100);

      yield {
        'risk_score': riskScore,
        'confidence': confidence,
        'walking_speed': walkingSpeed,
        'cadence': cadence,
        'asymmetry': asymmetry,
        'step_count': stepCount,
        'lost_packets': lostPackets,
        'signal_quality': signalQuality,
      };
    }
  }

  Stream<int> get elapsedTimeStream async* {
    int seconds = 0;
    while (true) {
      await Future.delayed(const Duration(seconds: 1));
      seconds++;
      yield seconds;
    }
  }

  // --- AI Processing Simulation ---
  Stream<String> get aiProcessingSteps async* {
    const steps = [
      'Uploading sensor data...',
      'Synchronizing IMU and sEMG streams...',
      'Preprocessing signals (bandpass filter)...',
      'Extracting gait features...',
      'Computing spatiotemporal parameters...',
      'Analyzing symmetry indices...',
      'Running neural network inference...',
      'Comparing with normative database...',
      'Generating risk assessment...',
      'Compiling medical report...',
      'Completed',
    ];

    for (final step in steps) {
      await Future.delayed(Duration(milliseconds: 800 + _random.nextInt(600)));
      yield step;
    }
  }

  // --- Helpers ---
  double _normRandom(double mean, double stddev) {
    final u1 = _random.nextDouble();
    final u2 = _random.nextDouble();
    final z = sqrt(-2.0 * log(u1)) * cos(2.0 * pi * u2);
    return mean + z * stddev;
  }

  double _positiveRandom(double max) {
    return _random.nextDouble() * max;
  }
}
