import 'package:flutter/material.dart';

import '../../data/repositories/songs/song_repository.dart';
import '../../model/songs/song.dart';

class SongInteractionService extends ChangeNotifier {
  SongInteractionService({required this.songRepository});

  final SongRepository songRepository;

  Song? _currentSong;
  final Set<String> _likedSongIds = <String>{};

  Song? get currentSong => _currentSong;

  bool isSongPlaying(Song song) => _currentSong == song;

  void start(Song song) {
    _currentSong = song;
    notifyListeners();
  }

  void stop() {
    _currentSong = null;
    notifyListeners();
  }

  bool isSongLiked(Song song) => _likedSongIds.contains(song.id);

  Future<Song> toggleLike(Song song) async {
    final bool wasLiked = _likedSongIds.contains(song.id);
    final Song updatedSong = wasLiked
        ? await songRepository.unlikeSong(song)
        : await songRepository.likeSong(song);

    if (wasLiked) {
      _likedSongIds.remove(song.id);
    } else {
      _likedSongIds.add(song.id);
    }

    notifyListeners();
    return updatedSong;
  }
}
