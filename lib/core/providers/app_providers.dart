import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/mock_repository.dart';
import '../models/visit_model.dart';
import '../models/device_model.dart';
import '../models/assessment_model.dart';
import 'assistant_provider.dart';

final mockRepositoryProvider = Provider<MockRepository>((ref) => MockRepository());

final todayVisitsProvider = Provider<List<VisitModel>>((ref) {
  return ref.read(mockRepositoryProvider).getTodayVisits();
});

final allVisitsProvider = Provider<List<VisitModel>>((ref) {
  return ref.read(mockRepositoryProvider).getAllVisits();
});

final devicesProvider = Provider<List<DeviceModel>>((ref) {
  return ref.read(mockRepositoryProvider).getMockDevices();
});

final sensorsProvider = Provider<List<SensorModel>>((ref) {
  return ref.read(mockRepositoryProvider).getMockSensors();
});

/// Raw metrics captured by [AssessmentScreen] when a session finishes,
/// consumed by [AiProcessingScreen] to build the final report.
final assessmentSessionProvider = StateProvider<AssessmentSessionData?>((ref) => null);

/// The report generated from the most recently completed assessment
/// session. [ReportScreen] prefers this over the fixed mock when its id
/// matches the requested reportId.
final assessmentReportProvider = StateProvider<ReportModel?>((ref) => null);

final assistantProvider = Provider<AssistantModel>((ref) => ref.watch(assistantProfileProvider));

/// Whether the home screen's notification bell has unseen notifications.
final homeUnreadNotificationsProvider = StateProvider<bool>((ref) => true);
