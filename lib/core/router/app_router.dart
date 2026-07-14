import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/splash/splash_screen.dart';
import '../../features/home/home_screen.dart';
import '../../features/visits/visits_screen.dart';
import '../../features/visit_detail/visit_detail_screen.dart';
import '../../features/device/device_screen.dart';
import '../../features/sensors/sensors_screen.dart';
import '../../features/assessment/assessment_screen.dart';
import '../../features/ai_processing/ai_processing_screen.dart';
import '../../features/report/report_screen.dart';
import '../../features/history/history_screen.dart';
import '../../features/profile/profile_screen.dart';
import '../../features/settings/settings_screen.dart';
import '../../features/settings/license_screen.dart';
import '../../features/settings/privacy_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/visits',
        builder: (context, state) => const VisitsScreen(),
      ),
      GoRoute(
        path: '/visit/:id',
        builder: (context, state) => VisitDetailScreen(
          visitId: state.pathParameters['id']!,
        ),
      ),
      GoRoute(
        path: '/device/:visitId',
        builder: (context, state) => DeviceScreen(
          visitId: state.pathParameters['visitId']!,
        ),
      ),
      GoRoute(
        path: '/sensors/:visitId',
        builder: (context, state) => SensorsScreen(
          visitId: state.pathParameters['visitId']!,
        ),
      ),
      GoRoute(
        path: '/assessment/:visitId',
        builder: (context, state) => AssessmentScreen(
          visitId: state.pathParameters['visitId']!,
        ),
      ),
      GoRoute(
        path: '/processing/:visitId',
        builder: (context, state) => AiProcessingScreen(
          visitId: state.pathParameters['visitId']!,
        ),
      ),
      GoRoute(
        path: '/report/:reportId',
        builder: (context, state) => ReportScreen(
          reportId: state.pathParameters['reportId']!,
        ),
      ),
      GoRoute(
        path: '/history',
        builder: (context, state) => const HistoryScreen(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: '/settings/license',
        builder: (context, state) => const LicenseScreen(),
      ),
      GoRoute(
        path: '/settings/privacy',
        builder: (context, state) => const PrivacyScreen(),
      ),
    ],
  );
});
