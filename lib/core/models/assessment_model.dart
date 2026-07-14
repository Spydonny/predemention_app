class AssessmentModel {
  final String id;
  final String visitId;
  final String patientId;
  final DateTime startTime;
  final DateTime endTime;
  final int durationSeconds;
  final AssessmentResults results;
  final String reportId;
  final String status; // 'in_progress', 'processing', 'completed'

  const AssessmentModel({
    required this.id,
    required this.visitId,
    required this.patientId,
    required this.startTime,
    required this.endTime,
    required this.durationSeconds,
    required this.results,
    required this.reportId,
    required this.status,
  });
}

class AssessmentResults {
  final double riskScore;
  final double confidence;
  final double walkingSpeed;
  final double cadence;
  final double strideLength;
  final double asymmetry;
  final double stepCount;
  final double lostPackets;
  final double signalQuality;
  final List<GaitPhase> gaitPhases;
  final Map<String, List<double>> imuData;
  final Map<String, List<double>> semgData;

  const AssessmentResults({
    required this.riskScore,
    required this.confidence,
    required this.walkingSpeed,
    required this.cadence,
    required this.strideLength,
    required this.asymmetry,
    required this.stepCount,
    required this.lostPackets,
    required this.signalQuality,
    required this.gaitPhases,
    required this.imuData,
    required this.semgData,
  });
}

class GaitPhase {
  final String name;
  final double duration;
  final double percentage;

  const GaitPhase({
    required this.name,
    required this.duration,
    required this.percentage,
  });
}

/// Raw metrics captured live during an [AssessmentScreen] session, handed
/// off to the AI-processing screen so the final report reflects what was
/// actually measured instead of always showing the same fixed mock.
class AssessmentSessionData {
  final String visitId;
  final DateTime startedAt;
  final DateTime endedAt;
  final double riskScore;
  final double confidence; // 0..1
  final double walkingSpeed;
  final double cadence;
  final double asymmetry;
  final int stepCount;
  final int lostPackets;
  final double signalQuality;

  const AssessmentSessionData({
    required this.visitId,
    required this.startedAt,
    required this.endedAt,
    required this.riskScore,
    required this.confidence,
    required this.walkingSpeed,
    required this.cadence,
    required this.asymmetry,
    required this.stepCount,
    required this.lostPackets,
    required this.signalQuality,
  });
}

class ReportModel {
  final String id;
  final String assessmentId;
  final String patientId;
  final String patientName;
  final DateTime createdAt;
  final double riskScore;
  final double confidence;
  final String conclusion;
  final List<String> keyObservations;
  final List<String> recommendations;
  final Map<String, double> metrics;
  final ReportTimeline timeline;

  const ReportModel({
    required this.id,
    required this.assessmentId,
    required this.patientId,
    required this.patientName,
    required this.createdAt,
    required this.riskScore,
    required this.confidence,
    required this.conclusion,
    required this.keyObservations,
    required this.recommendations,
    required this.metrics,
    required this.timeline,
  });

  String get riskLevel {
    if (riskScore < 30) return 'Low Risk';
    if (riskScore < 60) return 'Moderate Risk';
    return 'High Risk';
  }

  String get confidenceLevel {
    if (confidence > 90) return 'Very High';
    if (confidence > 75) return 'High';
    if (confidence > 50) return 'Moderate';
    return 'Low';
  }

  static ReportModel mockReport(String patientId, String patientName, String assessmentId) {
    return ReportModel(
      id: 'RPT-$patientId-001',
      assessmentId: assessmentId,
      patientId: patientId,
      patientName: patientName,
      createdAt: DateTime.now(),
      riskScore: 42.7,
      confidence: 93.2,
      conclusion: 'Обследование походки пациента выявило умеренные отклонения от нормы, характерные для ранней стадии моторных нарушений, ассоциированных с когнитивными расстройствами. Наблюдается значимая асимметрия походки (8.4%), снижение каденса (94.2 шаг/мин) и уменьшение длины шага (1.12 м). Паттерн sEMG указывает на повышенную активность мышц-антагонистов в фазе переноса. Рекомендовано повторное обследование через 3 месяца для оценки динамики.',
      keyObservations: [
        'Асимметрия походки 8.4% — превышает нормативные значения (<5%)',
        'Каденс 94.2 шаг/мин — ниже возрастной нормы (105-115 шаг/мин)',
        'Повышенная вариабельность времени двойной опоры (коэффициент вариации 12.3%)',
        'sEMG-паттерн m. tibialis anterior: задержка активации 42 мс перед касанием пятки',
        'IMU-данные таза: компенсаторная ротация 5.7° влево',
        'Скорость ходьбы 0.92 м/с — ниже порогового значения (1.0 м/с)',
        'Количество потерянных пакетов: 3 (в допустимых пределах)',
      ],
      recommendations: [
        'Повторное обследование PreDemention через 3 месяца для отслеживания динамики',
        'Консультация невролога для комплексной оценки когнитивных функций',
        'Рекомендовать программу физической активности с фокусом на баланс и координацию (2-3 раза в неделю)',
        'Рассмотреть направление на МРТ головного мозга для исключения структурных изменений',
        'Обучение пациента и родственников признакам прогрессирования симптомов',
        'Дневник походки: вести еженедельную самооценку с использованием приложения',
        'При сохранении или ухудшении показателей — рассмотреть фармакологическую коррекцию',
      ],
      metrics: {
        'Walking Speed': 0.92,
        'Cadence': 94.2,
        'Stride Length': 1.12,
        'Asymmetry': 8.4,
        'Double Support': 28.5,
        'Stance Phase': 62.3,
        'Swing Phase': 37.7,
        'Step Count': 148.0,
        'Signal Quality': 97.1,
      },
      timeline: ReportTimeline(
        startedAt: DateTime.now().subtract(const Duration(minutes: 5)),
        sensorCheckCompleted: DateTime.now().subtract(const Duration(minutes: 4, seconds: 45)),
        walkingCompleted: DateTime.now().subtract(const Duration(minutes: 3, seconds: 15)),
        uploadCompleted: DateTime.now().subtract(const Duration(minutes: 2, seconds: 30)),
        analysisCompleted: DateTime.now().subtract(const Duration(minutes: 1)),
        reportGenerated: DateTime.now(),
      ),
    );
  }

  /// Builds a report from the metrics actually captured during a live
  /// [AssessmentSessionData] session, instead of always returning the same
  /// fixed [mockReport] numbers regardless of what happened on-screen.
  static ReportModel fromAssessment({
    required String reportId,
    required String patientId,
    required String patientName,
    required AssessmentSessionData session,
    required DateTime uploadCompleted,
    required DateTime analysisCompleted,
  }) {
    final riskScore = session.riskScore;
    final confidencePercent = session.confidence * 100;
    // stride length (m) ≈ speed (m/s) * 120 / cadence (steps/min)
    final strideLength = session.cadence > 0 ? session.walkingSpeed * 120 / session.cadence : 0.0;
    final riskDescriptor = riskScore < 30
        ? 'показатели в пределах возрастной нормы'
        : riskScore < 60
            ? 'умеренные отклонения от нормы, характерные для ранней стадии моторных нарушений'
            : 'значительные отклонения от нормы, требующие внимания специалиста';

    return ReportModel(
      id: reportId,
      assessmentId: reportId,
      patientId: patientId,
      patientName: patientName,
      createdAt: DateTime.now(),
      riskScore: riskScore,
      confidence: confidencePercent,
      conclusion:
          'Обследование походки пациента выявило $riskDescriptor. '
          'Наблюдается асимметрия походки (${session.asymmetry.toStringAsFixed(1)}%), '
          'каденс ${session.cadence.toStringAsFixed(1)} шаг/мин и скорость ходьбы '
          '${session.walkingSpeed.toStringAsFixed(2)} м/с. '
          '${riskScore >= 60 ? 'Рекомендовано срочное повторное обследование и консультация невролога.' : 'Рекомендовано повторное обследование через 3 месяца для оценки динамики.'}',
      keyObservations: [
        'Асимметрия походки ${session.asymmetry.toStringAsFixed(1)}% ${session.asymmetry > 5 ? '— превышает нормативные значения (<5%)' : '— в пределах нормы'}',
        'Каденс ${session.cadence.toStringAsFixed(1)} шаг/мин ${session.cadence < 105 ? '— ниже возрастной нормы (105-115 шаг/мин)' : '— в пределах возрастной нормы'}',
        'Скорость ходьбы ${session.walkingSpeed.toStringAsFixed(2)} м/с ${session.walkingSpeed < 1.0 ? '— ниже порогового значения (1.0 м/с)' : '— в пределах нормы'}',
        'Количество шагов за обследование: ${session.stepCount}',
        'Количество потерянных пакетов: ${session.lostPackets} ${session.lostPackets > 5 ? '— превышает допустимый предел' : '(в допустимых пределах)'}',
        'Качество сигнала: ${session.signalQuality.toStringAsFixed(1)}%',
      ],
      recommendations: [
        if (riskScore >= 60) 'Срочная консультация невролога для комплексной оценки когнитивных функций',
        'Повторное обследование PreDemention через 3 месяца для отслеживания динамики',
        'Рекомендовать программу физической активности с фокусом на баланс и координацию (2-3 раза в неделю)',
        'Обучение пациента и родственников признакам прогрессирования симптомов',
        'Дневник походки: вести еженедельную самооценку с использованием приложения',
      ],
      metrics: {
        'Walking Speed': session.walkingSpeed,
        'Cadence': session.cadence,
        'Stride Length': strideLength,
        'Asymmetry': session.asymmetry,
        'Step Count': session.stepCount.toDouble(),
        'Signal Quality': session.signalQuality,
      },
      timeline: ReportTimeline(
        startedAt: session.startedAt,
        sensorCheckCompleted: session.startedAt,
        walkingCompleted: session.endedAt,
        uploadCompleted: uploadCompleted,
        analysisCompleted: analysisCompleted,
        reportGenerated: DateTime.now(),
      ),
    );
  }
}

class ReportTimeline {
  final DateTime startedAt;
  final DateTime sensorCheckCompleted;
  final DateTime walkingCompleted;
  final DateTime uploadCompleted;
  final DateTime analysisCompleted;
  final DateTime reportGenerated;

  const ReportTimeline({
    required this.startedAt,
    required this.sensorCheckCompleted,
    required this.walkingCompleted,
    required this.uploadCompleted,
    required this.analysisCompleted,
    required this.reportGenerated,
  });

  int get totalDurationSeconds => reportGenerated.difference(startedAt).inSeconds;
  int get walkingDurationSeconds => walkingCompleted.difference(sensorCheckCompleted).inSeconds;
  int get analysisDurationSeconds => analysisCompleted.difference(uploadCompleted).inSeconds;
}
