import 'package:flutter/widgets.dart';

import '../../data/repositories/app_settings/app_settings_repository.dart';
import '../../model/settings/app_settings.dart';

class AppSettingsState extends ChangeNotifier {
  final AppSettingsRepository _repository;
  AppSettings _appSettings = AppSettings(themeColor: ThemeColor.blue);

  AppSettingsState(this._repository);

  Future<void> init() async {
    _appSettings = await _repository.load();
    notifyListeners();
  }

  ThemeColor get theme => _appSettings.themeColor;

  Future<void> changeTheme(ThemeColor themeColor) async {
    _appSettings = _appSettings.copyWith(themeColor: themeColor);
    await _repository.save(_appSettings);
    notifyListeners();
  }
}
