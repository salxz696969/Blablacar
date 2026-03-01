import 'package:blabcar/small_hw_w6/model/settings/app_settings.dart';
import 'package:blabcar/small_hw_w6/data/repositories/app_settings/app_settings_repository.dart';

class AppSettingsRepositoryMock implements AppSettingsRepository {
  AppSettings _settings = AppSettings(themeColor: ThemeColor.blue);

  @override
  Future<AppSettings> load() async {
    return _settings;
  }

  @override
  Future<void> save(AppSettings settings) async {
    _settings = settings;
  }
}
