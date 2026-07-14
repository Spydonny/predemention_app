import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_kk.dart';
import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('kk'),
    Locale('ru'),
  ];

  /// No description provided for @navHome.
  ///
  /// In ru, this message translates to:
  /// **'Главная'**
  String get navHome;

  /// No description provided for @navVisits.
  ///
  /// In ru, this message translates to:
  /// **'Визиты'**
  String get navVisits;

  /// No description provided for @navHistory.
  ///
  /// In ru, this message translates to:
  /// **'История'**
  String get navHistory;

  /// No description provided for @navProfile.
  ///
  /// In ru, this message translates to:
  /// **'Профиль'**
  String get navProfile;

  /// No description provided for @navSettings.
  ///
  /// In ru, this message translates to:
  /// **'Настройки'**
  String get navSettings;

  /// No description provided for @greetingNight.
  ///
  /// In ru, this message translates to:
  /// **'Доброй ночи'**
  String get greetingNight;

  /// No description provided for @greetingMorning.
  ///
  /// In ru, this message translates to:
  /// **'Доброе утро'**
  String get greetingMorning;

  /// No description provided for @greetingDay.
  ///
  /// In ru, this message translates to:
  /// **'Добрый день'**
  String get greetingDay;

  /// No description provided for @greetingEvening.
  ///
  /// In ru, this message translates to:
  /// **'Добрый вечер'**
  String get greetingEvening;

  /// No description provided for @appTagline.
  ///
  /// In ru, this message translates to:
  /// **'Раннее выявление. Лучшие результаты.'**
  String get appTagline;

  /// No description provided for @sectionCurrentAssessment.
  ///
  /// In ru, this message translates to:
  /// **'Текущее обследование'**
  String get sectionCurrentAssessment;

  /// No description provided for @sectionNextVisit.
  ///
  /// In ru, this message translates to:
  /// **'Ближайший визит'**
  String get sectionNextVisit;

  /// No description provided for @sectionTodayVisits.
  ///
  /// In ru, this message translates to:
  /// **'Визиты на сегодня'**
  String get sectionTodayVisits;

  /// No description provided for @sectionQuickActions.
  ///
  /// In ru, this message translates to:
  /// **'Быстрые действия'**
  String get sectionQuickActions;

  /// No description provided for @assessmentInProgressLabel.
  ///
  /// In ru, this message translates to:
  /// **'Обследование идёт'**
  String get assessmentInProgressLabel;

  /// No description provided for @quickActionNewVisit.
  ///
  /// In ru, this message translates to:
  /// **'Новый визит'**
  String get quickActionNewVisit;

  /// No description provided for @quickActionReports.
  ///
  /// In ru, this message translates to:
  /// **'Отчёты'**
  String get quickActionReports;

  /// No description provided for @quickActionDevices.
  ///
  /// In ru, this message translates to:
  /// **'Устройства'**
  String get quickActionDevices;

  /// No description provided for @statTodayLabel.
  ///
  /// In ru, this message translates to:
  /// **'Сегодня'**
  String get statTodayLabel;

  /// No description provided for @statTotalVisitsLabel.
  ///
  /// In ru, this message translates to:
  /// **'Всего визитов'**
  String get statTotalVisitsLabel;

  /// No description provided for @statRatingLabel.
  ///
  /// In ru, this message translates to:
  /// **'Рейтинг'**
  String get statRatingLabel;

  /// No description provided for @statusScheduled.
  ///
  /// In ru, this message translates to:
  /// **'Запланирован'**
  String get statusScheduled;

  /// No description provided for @statusInTransit.
  ///
  /// In ru, this message translates to:
  /// **'В пути'**
  String get statusInTransit;

  /// No description provided for @statusArriving.
  ///
  /// In ru, this message translates to:
  /// **'Прибывает'**
  String get statusArriving;

  /// No description provided for @statusInProgress.
  ///
  /// In ru, this message translates to:
  /// **'Идёт обследование'**
  String get statusInProgress;

  /// No description provided for @statusCompleted.
  ///
  /// In ru, this message translates to:
  /// **'Завершён'**
  String get statusCompleted;

  /// No description provided for @statusCancelled.
  ///
  /// In ru, this message translates to:
  /// **'Отменён'**
  String get statusCancelled;

  /// No description provided for @visitsScreenTitle.
  ///
  /// In ru, this message translates to:
  /// **'Мои визиты'**
  String get visitsScreenTitle;

  /// No description provided for @searchHintNameOrCity.
  ///
  /// In ru, this message translates to:
  /// **'Поиск по имени или городу...'**
  String get searchHintNameOrCity;

  /// No description provided for @filterAll.
  ///
  /// In ru, this message translates to:
  /// **'Все'**
  String get filterAll;

  /// No description provided for @sectionPatient.
  ///
  /// In ru, this message translates to:
  /// **'Пациент'**
  String get sectionPatient;

  /// No description provided for @sectionContacts.
  ///
  /// In ru, this message translates to:
  /// **'Контакты'**
  String get sectionContacts;

  /// No description provided for @sectionNotes.
  ///
  /// In ru, this message translates to:
  /// **'Заметки'**
  String get sectionNotes;

  /// No description provided for @sectionConditions.
  ///
  /// In ru, this message translates to:
  /// **'Диагнозы'**
  String get sectionConditions;

  /// No description provided for @visitNotFound.
  ///
  /// In ru, this message translates to:
  /// **'Визит не найден'**
  String get visitNotFound;

  /// No description provided for @startAssessmentButton.
  ///
  /// In ru, this message translates to:
  /// **'Начать обследование'**
  String get startAssessmentButton;

  /// No description provided for @continueAssessmentButton.
  ///
  /// In ru, this message translates to:
  /// **'Продолжить обследование'**
  String get continueAssessmentButton;

  /// No description provided for @buildRouteButton.
  ///
  /// In ru, this message translates to:
  /// **'Построить маршрут'**
  String get buildRouteButton;

  /// No description provided for @distanceKmLabel.
  ///
  /// In ru, this message translates to:
  /// **'{km} км'**
  String distanceKmLabel(String km);

  /// No description provided for @etaMinutesLabel.
  ///
  /// In ru, this message translates to:
  /// **'~{minutes} мин'**
  String etaMinutesLabel(int minutes);

  /// No description provided for @mapYouAreHere.
  ///
  /// In ru, this message translates to:
  /// **'Вы здесь'**
  String get mapYouAreHere;

  /// No description provided for @fieldFullName.
  ///
  /// In ru, this message translates to:
  /// **'ФИО'**
  String get fieldFullName;

  /// No description provided for @fieldAge.
  ///
  /// In ru, this message translates to:
  /// **'Возраст'**
  String get fieldAge;

  /// No description provided for @fieldAgeValue.
  ///
  /// In ru, this message translates to:
  /// **'{age} лет ({gender})'**
  String fieldAgeValue(int age, String gender);

  /// No description provided for @genderMale.
  ///
  /// In ru, this message translates to:
  /// **'Муж.'**
  String get genderMale;

  /// No description provided for @genderFemale.
  ///
  /// In ru, this message translates to:
  /// **'Жен.'**
  String get genderFemale;

  /// No description provided for @fieldAddress.
  ///
  /// In ru, this message translates to:
  /// **'Адрес'**
  String get fieldAddress;

  /// No description provided for @fieldRegistered.
  ///
  /// In ru, this message translates to:
  /// **'Зарегистрирован'**
  String get fieldRegistered;

  /// No description provided for @fieldPhone.
  ///
  /// In ru, this message translates to:
  /// **'Телефон'**
  String get fieldPhone;

  /// No description provided for @fieldEmail.
  ///
  /// In ru, this message translates to:
  /// **'Email'**
  String get fieldEmail;

  /// No description provided for @fieldCity.
  ///
  /// In ru, this message translates to:
  /// **'Город'**
  String get fieldCity;

  /// No description provided for @fieldEmergencyContact.
  ///
  /// In ru, this message translates to:
  /// **'Экстренный контакт'**
  String get fieldEmergencyContact;

  /// No description provided for @moreMenuTitle.
  ///
  /// In ru, this message translates to:
  /// **'Действия'**
  String get moreMenuTitle;

  /// No description provided for @moreMenuCallPatient.
  ///
  /// In ru, this message translates to:
  /// **'Позвонить пациенту'**
  String get moreMenuCallPatient;

  /// No description provided for @moreMenuEmailPatient.
  ///
  /// In ru, this message translates to:
  /// **'Написать на почту'**
  String get moreMenuEmailPatient;

  /// No description provided for @moreMenuCallEmergencyContact.
  ///
  /// In ru, this message translates to:
  /// **'Позвонить: {name}'**
  String moreMenuCallEmergencyContact(String name);

  /// No description provided for @deviceScreenTitle.
  ///
  /// In ru, this message translates to:
  /// **'Подключение устройства'**
  String get deviceScreenTitle;

  /// No description provided for @deviceSearching.
  ///
  /// In ru, this message translates to:
  /// **'Поиск устройств...'**
  String get deviceSearching;

  /// No description provided for @deviceConnected.
  ///
  /// In ru, this message translates to:
  /// **'Подключено'**
  String get deviceConnected;

  /// No description provided for @deviceChooseDevice.
  ///
  /// In ru, this message translates to:
  /// **'Выберите устройство'**
  String get deviceChooseDevice;

  /// No description provided for @deviceScanning.
  ///
  /// In ru, this message translates to:
  /// **'Сканирование...'**
  String get deviceScanning;

  /// No description provided for @deviceConnectedTitle.
  ///
  /// In ru, this message translates to:
  /// **'Устройство подключено'**
  String get deviceConnectedTitle;

  /// No description provided for @deviceGoingToSensors.
  ///
  /// In ru, this message translates to:
  /// **'Переход к проверке датчиков...'**
  String get deviceGoingToSensors;

  /// No description provided for @deviceFieldDevice.
  ///
  /// In ru, this message translates to:
  /// **'Устройство'**
  String get deviceFieldDevice;

  /// No description provided for @deviceFieldSerial.
  ///
  /// In ru, this message translates to:
  /// **'Серийный номер'**
  String get deviceFieldSerial;

  /// No description provided for @deviceFieldFirmware.
  ///
  /// In ru, this message translates to:
  /// **'Прошивка'**
  String get deviceFieldFirmware;

  /// No description provided for @deviceFieldBattery.
  ///
  /// In ru, this message translates to:
  /// **'Заряд'**
  String get deviceFieldBattery;

  /// No description provided for @sensorsScreenTitle.
  ///
  /// In ru, this message translates to:
  /// **'Проверка датчиков'**
  String get sensorsScreenTitle;

  /// No description provided for @sensorsActiveCount.
  ///
  /// In ru, this message translates to:
  /// **'{active}/{total} датчиков активно'**
  String sensorsActiveCount(int active, int total);

  /// No description provided for @sensorsChecking.
  ///
  /// In ru, this message translates to:
  /// **'Проверка...'**
  String get sensorsChecking;

  /// No description provided for @sensorsCheckButton.
  ///
  /// In ru, this message translates to:
  /// **'Проверить датчики'**
  String get sensorsCheckButton;

  /// No description provided for @assessmentScreenTitle.
  ///
  /// In ru, this message translates to:
  /// **'Обследование'**
  String get assessmentScreenTitle;

  /// No description provided for @assessmentReady.
  ///
  /// In ru, this message translates to:
  /// **'Готов к началу'**
  String get assessmentReady;

  /// No description provided for @assessmentRecording.
  ///
  /// In ru, this message translates to:
  /// **'Запись...'**
  String get assessmentRecording;

  /// No description provided for @assessmentPaused.
  ///
  /// In ru, this message translates to:
  /// **'Пауза'**
  String get assessmentPaused;

  /// No description provided for @assessmentResume.
  ///
  /// In ru, this message translates to:
  /// **'Продолжить'**
  String get assessmentResume;

  /// No description provided for @assessmentFinish.
  ///
  /// In ru, this message translates to:
  /// **'Завершить'**
  String get assessmentFinish;

  /// No description provided for @sectionMetrics.
  ///
  /// In ru, this message translates to:
  /// **'Показатели'**
  String get sectionMetrics;

  /// No description provided for @sectionSensors.
  ///
  /// In ru, this message translates to:
  /// **'Датчики'**
  String get sectionSensors;

  /// No description provided for @sensorsConnectedCount.
  ///
  /// In ru, this message translates to:
  /// **'{connected}/{total} подключено'**
  String sensorsConnectedCount(int connected, int total);

  /// No description provided for @metricSpeed.
  ///
  /// In ru, this message translates to:
  /// **'Скорость'**
  String get metricSpeed;

  /// No description provided for @metricCadence.
  ///
  /// In ru, this message translates to:
  /// **'Каденс'**
  String get metricCadence;

  /// No description provided for @metricAsymmetry.
  ///
  /// In ru, this message translates to:
  /// **'Асимметрия'**
  String get metricAsymmetry;

  /// No description provided for @metricSteps.
  ///
  /// In ru, this message translates to:
  /// **'Шаги'**
  String get metricSteps;

  /// No description provided for @metricQuality.
  ///
  /// In ru, this message translates to:
  /// **'Качество'**
  String get metricQuality;

  /// No description provided for @metricLostPackets.
  ///
  /// In ru, this message translates to:
  /// **'Потери'**
  String get metricLostPackets;

  /// No description provided for @chartWaitingForData.
  ///
  /// In ru, this message translates to:
  /// **'Ожидание данных...'**
  String get chartWaitingForData;

  /// No description provided for @aiProcessingTitle.
  ///
  /// In ru, this message translates to:
  /// **'Идёт AI-анализ'**
  String get aiProcessingTitle;

  /// No description provided for @aiProcessingSubtitle.
  ///
  /// In ru, this message translates to:
  /// **'Пожалуйста, подождите — данные обрабатываются'**
  String get aiProcessingSubtitle;

  /// No description provided for @aiProcessingComplete.
  ///
  /// In ru, this message translates to:
  /// **'Анализ завершён'**
  String get aiProcessingComplete;

  /// No description provided for @aiProcessingReportReady.
  ///
  /// In ru, this message translates to:
  /// **'Отчёт готов'**
  String get aiProcessingReportReady;

  /// No description provided for @aiStepUploading.
  ///
  /// In ru, this message translates to:
  /// **'Загрузка данных с датчиков...'**
  String get aiStepUploading;

  /// No description provided for @aiStepSyncing.
  ///
  /// In ru, this message translates to:
  /// **'Синхронизация потоков IMU и sEMG...'**
  String get aiStepSyncing;

  /// No description provided for @aiStepPreprocessing.
  ///
  /// In ru, this message translates to:
  /// **'Предобработка сигналов (полосовой фильтр)...'**
  String get aiStepPreprocessing;

  /// No description provided for @aiStepExtracting.
  ///
  /// In ru, this message translates to:
  /// **'Извлечение параметров походки...'**
  String get aiStepExtracting;

  /// No description provided for @aiStepSpatiotemporal.
  ///
  /// In ru, this message translates to:
  /// **'Расчёт пространственно-временных параметров...'**
  String get aiStepSpatiotemporal;

  /// No description provided for @aiStepSymmetry.
  ///
  /// In ru, this message translates to:
  /// **'Анализ индексов симметрии...'**
  String get aiStepSymmetry;

  /// No description provided for @aiStepInference.
  ///
  /// In ru, this message translates to:
  /// **'Работа нейросетевой модели...'**
  String get aiStepInference;

  /// No description provided for @aiStepNormative.
  ///
  /// In ru, this message translates to:
  /// **'Сравнение с нормативной базой...'**
  String get aiStepNormative;

  /// No description provided for @aiStepRisk.
  ///
  /// In ru, this message translates to:
  /// **'Формирование оценки риска...'**
  String get aiStepRisk;

  /// No description provided for @aiStepReport.
  ///
  /// In ru, this message translates to:
  /// **'Составление медицинского отчёта...'**
  String get aiStepReport;

  /// No description provided for @reportScreenTitle.
  ///
  /// In ru, this message translates to:
  /// **'Медицинский отчёт'**
  String get reportScreenTitle;

  /// No description provided for @sectionConclusion.
  ///
  /// In ru, this message translates to:
  /// **'Заключение'**
  String get sectionConclusion;

  /// No description provided for @sectionKeyObservations.
  ///
  /// In ru, this message translates to:
  /// **'Ключевые наблюдения'**
  String get sectionKeyObservations;

  /// No description provided for @sectionRecommendations.
  ///
  /// In ru, this message translates to:
  /// **'Рекомендации'**
  String get sectionRecommendations;

  /// No description provided for @sectionTimeline.
  ///
  /// In ru, this message translates to:
  /// **'Хронология обследования'**
  String get sectionTimeline;

  /// No description provided for @savePdfButton.
  ///
  /// In ru, this message translates to:
  /// **'Сохранить PDF'**
  String get savePdfButton;

  /// No description provided for @sendToDoctorButton.
  ///
  /// In ru, this message translates to:
  /// **'Отправить врачу'**
  String get sendToDoctorButton;

  /// No description provided for @reportActionsSheetTitle.
  ///
  /// In ru, this message translates to:
  /// **'Поделиться отчётом'**
  String get reportActionsSheetTitle;

  /// No description provided for @reportActionSend.
  ///
  /// In ru, this message translates to:
  /// **'Отправить врачу по почте'**
  String get reportActionSend;

  /// No description provided for @reportActionCopy.
  ///
  /// In ru, this message translates to:
  /// **'Скопировать отчёт'**
  String get reportActionCopy;

  /// No description provided for @reportCopiedSnackbar.
  ///
  /// In ru, this message translates to:
  /// **'Отчёт скопирован в буфер обмена'**
  String get reportCopiedSnackbar;

  /// No description provided for @savePdfSnackbar.
  ///
  /// In ru, this message translates to:
  /// **'Отчёт скопирован как текст — вставьте его в заметки или документ, чтобы сохранить как файл'**
  String get savePdfSnackbar;

  /// No description provided for @timelineStarted.
  ///
  /// In ru, this message translates to:
  /// **'Начало обследования'**
  String get timelineStarted;

  /// No description provided for @timelineSensorCheck.
  ///
  /// In ru, this message translates to:
  /// **'Проверка датчиков'**
  String get timelineSensorCheck;

  /// No description provided for @timelineWalkingDone.
  ///
  /// In ru, this message translates to:
  /// **'Завершение ходьбы'**
  String get timelineWalkingDone;

  /// No description provided for @timelineUploadDone.
  ///
  /// In ru, this message translates to:
  /// **'Загрузка данных'**
  String get timelineUploadDone;

  /// No description provided for @timelineAnalysisDone.
  ///
  /// In ru, this message translates to:
  /// **'Анализ завершён'**
  String get timelineAnalysisDone;

  /// No description provided for @timelineReportGenerated.
  ///
  /// In ru, this message translates to:
  /// **'Отчёт создан'**
  String get timelineReportGenerated;

  /// No description provided for @historyScreenTitle.
  ///
  /// In ru, this message translates to:
  /// **'История'**
  String get historyScreenTitle;

  /// No description provided for @emptyStateNoCompletedAssessments.
  ///
  /// In ru, this message translates to:
  /// **'Нет завершённых обследований'**
  String get emptyStateNoCompletedAssessments;

  /// No description provided for @assessmentsCountSuffix.
  ///
  /// In ru, this message translates to:
  /// **'{count} обсл.'**
  String assessmentsCountSuffix(int count);

  /// No description provided for @durationMinutesSuffix.
  ///
  /// In ru, this message translates to:
  /// **'{minutes} мин'**
  String durationMinutesSuffix(int minutes);

  /// No description provided for @profileScreenTitle.
  ///
  /// In ru, this message translates to:
  /// **'Профиль'**
  String get profileScreenTitle;

  /// No description provided for @sectionContactInfo.
  ///
  /// In ru, this message translates to:
  /// **'Контактная информация'**
  String get sectionContactInfo;

  /// No description provided for @sectionCertifications.
  ///
  /// In ru, this message translates to:
  /// **'Сертификации'**
  String get sectionCertifications;

  /// No description provided for @statTotalVisits.
  ///
  /// In ru, this message translates to:
  /// **'Всего визитов'**
  String get statTotalVisits;

  /// No description provided for @statThisMonth.
  ///
  /// In ru, this message translates to:
  /// **'За этот месяц'**
  String get statThisMonth;

  /// No description provided for @statAvgTime.
  ///
  /// In ru, this message translates to:
  /// **'Среднее время'**
  String get statAvgTime;

  /// No description provided for @statDevices.
  ///
  /// In ru, this message translates to:
  /// **'Устройств'**
  String get statDevices;

  /// No description provided for @unitMinutes.
  ///
  /// In ru, this message translates to:
  /// **'мин'**
  String get unitMinutes;

  /// No description provided for @fieldRole.
  ///
  /// In ru, this message translates to:
  /// **'Должность'**
  String get fieldRole;

  /// No description provided for @editProfileSheetTitle.
  ///
  /// In ru, this message translates to:
  /// **'Редактировать профиль'**
  String get editProfileSheetTitle;

  /// No description provided for @saveButton.
  ///
  /// In ru, this message translates to:
  /// **'Сохранить'**
  String get saveButton;

  /// No description provided for @cancelButton.
  ///
  /// In ru, this message translates to:
  /// **'Отмена'**
  String get cancelButton;

  /// No description provided for @settingsScreenTitle.
  ///
  /// In ru, this message translates to:
  /// **'Настройки'**
  String get settingsScreenTitle;

  /// No description provided for @sectionAppearance.
  ///
  /// In ru, this message translates to:
  /// **'Оформление'**
  String get sectionAppearance;

  /// No description provided for @sectionNotificationsHeader.
  ///
  /// In ru, this message translates to:
  /// **'Уведомления'**
  String get sectionNotificationsHeader;

  /// No description provided for @sectionData.
  ///
  /// In ru, this message translates to:
  /// **'Данные'**
  String get sectionData;

  /// No description provided for @sectionMap.
  ///
  /// In ru, this message translates to:
  /// **'Карта'**
  String get sectionMap;

  /// No description provided for @sectionAbout.
  ///
  /// In ru, this message translates to:
  /// **'О приложении'**
  String get sectionAbout;

  /// No description provided for @themeTileTitle.
  ///
  /// In ru, this message translates to:
  /// **'Тема'**
  String get themeTileTitle;

  /// No description provided for @themeLight.
  ///
  /// In ru, this message translates to:
  /// **'Светлая'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In ru, this message translates to:
  /// **'Тёмная'**
  String get themeDark;

  /// No description provided for @themeSystem.
  ///
  /// In ru, this message translates to:
  /// **'Системная'**
  String get themeSystem;

  /// No description provided for @languageTileTitle.
  ///
  /// In ru, this message translates to:
  /// **'Язык'**
  String get languageTileTitle;

  /// No description provided for @pushNotificationsTitle.
  ///
  /// In ru, this message translates to:
  /// **'Push-уведомления'**
  String get pushNotificationsTitle;

  /// No description provided for @pushNotificationsSubtitle.
  ///
  /// In ru, this message translates to:
  /// **'Новые визиты и напоминания'**
  String get pushNotificationsSubtitle;

  /// No description provided for @autoSyncTitle.
  ///
  /// In ru, this message translates to:
  /// **'Автосинхронизация'**
  String get autoSyncTitle;

  /// No description provided for @autoSyncSubtitle.
  ///
  /// In ru, this message translates to:
  /// **'Синхронизация данных обследований'**
  String get autoSyncSubtitle;

  /// No description provided for @cacheTitle.
  ///
  /// In ru, this message translates to:
  /// **'Кэш данных'**
  String get cacheTitle;

  /// No description provided for @clearCacheButton.
  ///
  /// In ru, this message translates to:
  /// **'Очистить'**
  String get clearCacheButton;

  /// No description provided for @clearCacheDialogTitle.
  ///
  /// In ru, this message translates to:
  /// **'Очистить кэш?'**
  String get clearCacheDialogTitle;

  /// No description provided for @clearCacheDialogBody.
  ///
  /// In ru, this message translates to:
  /// **'Локально сохранённые данные обследований будут удалены с этого устройства.'**
  String get clearCacheDialogBody;

  /// No description provided for @clearCacheConfirm.
  ///
  /// In ru, this message translates to:
  /// **'Очистить'**
  String get clearCacheConfirm;

  /// No description provided for @clearCacheSnackbar.
  ///
  /// In ru, this message translates to:
  /// **'Кэш очищен'**
  String get clearCacheSnackbar;

  /// No description provided for @darkMapTitle.
  ///
  /// In ru, this message translates to:
  /// **'Тёмная тема карты'**
  String get darkMapTitle;

  /// No description provided for @darkMapSubtitle.
  ///
  /// In ru, this message translates to:
  /// **'Улучшает видимость маркеров'**
  String get darkMapSubtitle;

  /// No description provided for @versionTitle.
  ///
  /// In ru, this message translates to:
  /// **'Версия'**
  String get versionTitle;

  /// No description provided for @licenseTileTitle.
  ///
  /// In ru, this message translates to:
  /// **'Лицензионное соглашение'**
  String get licenseTileTitle;

  /// No description provided for @privacyTileTitle.
  ///
  /// In ru, this message translates to:
  /// **'Политика конфиденциальности'**
  String get privacyTileTitle;

  /// No description provided for @footerCopyright.
  ///
  /// In ru, this message translates to:
  /// **'© 2024 PreDemention Inc.'**
  String get footerCopyright;

  /// No description provided for @licenseScreenTitle.
  ///
  /// In ru, this message translates to:
  /// **'Лицензионное соглашение'**
  String get licenseScreenTitle;

  /// No description provided for @licenseBody.
  ///
  /// In ru, this message translates to:
  /// **'1. Общие положения\n\nИспользуя приложение PreDemention, вы соглашаетесь с настоящими условиями. Приложение предназначено для использования обученным медицинским персоналом и ассистентами при выездных обследованиях.\n\n2. Назначение и ограничения\n\nPreDemention — это инструмент скрининга походки, предназначенный для помощи в раннем выявлении признаков лёгких когнитивных нарушений. Приложение НЕ является диагностическим медицинским изделием и не заменяет консультацию врача. Результаты обследования должны интерпретироваться квалифицированным специалистом.\n\n3. Данные датчиков и биомеханические измерения\n\nВ ходе обследования приложение собирает данные с инерциальных (IMU) и электромиографических (sEMG) датчиков, а также рассчитанные на их основе показатели походки. Эти данные используются исключительно для формирования отчёта об обследовании.\n\n4. Интеллектуальная собственность\n\nВсе программное обеспечение, алгоритмы анализа и элементы интерфейса являются собственностью PreDemention Inc. и защищены законодательством об интеллектуальной собственности.\n\n5. Ограничение ответственности\n\nPreDemention Inc. не несёт ответственности за решения, принятые исключительно на основании данных приложения без участия квалифицированного медицинского специалиста.\n\n6. Контакты\n\nПо вопросам, связанным с настоящим соглашением, обращайтесь: legal@predemention.kz'**
  String get licenseBody;

  /// No description provided for @privacyScreenTitle.
  ///
  /// In ru, this message translates to:
  /// **'Политика конфиденциальности'**
  String get privacyScreenTitle;

  /// No description provided for @privacyBody.
  ///
  /// In ru, this message translates to:
  /// **'1. Какие данные мы собираем\n\nПриложение обрабатывает: данные датчиков походки (IMU/sEMG), персональные данные пациентов (ФИО, возраст, контакты, адрес), геолокацию визита, а также данные учётной записи ассистента.\n\n2. Как используются данные\n\nДанные обследования используются для формирования медицинского отчёта и оценки риска. Геолокация используется для построения маршрута до пациента и расчёта времени прибытия.\n\n3. Хранение и защита\n\nДанные обследований хранятся с использованием шифрования и доступны только авторизованному персоналу. Срок хранения определяется применимым медицинским законодательством.\n\n4. Сторонние сервисы\n\nДля отображения карт приложение использует Google Maps. При построении маршрута часть данных о местоположении передаётся сервису Google в соответствии с его политикой конфиденциальности.\n\n5. Права пациента\n\nПациент вправе запросить доступ к собранным о нём данным, их исправление или удаление, обратившись к своему лечащему учреждению.\n\n6. Контакты\n\nПо вопросам обработки персональных данных: privacy@predemention.kz'**
  String get privacyBody;

  /// No description provided for @notificationsSheetTitle.
  ///
  /// In ru, this message translates to:
  /// **'Уведомления'**
  String get notificationsSheetTitle;

  /// No description provided for @notificationsDisabledState.
  ///
  /// In ru, this message translates to:
  /// **'Уведомления отключены в настройках'**
  String get notificationsDisabledState;

  /// No description provided for @notificationsDisabledAction.
  ///
  /// In ru, this message translates to:
  /// **'Открыть настройки'**
  String get notificationsDisabledAction;

  /// No description provided for @notificationsEmptyState.
  ///
  /// In ru, this message translates to:
  /// **'Новых уведомлений нет'**
  String get notificationsEmptyState;

  /// No description provided for @notificationVisitScheduled.
  ///
  /// In ru, this message translates to:
  /// **'Визит к {name} запланирован на {time}'**
  String notificationVisitScheduled(String name, String time);

  /// No description provided for @notificationVisitInProgress.
  ///
  /// In ru, this message translates to:
  /// **'Идёт обследование: {name}'**
  String notificationVisitInProgress(String name);

  /// No description provided for @notificationVisitCompleted.
  ///
  /// In ru, this message translates to:
  /// **'Обследование завершено: {name}'**
  String notificationVisitCompleted(String name);

  /// No description provided for @commonClose.
  ///
  /// In ru, this message translates to:
  /// **'Закрыть'**
  String get commonClose;

  /// No description provided for @commonCancel.
  ///
  /// In ru, this message translates to:
  /// **'Отмена'**
  String get commonCancel;

  /// No description provided for @commonSave.
  ///
  /// In ru, this message translates to:
  /// **'Сохранить'**
  String get commonSave;

  /// No description provided for @commonOk.
  ///
  /// In ru, this message translates to:
  /// **'Ок'**
  String get commonOk;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'kk', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'kk':
      return AppLocalizationsKk();
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
