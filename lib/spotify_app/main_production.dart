import 'package:blabcar/spotify_app/data/repositories/songs/song_repository_remote.dart';
import 'package:provider/provider.dart';

import 'data/repositories/songs/song_repository.dart';
import 'main_common.dart';

/// Configure provider dependencies for dev environement
List<Provider> get providersRemote {
  return [Provider<SongRepository>(create: (context) => SongRepositoryRemote())];
}

void main() {
  mainCommon(providersRemote);
}
