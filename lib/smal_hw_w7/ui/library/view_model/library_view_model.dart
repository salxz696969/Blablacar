import 'package:flutter/foundation.dart';

import '../../../data/repositories/songs/song_repository.dart';
import '../../../model/songs/song.dart';
import '../../states/player_state.dart';

class LibraryViewModel extends ChangeNotifier {
  final SongRepository songRepository;
  final PlayerState playerState;

  List<Song> _songs = [];
  bool _initialized = false;

  LibraryViewModel({required this.songRepository, required this.playerState});

  List<Song> get songs => _songs;
  Song? get currentSong => playerState.currentSong;

  void init() {
    if (_initialized) return;

    _songs = songRepository.fetchSongs();
    _initialized = true;
    playerState.addListener(notifyListeners);

    notifyListeners();
  }

  bool isPlaying(Song song) {
    return currentSong?.id == song.id;
  }

  void onSongTap(Song song) {
    if (isPlaying(song)) {
      playerState.stop();
    } else {
      playerState.start(song);
    }
  }

  @override
  void dispose() {
    playerState.removeListener(notifyListeners);
    super.dispose();
  }
}
