// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get navHome => 'Home';

  @override
  String get navVisits => 'Visits';

  @override
  String get navHistory => 'History';

  @override
  String get navProfile => 'Profile';

  @override
  String get navSettings => 'Settings';

  @override
  String get greetingNight => 'Good night';

  @override
  String get greetingMorning => 'Good morning';

  @override
  String get greetingDay => 'Good afternoon';

  @override
  String get greetingEvening => 'Good evening';

  @override
  String get appTagline => 'Early detection. Better outcomes.';

  @override
  String get sectionCurrentAssessment => 'Current assessment';

  @override
  String get sectionNextVisit => 'Next visit';

  @override
  String get sectionTodayVisits => 'Today\'s visits';

  @override
  String get sectionQuickActions => 'Quick actions';

  @override
  String get assessmentInProgressLabel => 'Assessment in progress';

  @override
  String get quickActionNewVisit => 'New visit';

  @override
  String get quickActionReports => 'Reports';

  @override
  String get quickActionDevices => 'Devices';

  @override
  String get statTodayLabel => 'Today';

  @override
  String get statTotalVisitsLabel => 'Total visits';

  @override
  String get statRatingLabel => 'Rating';

  @override
  String get statusScheduled => 'Scheduled';

  @override
  String get statusInTransit => 'En route';

  @override
  String get statusArriving => 'Arriving';

  @override
  String get statusInProgress => 'In progress';

  @override
  String get statusCompleted => 'Completed';

  @override
  String get statusCancelled => 'Cancelled';

  @override
  String get visitsScreenTitle => 'My visits';

  @override
  String get searchHintNameOrCity => 'Search by name or city...';

  @override
  String get filterAll => 'All';

  @override
  String get sectionPatient => 'Patient';

  @override
  String get sectionContacts => 'Contacts';

  @override
  String get sectionNotes => 'Notes';

  @override
  String get sectionConditions => 'Conditions';

  @override
  String get visitNotFound => 'Visit not found';

  @override
  String get startAssessmentButton => 'Start assessment';

  @override
  String get continueAssessmentButton => 'Continue assessment';

  @override
  String get buildRouteButton => 'Build route';

  @override
  String distanceKmLabel(String km) {
    return '$km km';
  }

  @override
  String etaMinutesLabel(int minutes) {
    return '~$minutes min';
  }

  @override
  String get mapYouAreHere => 'You are here';

  @override
  String get fieldFullName => 'Full name';

  @override
  String get fieldAge => 'Age';

  @override
  String fieldAgeValue(int age, String gender) {
    return '$age years ($gender)';
  }

  @override
  String get genderMale => 'Male';

  @override
  String get genderFemale => 'Female';

  @override
  String get fieldAddress => 'Address';

  @override
  String get fieldRegistered => 'Registered';

  @override
  String get fieldPhone => 'Phone';

  @override
  String get fieldEmail => 'Email';

  @override
  String get fieldCity => 'City';

  @override
  String get fieldEmergencyContact => 'Emergency contact';

  @override
  String get moreMenuTitle => 'Actions';

  @override
  String get moreMenuCallPatient => 'Call patient';

  @override
  String get moreMenuEmailPatient => 'Email patient';

  @override
  String moreMenuCallEmergencyContact(String name) {
    return 'Call $name';
  }

  @override
  String get deviceScreenTitle => 'Connect device';

  @override
  String get deviceSearching => 'Searching for devices...';

  @override
  String get deviceConnected => 'Connected';

  @override
  String get deviceChooseDevice => 'Choose a device';

  @override
  String get deviceScanning => 'Scanning...';

  @override
  String get deviceConnectedTitle => 'Device connected';

  @override
  String get deviceGoingToSensors => 'Proceeding to sensor check...';

  @override
  String get deviceFieldDevice => 'Device';

  @override
  String get deviceFieldSerial => 'Serial number';

  @override
  String get deviceFieldFirmware => 'Firmware';

  @override
  String get deviceFieldBattery => 'Battery';

  @override
  String get sensorsScreenTitle => 'Sensor check';

  @override
  String sensorsActiveCount(int active, int total) {
    return '$active/$total sensors active';
  }

  @override
  String get sensorsChecking => 'Checking...';

  @override
  String get sensorsCheckButton => 'Check sensors';

  @override
  String get assessmentScreenTitle => 'Assessment';

  @override
  String get assessmentReady => 'Ready to start';

  @override
  String get assessmentRecording => 'Recording...';

  @override
  String get assessmentPaused => 'Paused';

  @override
  String get assessmentResume => 'Resume';

  @override
  String get assessmentFinish => 'Finish';

  @override
  String get sectionMetrics => 'Metrics';

  @override
  String get sectionSensors => 'Sensors';

  @override
  String sensorsConnectedCount(int connected, int total) {
    return '$connected/$total connected';
  }

  @override
  String get metricSpeed => 'Speed';

  @override
  String get metricCadence => 'Cadence';

  @override
  String get metricAsymmetry => 'Asymmetry';

  @override
  String get metricSteps => 'Steps';

  @override
  String get metricQuality => 'Quality';

  @override
  String get metricLostPackets => 'Lost';

  @override
  String get chartWaitingForData => 'Waiting for data...';

  @override
  String get aiProcessingTitle => 'AI analysis in progress';

  @override
  String get aiProcessingSubtitle => 'Please wait while we process the data';

  @override
  String get aiProcessingComplete => 'Analysis complete';

  @override
  String get aiProcessingReportReady => 'Report ready';

  @override
  String get aiStepUploading => 'Uploading sensor data...';

  @override
  String get aiStepSyncing => 'Synchronizing IMU and sEMG streams...';

  @override
  String get aiStepPreprocessing =>
      'Preprocessing signals (bandpass filter)...';

  @override
  String get aiStepExtracting => 'Extracting gait features...';

  @override
  String get aiStepSpatiotemporal => 'Computing spatiotemporal parameters...';

  @override
  String get aiStepSymmetry => 'Analyzing symmetry indices...';

  @override
  String get aiStepInference => 'Running neural network inference...';

  @override
  String get aiStepNormative => 'Comparing with normative database...';

  @override
  String get aiStepRisk => 'Generating risk assessment...';

  @override
  String get aiStepReport => 'Compiling medical report...';

  @override
  String get reportScreenTitle => 'Medical report';

  @override
  String get sectionConclusion => 'Conclusion';

  @override
  String get sectionKeyObservations => 'Key observations';

  @override
  String get sectionRecommendations => 'Recommendations';

  @override
  String get sectionTimeline => 'Assessment timeline';

  @override
  String get savePdfButton => 'Save PDF';

  @override
  String get sendToDoctorButton => 'Send to doctor';

  @override
  String get reportActionsSheetTitle => 'Share report';

  @override
  String get reportActionSend => 'Email to doctor';

  @override
  String get reportActionCopy => 'Copy report';

  @override
  String get reportActionSavePdf => 'Save PDF';

  @override
  String get reportCopiedSnackbar => 'Report copied to clipboard';

  @override
  String get savePdfSnackbar => 'Report PDF is ready to save';

  @override
  String get savePdfErrorSnackbar => 'Could not create PDF. Please try again.';

  @override
  String get timelineStarted => 'Assessment started';

  @override
  String get timelineSensorCheck => 'Sensor check';

  @override
  String get timelineWalkingDone => 'Walking completed';

  @override
  String get timelineUploadDone => 'Data uploaded';

  @override
  String get timelineAnalysisDone => 'Analysis completed';

  @override
  String get timelineReportGenerated => 'Report generated';

  @override
  String get historyScreenTitle => 'History';

  @override
  String get emptyStateNoCompletedAssessments => 'No completed assessments';

  @override
  String assessmentsCountSuffix(int count) {
    return '$count assessments';
  }

  @override
  String durationMinutesSuffix(int minutes) {
    return '$minutes min';
  }

  @override
  String get profileScreenTitle => 'Profile';

  @override
  String get sectionContactInfo => 'Contact information';

  @override
  String get sectionCertifications => 'Certifications';

  @override
  String get statTotalVisits => 'Total visits';

  @override
  String get statThisMonth => 'This month';

  @override
  String get statAvgTime => 'Average time';

  @override
  String get statDevices => 'Devices';

  @override
  String get unitMinutes => 'min';

  @override
  String get fieldRole => 'Role';

  @override
  String get editProfileSheetTitle => 'Edit profile';

  @override
  String get saveButton => 'Save';

  @override
  String get cancelButton => 'Cancel';

  @override
  String get settingsScreenTitle => 'Settings';

  @override
  String get sectionAppearance => 'Appearance';

  @override
  String get sectionNotificationsHeader => 'Notifications';

  @override
  String get sectionData => 'Data';

  @override
  String get sectionMap => 'Map';

  @override
  String get sectionAbout => 'About';

  @override
  String get themeTileTitle => 'Theme';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get themeSystem => 'System';

  @override
  String get languageTileTitle => 'Language';

  @override
  String get pushNotificationsTitle => 'Push notifications';

  @override
  String get pushNotificationsSubtitle => 'New visits and reminders';

  @override
  String get autoSyncTitle => 'Auto-sync';

  @override
  String get autoSyncSubtitle => 'Sync assessment data';

  @override
  String get cacheTitle => 'Data cache';

  @override
  String get clearCacheButton => 'Clear';

  @override
  String get clearCacheDialogTitle => 'Clear cache?';

  @override
  String get clearCacheDialogBody =>
      'Locally cached assessment data will be removed from this device.';

  @override
  String get clearCacheConfirm => 'Clear';

  @override
  String get clearCacheSnackbar => 'Cache cleared';

  @override
  String get darkMapTitle => 'Dark map theme';

  @override
  String get darkMapSubtitle => 'Improves marker visibility';

  @override
  String get versionTitle => 'Version';

  @override
  String get licenseTileTitle => 'License agreement';

  @override
  String get privacyTileTitle => 'Privacy policy';

  @override
  String get footerCopyright => '© 2024 PreDemention Inc.';

  @override
  String get licenseScreenTitle => 'License agreement';

  @override
  String get licenseBody =>
      '1. General\n\nBy using the PreDemention app, you agree to these terms. The app is intended for use by trained medical staff and field assistants conducting home assessments.\n\n2. Purpose and limitations\n\nPreDemention is a gait-screening tool intended to help identify early signs of mild cognitive impairment. The app is NOT a diagnostic medical device and does not replace consultation with a physician. Assessment results must be interpreted by a qualified specialist.\n\n3. Sensor data and biomechanical measurements\n\nDuring an assessment, the app collects data from inertial (IMU) and electromyographic (sEMG) sensors, along with gait metrics computed from them. This data is used solely to produce the assessment report.\n\n4. Intellectual property\n\nAll software, analysis algorithms, and interface elements are the property of PreDemention Inc. and are protected by intellectual property law.\n\n5. Limitation of liability\n\nPreDemention Inc. is not liable for decisions made solely on the basis of app data without the involvement of a qualified medical professional.\n\n6. Contact\n\nFor questions about this agreement, contact: legal@predemention.kz';

  @override
  String get privacyScreenTitle => 'Privacy policy';

  @override
  String get privacyBody =>
      '1. What data we collect\n\nThe app processes: gait sensor data (IMU/sEMG), patient personal data (name, age, contacts, address), visit geolocation, and assistant account data.\n\n2. How data is used\n\nAssessment data is used to generate the medical report and risk score. Geolocation is used to build a route to the patient and estimate arrival time.\n\n3. Storage and protection\n\nAssessment data is stored with encryption and is accessible only to authorized personnel. Retention periods are governed by applicable medical data regulations.\n\n4. Third-party services\n\nThe app uses Google Maps for map display. Route building shares some location data with Google in accordance with its privacy policy.\n\n5. Patient rights\n\nPatients may request access to, correction of, or deletion of their data by contacting their care provider.\n\n6. Contact\n\nFor questions about personal data processing: privacy@predemention.kz';

  @override
  String get notificationsSheetTitle => 'Notifications';

  @override
  String get notificationsDisabledState =>
      'Notifications are disabled in settings';

  @override
  String get notificationsDisabledAction => 'Open settings';

  @override
  String get notificationsEmptyState => 'No new notifications';

  @override
  String notificationVisitScheduled(String name, String time) {
    return 'Visit with $name scheduled for $time';
  }

  @override
  String notificationVisitInProgress(String name) {
    return 'Assessment in progress: $name';
  }

  @override
  String notificationVisitCompleted(String name) {
    return 'Assessment completed: $name';
  }

  @override
  String get commonClose => 'Close';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonSave => 'Save';

  @override
  String get commonOk => 'OK';
}
