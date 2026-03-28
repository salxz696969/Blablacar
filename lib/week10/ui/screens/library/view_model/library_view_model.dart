import 'package:blabla/week10/model/songs/song_detail.dart';
import 'package:flutter/material.dart';
import '../../../../data/repositories/artist/artist_repository.dart';
import '../../../../data/repositories/songs/song_repository.dart';
import '../../../../model/artist/artist.dart';
import '../../../../model/songs/song.dart';
import '../../../services/song_interaction_service.dart';
import '../../../utils/async_value.dart';

class LibraryViewModel extends ChangeNotifier {
  final SongRepository songRepository;
  final ArtistRepository artistRepository;
  final SongInteractionService songInteractionService;

  AsyncValue<List<SongDetail>> data = AsyncValue.loading();

  LibraryViewModel({
    required this.songRepository,
    required this.songInteractionService,
    required this.artistRepository,
  }) {
    songInteractionService.addListener(notifyListeners);

    // init
    _init();
  }

  @override
  void dispose() {
    songInteractionService.removeListener(notifyListeners);
    super.dispose();
  }

  void _init() async {
    fetchSong();
  }

  void fetchSong() async {
    // 1- Loading state
    data = AsyncValue.loading();
    notifyListeners();

    try {
      // 1- Fetch songs
      List<Song> songs = await songRepository.fetchSongs();

      // 2- Fethc artist
      List<Artist> artists = await artistRepository.fetchArtists();

      // 3- Create the mapping artistid-> artist
      Map<String, Artist> mapArtist = {};
      for (Artist artist in artists) {
        mapArtist[artist.id] = artist;
      }

      List<SongDetail> data = songs
          .map(
            (song) => SongDetail(song: song, artist: mapArtist[song.artistId]!),
          )
          .toList();

      this.data = AsyncValue.success(data);
    } catch (e) {
      // 3- Fetch is unsucessfull
      data = AsyncValue.error(e);
    }
    notifyListeners();
  }

  bool isSongPlaying(Song song) => songInteractionService.isSongPlaying(song);

  void start(Song song) => songInteractionService.start(song);
  void stop(Song song) => songInteractionService.stop();

  bool isSongLiked(Song song) => songInteractionService.isSongLiked(song);

  Future<void> toggleLike(Song song) async {
    final Song updatedSong = await songInteractionService.toggleLike(song);

    if (data.state == AsyncValueState.success && data.data != null) {
      final List<SongDetail> updatedItems = [];
      for (final item in data.data!) {
        if (item.song.id == song.id) {
          updatedItems.add(SongDetail(song: updatedSong, artist: item.artist));
        } else {
          updatedItems.add(item);
        }
      }

      data = AsyncValue.success(updatedItems);
    }

    notifyListeners();
  }
}
