import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/device_model.dart';
import 'settings_provider.dart' show sharedPreferencesProvider;

const _kPhone = 'assistant.phone';
const _kEmail = 'assistant.email';
const _kCity = 'assistant.city';

class AssistantProfileController extends StateNotifier<AssistantModel> {
  AssistantProfileController(this._prefs) : super(_load(_prefs));
  final SharedPreferences _prefs;

  static AssistantModel _load(SharedPreferences p) => AssistantModel.mock.copyWith(
        phone: p.getString(_kPhone),
        email: p.getString(_kEmail),
        city: p.getString(_kCity),
      );

  Future<void> updateContact({String? phone, String? email, String? city}) async {
    state = state.copyWith(phone: phone, email: email, city: city);
    if (phone != null) await _prefs.setString(_kPhone, phone);
    if (email != null) await _prefs.setString(_kEmail, email);
    if (city != null) await _prefs.setString(_kCity, city);
  }
}

final assistantProfileProvider = StateNotifierProvider<AssistantProfileController, AssistantModel>(
  (ref) => AssistantProfileController(ref.watch(sharedPreferencesProvider)),
);
