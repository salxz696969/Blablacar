import 'package:blabla/week10/data/repositories/comment/comment_repository.dart';
import 'package:blabla/week10/data/repositories/comment/comment_repository_firebase.dart';
import 'package:provider/provider.dart';

import 'data/repositories/artist/artist_repository.dart';
import 'data/repositories/artist/artist_repository_firebase.dart';
import 'data/repositories/songs/song_repository_firebase.dart';
import 'main_common.dart';
import 'data/repositories/settings/app_settings_repository_mock.dart';
import 'data/repositories/songs/song_repository.dart';
import 'ui/services/song_interaction_service.dart';
import 'ui/states/settings_state.dart';

/// Configure provider dependencies for dev environment
List<InheritedProvider> get devProviders {
  final appSettingsRepository = AppSettingsRepositoryMock();

  return [
    // 1 - Inject repositories
    Provider<SongRepository>(create: (_) => SongRepositoryFirebase()),
    Provider<ArtistRepository>(create: (_) => ArtistRepositoryFirebase()),

    // 2 - Inject song interaction state/service
    ChangeNotifierProvider<SongInteractionService>(
      create: (context) => SongInteractionService(
        songRepository: context.read<SongRepository>(),
      ),
    ),

    // 3 - Inject the  app setting state
    ChangeNotifierProvider<AppSettingsState>(
      create: (_) => AppSettingsState(repository: appSettingsRepository),
    ),

    Provider<CommentRepository>(create: (_) => CommentRepositoryFirebase()),
  ];
}

void main() {
  mainCommon(devProviders);
}
