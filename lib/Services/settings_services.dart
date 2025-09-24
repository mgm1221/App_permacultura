import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  static const _kIsFirstRun = 'is_first_run';
  static const _kPairedDeviceId = 'paired_device_id';
  static const _kClientId = 'client_id';
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
    _prefs!.setBool(_kIsFirstRun, _prefs!.getBool(_kIsFirstRun) ?? true);
    _prefs!.setString(_kClientId, _prefs!.getString(_kClientId) ?? '1');
  }

  static bool get isFirstRun => _prefs!.getBool(_kIsFirstRun) ?? true;

  static Future<void> markParingComplete() async {
    await _prefs!.setBool(_kIsFirstRun, false);
  }

  static Future<void> markParingNotComplete() async {
    await _prefs!.setBool(_kIsFirstRun, true);
  }
  static String? get pairedDeviceId => _prefs!.getString(_kPairedDeviceId);

  static Future<void> savePairedDeviceId(String deviceId) async {
    await _prefs!.setString(_kPairedDeviceId, deviceId);
  }

  static Future<void> clearPairedDevice() async {
    await _prefs!.remove(_kPairedDeviceId);
  }

  static Future<void> saveClientId(String uuid) async{

    await _prefs!.setString(_kClientId, uuid);
  }

  static String? get clientId => _prefs!.getString(_kClientId);

}
