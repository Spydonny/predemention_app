// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Kazakh (`kk`).
class AppLocalizationsKk extends AppLocalizations {
  AppLocalizationsKk([String locale = 'kk']) : super(locale);

  @override
  String get navHome => 'Басты бет';

  @override
  String get navVisits => 'Сапарлар';

  @override
  String get navHistory => 'Тарих';

  @override
  String get navProfile => 'Профиль';

  @override
  String get navSettings => 'Параметрлер';

  @override
  String get greetingNight => 'Қайырлы түн';

  @override
  String get greetingMorning => 'Қайырлы таң';

  @override
  String get greetingDay => 'Қайырлы күн';

  @override
  String get greetingEvening => 'Қайырлы кеш';

  @override
  String get appTagline => 'Ерте анықтау. Жақсырақ нәтиже.';

  @override
  String get sectionCurrentAssessment => 'Ағымдағы тексеру';

  @override
  String get sectionNextVisit => 'Жақын сапар';

  @override
  String get sectionTodayVisits => 'Бүгінгі сапарлар';

  @override
  String get sectionQuickActions => 'Жылдам әрекеттер';

  @override
  String get assessmentInProgressLabel => 'Тексеру жүріп жатыр';

  @override
  String get quickActionNewVisit => 'Жаңа сапар';

  @override
  String get quickActionReports => 'Есептер';

  @override
  String get quickActionDevices => 'Құрылғылар';

  @override
  String get statTodayLabel => 'Бүгін';

  @override
  String get statTotalVisitsLabel => 'Барлық сапарлар';

  @override
  String get statRatingLabel => 'Рейтинг';

  @override
  String get statusScheduled => 'Жоспарланған';

  @override
  String get statusInTransit => 'Жолда';

  @override
  String get statusArriving => 'Келе жатыр';

  @override
  String get statusInProgress => 'Тексеру жүріп жатыр';

  @override
  String get statusCompleted => 'Аяқталды';

  @override
  String get statusCancelled => 'Болдырылмады';

  @override
  String get visitsScreenTitle => 'Менің сапарларым';

  @override
  String get searchHintNameOrCity => 'Аты немесе қала бойынша іздеу...';

  @override
  String get filterAll => 'Барлығы';

  @override
  String get sectionPatient => 'Пациент';

  @override
  String get sectionContacts => 'Байланыстар';

  @override
  String get sectionNotes => 'Жазбалар';

  @override
  String get sectionConditions => 'Диагноздар';

  @override
  String get visitNotFound => 'Сапар табылмады';

  @override
  String get startAssessmentButton => 'Тексеруді бастау';

  @override
  String get continueAssessmentButton => 'Тексеруді жалғастыру';

  @override
  String get buildRouteButton => 'Бағыт салу';

  @override
  String distanceKmLabel(String km) {
    return '$km км';
  }

  @override
  String etaMinutesLabel(int minutes) {
    return '~$minutes мин';
  }

  @override
  String get mapYouAreHere => 'Сіз осындасыз';

  @override
  String get fieldFullName => 'Аты-жөні';

  @override
  String get fieldAge => 'Жасы';

  @override
  String fieldAgeValue(int age, String gender) {
    return '$age жас ($gender)';
  }

  @override
  String get genderMale => 'Ер';

  @override
  String get genderFemale => 'Әйел';

  @override
  String get fieldAddress => 'Мекенжай';

  @override
  String get fieldRegistered => 'Тіркелген күні';

  @override
  String get fieldPhone => 'Телефон';

  @override
  String get fieldEmail => 'Email';

  @override
  String get fieldCity => 'Қала';

  @override
  String get fieldEmergencyContact => 'Шұғыл байланыс';

  @override
  String get moreMenuTitle => 'Әрекеттер';

  @override
  String get moreMenuCallPatient => 'Пациентке қоңырау шалу';

  @override
  String get moreMenuEmailPatient => 'Поштаға хат жазу';

  @override
  String moreMenuCallEmergencyContact(String name) {
    return 'Қоңырау шалу: $name';
  }

  @override
  String get deviceScreenTitle => 'Құрылғыны қосу';

  @override
  String get deviceSearching => 'Құрылғыларды іздеу...';

  @override
  String get deviceConnected => 'Қосылды';

  @override
  String get deviceChooseDevice => 'Құрылғыны таңдаңыз';

  @override
  String get deviceScanning => 'Сканерлеу...';

  @override
  String get deviceConnectedTitle => 'Құрылғы қосылды';

  @override
  String get deviceGoingToSensors => 'Датчиктерді тексеруге өту...';

  @override
  String get deviceFieldDevice => 'Құрылғы';

  @override
  String get deviceFieldSerial => 'Сериялық нөмір';

  @override
  String get deviceFieldFirmware => 'Микробағдарлама';

  @override
  String get deviceFieldBattery => 'Заряд';

  @override
  String get sensorsScreenTitle => 'Датчиктерді тексеру';

  @override
  String sensorsActiveCount(int active, int total) {
    return '$active/$total датчик белсенді';
  }

  @override
  String get sensorsChecking => 'Тексеру...';

  @override
  String get sensorsCheckButton => 'Датчиктерді тексеру';

  @override
  String get assessmentScreenTitle => 'Тексеру';

  @override
  String get assessmentReady => 'Бастауға дайын';

  @override
  String get assessmentRecording => 'Жазба...';

  @override
  String get assessmentPaused => 'Кідірту';

  @override
  String get assessmentResume => 'Жалғастыру';

  @override
  String get assessmentFinish => 'Аяқтау';

  @override
  String get sectionMetrics => 'Көрсеткіштер';

  @override
  String get sectionSensors => 'Датчиктер';

  @override
  String sensorsConnectedCount(int connected, int total) {
    return '$connected/$total қосылды';
  }

  @override
  String get metricSpeed => 'Жылдамдық';

  @override
  String get metricCadence => 'Каденс';

  @override
  String get metricAsymmetry => 'Асимметрия';

  @override
  String get metricSteps => 'Қадамдар';

  @override
  String get metricQuality => 'Сапа';

  @override
  String get metricLostPackets => 'Жоғалту';

  @override
  String get chartWaitingForData => 'Деректер күтілуде...';

  @override
  String get aiProcessingTitle => 'AI талдауы жүріп жатыр';

  @override
  String get aiProcessingSubtitle => 'Күте тұрыңыз — деректер өңделуде';

  @override
  String get aiProcessingComplete => 'Талдау аяқталды';

  @override
  String get aiProcessingReportReady => 'Есеп дайын';

  @override
  String get aiStepUploading => 'Сенсор деректерін жүктеу...';

  @override
  String get aiStepSyncing => 'IMU және sEMG ағындарын синхрондау...';

  @override
  String get aiStepPreprocessing =>
      'Сигналдарды алдын ала өңдеу (жолақты сүзгі)...';

  @override
  String get aiStepExtracting => 'Жүріс параметрлерін анықтау...';

  @override
  String get aiStepSpatiotemporal =>
      'Кеңістіктік-уақыттық параметрлерді есептеу...';

  @override
  String get aiStepSymmetry => 'Симметрия индекстерін талдау...';

  @override
  String get aiStepInference => 'Нейрондық желі моделін іске қосу...';

  @override
  String get aiStepNormative => 'Норматив дерекқорымен салыстыру...';

  @override
  String get aiStepRisk => 'Тәуекел бағасын қалыптастыру...';

  @override
  String get aiStepReport => 'Медициналық есепті құрастыру...';

  @override
  String get reportScreenTitle => 'Медициналық есеп';

  @override
  String get sectionConclusion => 'Қорытынды';

  @override
  String get sectionKeyObservations => 'Негізгі байқаулар';

  @override
  String get sectionRecommendations => 'Ұсынымдар';

  @override
  String get sectionTimeline => 'Тексеру хронологиясы';

  @override
  String get savePdfButton => 'PDF сақтау';

  @override
  String get sendToDoctorButton => 'Дәрігерге жіберу';

  @override
  String get reportActionsSheetTitle => 'Есеппен бөлісу';

  @override
  String get reportActionSend => 'Дәрігерге поштамен жіберу';

  @override
  String get reportActionCopy => 'Есепті көшіру';

  @override
  String get reportCopiedSnackbar => 'Есеп аралық буферге көшірілді';

  @override
  String get savePdfSnackbar =>
      'Есеп мәтін ретінде көшірілді — файл ретінде сақтау үшін оны жазбаларға немесе құжатқа қойыңыз';

  @override
  String get timelineStarted => 'Тексерудің басталуы';

  @override
  String get timelineSensorCheck => 'Датчиктерді тексеру';

  @override
  String get timelineWalkingDone => 'Жүрісті аяқтау';

  @override
  String get timelineUploadDone => 'Деректерді жүктеу';

  @override
  String get timelineAnalysisDone => 'Талдау аяқталды';

  @override
  String get timelineReportGenerated => 'Есеп құрылды';

  @override
  String get historyScreenTitle => 'Тарих';

  @override
  String get emptyStateNoCompletedAssessments => 'Аяқталған тексерулер жоқ';

  @override
  String assessmentsCountSuffix(int count) {
    return '$count тексеру';
  }

  @override
  String durationMinutesSuffix(int minutes) {
    return '$minutes мин';
  }

  @override
  String get profileScreenTitle => 'Профиль';

  @override
  String get sectionContactInfo => 'Байланыс ақпараты';

  @override
  String get sectionCertifications => 'Сертификаттар';

  @override
  String get statTotalVisits => 'Барлық сапарлар';

  @override
  String get statThisMonth => 'Осы айда';

  @override
  String get statAvgTime => 'Орташа уақыт';

  @override
  String get statDevices => 'Құрылғылар';

  @override
  String get unitMinutes => 'мин';

  @override
  String get fieldRole => 'Лауазым';

  @override
  String get editProfileSheetTitle => 'Профильді өңдеу';

  @override
  String get saveButton => 'Сақтау';

  @override
  String get cancelButton => 'Бас тарту';

  @override
  String get settingsScreenTitle => 'Параметрлер';

  @override
  String get sectionAppearance => 'Сыртқы түрі';

  @override
  String get sectionNotificationsHeader => 'Хабарландырулар';

  @override
  String get sectionData => 'Деректер';

  @override
  String get sectionMap => 'Карта';

  @override
  String get sectionAbout => 'Қолданба туралы';

  @override
  String get themeTileTitle => 'Тема';

  @override
  String get themeLight => 'Ашық';

  @override
  String get themeDark => 'Қараңғы';

  @override
  String get themeSystem => 'Жүйелік';

  @override
  String get languageTileTitle => 'Тіл';

  @override
  String get pushNotificationsTitle => 'Push-хабарландырулар';

  @override
  String get pushNotificationsSubtitle => 'Жаңа сапарлар мен еске салулар';

  @override
  String get autoSyncTitle => 'Автосинхрондау';

  @override
  String get autoSyncSubtitle => 'Тексеру деректерін синхрондау';

  @override
  String get cacheTitle => 'Деректер кэші';

  @override
  String get clearCacheButton => 'Тазалау';

  @override
  String get clearCacheDialogTitle => 'Кэшті тазалау керек пе?';

  @override
  String get clearCacheDialogBody =>
      'Осы құрылғыда жергілікті сақталған тексеру деректері жойылады.';

  @override
  String get clearCacheConfirm => 'Тазалау';

  @override
  String get clearCacheSnackbar => 'Кэш тазаланды';

  @override
  String get darkMapTitle => 'Картаның қараңғы темасы';

  @override
  String get darkMapSubtitle => 'Маркерлердің көрінуін жақсартады';

  @override
  String get versionTitle => 'Нұсқа';

  @override
  String get licenseTileTitle => 'Лицензиялық келісім';

  @override
  String get privacyTileTitle => 'Құпиялылық саясаты';

  @override
  String get footerCopyright => '© 2024 PreDemention Inc.';

  @override
  String get licenseScreenTitle => 'Лицензиялық келісім';

  @override
  String get licenseBody =>
      '1. Жалпы ережелер\n\nPreDemention қолданбасын пайдалану арқылы сіз осы шарттармен келісесіз. Қолданба үйде тексеру жүргізетін білікті медицина қызметкерлері мен ассистенттерге арналған.\n\n2. Мақсаты және шектеулері\n\nPreDemention — жеңіл когнитивтік бұзылыстардың ерте белгілерін анықтауға көмектесетін жүріс скринингі құралы. Қолданба диагностикалық медициналық құрал болып ЕСЕПТЕЛМЕЙДІ және дәрігермен кеңесуді алмастырмайды. Тексеру нәтижелерін білікті маман түсіндіруі тиіс.\n\n3. Датчик деректері және биомеханикалық өлшемдер\n\nТексеру барысында қолданба инерциялық (IMU) және электромиографиялық (sEMG) датчиктерден деректер, сондай-ақ солардың негізінде есептелген жүріс көрсеткіштерін жинайды. Бұл деректер тек тексеру есебін қалыптастыру үшін пайдаланылады.\n\n4. Зияткерлік меншік\n\nБарлық бағдарламалық қамтамасыз ету, талдау алгоритмдері мен интерфейс элементтері PreDemention Inc. компаниясының меншігі болып табылады және зияткерлік меншік заңнамасымен қорғалған.\n\n5. Жауапкершілікті шектеу\n\nPreDemention Inc. білікті медицина маманының қатысуынсыз тек қолданба деректеріне негізделген шешімдер үшін жауапты болмайды.\n\n6. Байланыс\n\nОсы келісімге қатысты сұрақтар бойынша: legal@predemention.kz';

  @override
  String get privacyScreenTitle => 'Құпиялылық саясаты';

  @override
  String get privacyBody =>
      '1. Біз қандай деректерді жинаймыз\n\nҚолданба мыналарды өңдейді: жүріс датчиктерінің деректері (IMU/sEMG), пациенттердің дербес деректері (аты-жөні, жасы, байланыстары, мекенжайы), сапардың геолокациясы, сондай-ақ ассистенттің есептік жазба деректері.\n\n2. Деректер қалай пайдаланылады\n\nТексеру деректері медициналық есепті және тәуекел бағасын қалыптастыру үшін пайдаланылады. Геолокация пациентке дейінгі бағытты салу және келу уақытын есептеу үшін қолданылады.\n\n3. Сақтау және қорғау\n\nТексеру деректері шифрлау арқылы сақталады және тек уәкілетті персоналға қолжетімді. Сақтау мерзімі қолданыстағы медициналық заңнамамен анықталады.\n\n4. Үшінші тарап қызметтері\n\nКарталарды көрсету үшін қолданба Google Maps пайдаланады. Бағыт салу кезінде орналасу деректерінің бір бөлігі Google-дың құпиялылық саясатына сәйкес осы қызметке беріледі.\n\n5. Пациенттің құқықтары\n\nПациент өзі туралы жиналған деректерге қолжетімділікті, оларды түзетуді немесе жоюды сұрауға құқылы, ол үшін емдеу мекемесіне жүгіну қажет.\n\n6. Байланыс\n\nДербес деректерді өңдеуге қатысты сұрақтар бойынша: privacy@predemention.kz';

  @override
  String get notificationsSheetTitle => 'Хабарландырулар';

  @override
  String get notificationsDisabledState =>
      'Хабарландырулар параметрлерде өшірілген';

  @override
  String get notificationsDisabledAction => 'Параметрлерді ашу';

  @override
  String get notificationsEmptyState => 'Жаңа хабарландырулар жоқ';

  @override
  String notificationVisitScheduled(String name, String time) {
    return '$name үшін сапар $time уақытына жоспарланған';
  }

  @override
  String notificationVisitInProgress(String name) {
    return 'Тексеру жүріп жатыр: $name';
  }

  @override
  String notificationVisitCompleted(String name) {
    return 'Тексеру аяқталды: $name';
  }

  @override
  String get commonClose => 'Жабу';

  @override
  String get commonCancel => 'Бас тарту';

  @override
  String get commonSave => 'Сақтау';

  @override
  String get commonOk => 'Жарайды';
}
