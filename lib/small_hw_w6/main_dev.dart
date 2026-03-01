import 'package:provider/provider.dart';
import 'package:nested/nested.dart';

import 'main_common.dart';
import 'data/repositories/songs/song_repository.dart';
import 'data/repositories/songs/song_repository_mock.dart';
import 'data/repositories/app_settings/app_settings_repository.dart';
import 'data/repositories/app_settings/app_settings_repository_mock.dart';
import 'ui/states/player_state.dart';
import 'ui/states/settings_state.dart';

/// Configure provider dependencies for dev environment
List<SingleChildWidget> get devProviders {
  return [
    Provider<SongRepository>(create: (_) => SongRepositoryMock()),
    ChangeNotifierProvider<PlayerState>(create: (_) => PlayerState()),

    // App settings repository + state
    Provider<AppSettingsRepository>(create: (_) => AppSettingsRepositoryMock()),
    ChangeNotifierProvider<AppSettingsState>(
      create: (context) {
        final state = AppSettingsState(context.read<AppSettingsRepository>());
        state.init();
        return state;
      },
    ),
  ];
}

void main() {
  mainCommon(devProviders);
}
