// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get navHome => 'Главная';

  @override
  String get navVisits => 'Визиты';

  @override
  String get navHistory => 'История';

  @override
  String get navProfile => 'Профиль';

  @override
  String get navSettings => 'Настройки';

  @override
  String get greetingNight => 'Доброй ночи';

  @override
  String get greetingMorning => 'Доброе утро';

  @override
  String get greetingDay => 'Добрый день';

  @override
  String get greetingEvening => 'Добрый вечер';

  @override
  String get appTagline => 'Раннее выявление. Лучшие результаты.';

  @override
  String get sectionCurrentAssessment => 'Текущее обследование';

  @override
  String get sectionNextVisit => 'Ближайший визит';

  @override
  String get sectionTodayVisits => 'Визиты на сегодня';

  @override
  String get sectionQuickActions => 'Быстрые действия';

  @override
  String get assessmentInProgressLabel => 'Обследование идёт';

  @override
  String get quickActionNewVisit => 'Новый визит';

  @override
  String get quickActionReports => 'Отчёты';

  @override
  String get quickActionDevices => 'Устройства';

  @override
  String get statTodayLabel => 'Сегодня';

  @override
  String get statTotalVisitsLabel => 'Всего визитов';

  @override
  String get statRatingLabel => 'Рейтинг';

  @override
  String get statusScheduled => 'Запланирован';

  @override
  String get statusInTransit => 'В пути';

  @override
  String get statusArriving => 'Прибывает';

  @override
  String get statusInProgress => 'Идёт обследование';

  @override
  String get statusCompleted => 'Завершён';

  @override
  String get statusCancelled => 'Отменён';

  @override
  String get visitsScreenTitle => 'Мои визиты';

  @override
  String get searchHintNameOrCity => 'Поиск по имени или городу...';

  @override
  String get filterAll => 'Все';

  @override
  String get sectionPatient => 'Пациент';

  @override
  String get sectionContacts => 'Контакты';

  @override
  String get sectionNotes => 'Заметки';

  @override
  String get sectionConditions => 'Диагнозы';

  @override
  String get visitNotFound => 'Визит не найден';

  @override
  String get startAssessmentButton => 'Начать обследование';

  @override
  String get continueAssessmentButton => 'Продолжить обследование';

  @override
  String get buildRouteButton => 'Построить маршрут';

  @override
  String distanceKmLabel(String km) {
    return '$km км';
  }

  @override
  String etaMinutesLabel(int minutes) {
    return '~$minutes мин';
  }

  @override
  String get mapYouAreHere => 'Вы здесь';

  @override
  String get fieldFullName => 'ФИО';

  @override
  String get fieldAge => 'Возраст';

  @override
  String fieldAgeValue(int age, String gender) {
    return '$age лет ($gender)';
  }

  @override
  String get genderMale => 'Муж.';

  @override
  String get genderFemale => 'Жен.';

  @override
  String get fieldAddress => 'Адрес';

  @override
  String get fieldRegistered => 'Зарегистрирован';

  @override
  String get fieldPhone => 'Телефон';

  @override
  String get fieldEmail => 'Email';

  @override
  String get fieldCity => 'Город';

  @override
  String get fieldEmergencyContact => 'Экстренный контакт';

  @override
  String get moreMenuTitle => 'Действия';

  @override
  String get moreMenuCallPatient => 'Позвонить пациенту';

  @override
  String get moreMenuEmailPatient => 'Написать на почту';

  @override
  String moreMenuCallEmergencyContact(String name) {
    return 'Позвонить: $name';
  }

  @override
  String get deviceScreenTitle => 'Подключение устройства';

  @override
  String get deviceSearching => 'Поиск устройств...';

  @override
  String get deviceConnected => 'Подключено';

  @override
  String get deviceChooseDevice => 'Выберите устройство';

  @override
  String get deviceScanning => 'Сканирование...';

  @override
  String get deviceConnectedTitle => 'Устройство подключено';

  @override
  String get deviceGoingToSensors => 'Переход к проверке датчиков...';

  @override
  String get deviceFieldDevice => 'Устройство';

  @override
  String get deviceFieldSerial => 'Серийный номер';

  @override
  String get deviceFieldFirmware => 'Прошивка';

  @override
  String get deviceFieldBattery => 'Заряд';

  @override
  String get sensorsScreenTitle => 'Проверка датчиков';

  @override
  String sensorsActiveCount(int active, int total) {
    return '$active/$total датчиков активно';
  }

  @override
  String get sensorsChecking => 'Проверка...';

  @override
  String get sensorsCheckButton => 'Проверить датчики';

  @override
  String get assessmentScreenTitle => 'Обследование';

  @override
  String get assessmentReady => 'Готов к началу';

  @override
  String get assessmentRecording => 'Запись...';

  @override
  String get assessmentPaused => 'Пауза';

  @override
  String get assessmentResume => 'Продолжить';

  @override
  String get assessmentFinish => 'Завершить';

  @override
  String get sectionMetrics => 'Показатели';

  @override
  String get sectionSensors => 'Датчики';

  @override
  String sensorsConnectedCount(int connected, int total) {
    return '$connected/$total подключено';
  }

  @override
  String get metricSpeed => 'Скорость';

  @override
  String get metricCadence => 'Каденс';

  @override
  String get metricAsymmetry => 'Асимметрия';

  @override
  String get metricSteps => 'Шаги';

  @override
  String get metricQuality => 'Качество';

  @override
  String get metricLostPackets => 'Потери';

  @override
  String get chartWaitingForData => 'Ожидание данных...';

  @override
  String get aiProcessingTitle => 'Идёт AI-анализ';

  @override
  String get aiProcessingSubtitle =>
      'Пожалуйста, подождите — данные обрабатываются';

  @override
  String get aiProcessingComplete => 'Анализ завершён';

  @override
  String get aiProcessingReportReady => 'Отчёт готов';

  @override
  String get aiStepUploading => 'Загрузка данных с датчиков...';

  @override
  String get aiStepSyncing => 'Синхронизация потоков IMU и sEMG...';

  @override
  String get aiStepPreprocessing =>
      'Предобработка сигналов (полосовой фильтр)...';

  @override
  String get aiStepExtracting => 'Извлечение параметров походки...';

  @override
  String get aiStepSpatiotemporal =>
      'Расчёт пространственно-временных параметров...';

  @override
  String get aiStepSymmetry => 'Анализ индексов симметрии...';

  @override
  String get aiStepInference => 'Работа нейросетевой модели...';

  @override
  String get aiStepNormative => 'Сравнение с нормативной базой...';

  @override
  String get aiStepRisk => 'Формирование оценки риска...';

  @override
  String get aiStepReport => 'Составление медицинского отчёта...';

  @override
  String get reportScreenTitle => 'Медицинский отчёт';

  @override
  String get sectionConclusion => 'Заключение';

  @override
  String get sectionKeyObservations => 'Ключевые наблюдения';

  @override
  String get sectionRecommendations => 'Рекомендации';

  @override
  String get sectionTimeline => 'Хронология обследования';

  @override
  String get savePdfButton => 'Сохранить PDF';

  @override
  String get sendToDoctorButton => 'Отправить врачу';

  @override
  String get reportActionsSheetTitle => 'Поделиться отчётом';

  @override
  String get reportActionSend => 'Отправить врачу по почте';

  @override
  String get reportActionCopy => 'Скопировать отчёт';

  @override
  String get reportActionSavePdf => 'Сохранить PDF';

  @override
  String get reportCopiedSnackbar => 'Отчёт скопирован в буфер обмена';

  @override
  String get savePdfSnackbar => 'PDF-файл отчёта готов к сохранению';

  @override
  String get savePdfErrorSnackbar =>
      'Не удалось создать PDF. Попробуйте ещё раз.';

  @override
  String get timelineStarted => 'Начало обследования';

  @override
  String get timelineSensorCheck => 'Проверка датчиков';

  @override
  String get timelineWalkingDone => 'Завершение ходьбы';

  @override
  String get timelineUploadDone => 'Загрузка данных';

  @override
  String get timelineAnalysisDone => 'Анализ завершён';

  @override
  String get timelineReportGenerated => 'Отчёт создан';

  @override
  String get historyScreenTitle => 'История';

  @override
  String get emptyStateNoCompletedAssessments => 'Нет завершённых обследований';

  @override
  String assessmentsCountSuffix(int count) {
    return '$count обсл.';
  }

  @override
  String durationMinutesSuffix(int minutes) {
    return '$minutes мин';
  }

  @override
  String get profileScreenTitle => 'Профиль';

  @override
  String get sectionContactInfo => 'Контактная информация';

  @override
  String get sectionCertifications => 'Сертификации';

  @override
  String get statTotalVisits => 'Всего визитов';

  @override
  String get statThisMonth => 'За этот месяц';

  @override
  String get statAvgTime => 'Среднее время';

  @override
  String get statDevices => 'Устройств';

  @override
  String get unitMinutes => 'мин';

  @override
  String get fieldRole => 'Должность';

  @override
  String get editProfileSheetTitle => 'Редактировать профиль';

  @override
  String get saveButton => 'Сохранить';

  @override
  String get cancelButton => 'Отмена';

  @override
  String get settingsScreenTitle => 'Настройки';

  @override
  String get sectionAppearance => 'Оформление';

  @override
  String get sectionNotificationsHeader => 'Уведомления';

  @override
  String get sectionData => 'Данные';

  @override
  String get sectionMap => 'Карта';

  @override
  String get sectionAbout => 'О приложении';

  @override
  String get themeTileTitle => 'Тема';

  @override
  String get themeLight => 'Светлая';

  @override
  String get themeDark => 'Тёмная';

  @override
  String get themeSystem => 'Системная';

  @override
  String get languageTileTitle => 'Язык';

  @override
  String get pushNotificationsTitle => 'Push-уведомления';

  @override
  String get pushNotificationsSubtitle => 'Новые визиты и напоминания';

  @override
  String get autoSyncTitle => 'Автосинхронизация';

  @override
  String get autoSyncSubtitle => 'Синхронизация данных обследований';

  @override
  String get cacheTitle => 'Кэш данных';

  @override
  String get clearCacheButton => 'Очистить';

  @override
  String get clearCacheDialogTitle => 'Очистить кэш?';

  @override
  String get clearCacheDialogBody =>
      'Локально сохранённые данные обследований будут удалены с этого устройства.';

  @override
  String get clearCacheConfirm => 'Очистить';

  @override
  String get clearCacheSnackbar => 'Кэш очищен';

  @override
  String get darkMapTitle => 'Тёмная тема карты';

  @override
  String get darkMapSubtitle => 'Улучшает видимость маркеров';

  @override
  String get versionTitle => 'Версия';

  @override
  String get licenseTileTitle => 'Лицензионное соглашение';

  @override
  String get privacyTileTitle => 'Политика конфиденциальности';

  @override
  String get footerCopyright => '© 2024 PreDemention Inc.';

  @override
  String get licenseScreenTitle => 'Лицензионное соглашение';

  @override
  String get licenseBody =>
      '1. Общие положения\n\nИспользуя приложение PreDemention, вы соглашаетесь с настоящими условиями. Приложение предназначено для использования обученным медицинским персоналом и ассистентами при выездных обследованиях.\n\n2. Назначение и ограничения\n\nPreDemention — это инструмент скрининга походки, предназначенный для помощи в раннем выявлении признаков лёгких когнитивных нарушений. Приложение НЕ является диагностическим медицинским изделием и не заменяет консультацию врача. Результаты обследования должны интерпретироваться квалифицированным специалистом.\n\n3. Данные датчиков и биомеханические измерения\n\nВ ходе обследования приложение собирает данные с инерциальных (IMU) и электромиографических (sEMG) датчиков, а также рассчитанные на их основе показатели походки. Эти данные используются исключительно для формирования отчёта об обследовании.\n\n4. Интеллектуальная собственность\n\nВсе программное обеспечение, алгоритмы анализа и элементы интерфейса являются собственностью PreDemention Inc. и защищены законодательством об интеллектуальной собственности.\n\n5. Ограничение ответственности\n\nPreDemention Inc. не несёт ответственности за решения, принятые исключительно на основании данных приложения без участия квалифицированного медицинского специалиста.\n\n6. Контакты\n\nПо вопросам, связанным с настоящим соглашением, обращайтесь: legal@predemention.kz';

  @override
  String get privacyScreenTitle => 'Политика конфиденциальности';

  @override
  String get privacyBody =>
      '1. Какие данные мы собираем\n\nПриложение обрабатывает: данные датчиков походки (IMU/sEMG), персональные данные пациентов (ФИО, возраст, контакты, адрес), геолокацию визита, а также данные учётной записи ассистента.\n\n2. Как используются данные\n\nДанные обследования используются для формирования медицинского отчёта и оценки риска. Геолокация используется для построения маршрута до пациента и расчёта времени прибытия.\n\n3. Хранение и защита\n\nДанные обследований хранятся с использованием шифрования и доступны только авторизованному персоналу. Срок хранения определяется применимым медицинским законодательством.\n\n4. Сторонние сервисы\n\nДля отображения карт приложение использует Google Maps. При построении маршрута часть данных о местоположении передаётся сервису Google в соответствии с его политикой конфиденциальности.\n\n5. Права пациента\n\nПациент вправе запросить доступ к собранным о нём данным, их исправление или удаление, обратившись к своему лечащему учреждению.\n\n6. Контакты\n\nПо вопросам обработки персональных данных: privacy@predemention.kz';

  @override
  String get notificationsSheetTitle => 'Уведомления';

  @override
  String get notificationsDisabledState => 'Уведомления отключены в настройках';

  @override
  String get notificationsDisabledAction => 'Открыть настройки';

  @override
  String get notificationsEmptyState => 'Новых уведомлений нет';

  @override
  String notificationVisitScheduled(String name, String time) {
    return 'Визит к $name запланирован на $time';
  }

  @override
  String notificationVisitInProgress(String name) {
    return 'Идёт обследование: $name';
  }

  @override
  String notificationVisitCompleted(String name) {
    return 'Обследование завершено: $name';
  }

  @override
  String get commonClose => 'Закрыть';

  @override
  String get commonCancel => 'Отмена';

  @override
  String get commonSave => 'Сохранить';

  @override
  String get commonOk => 'Ок';
}
