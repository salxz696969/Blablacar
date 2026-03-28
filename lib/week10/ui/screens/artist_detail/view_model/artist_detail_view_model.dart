import 'package:blabla/week10/data/repositories/artist/artist_repository.dart';
import 'package:blabla/week10/data/repositories/comment/comment_repository.dart';
import 'package:blabla/week10/data/repositories/songs/song_repository.dart';
import 'package:blabla/week10/model/artist/artist.dart';
import 'package:blabla/week10/model/comment/comment.dart';
import 'package:blabla/week10/model/songs/song.dart';
import 'package:blabla/week10/ui/screens/artist_detail/view_model/artist_detail.dart';
import 'package:blabla/week10/ui/services/song_interaction_service.dart';
import 'package:blabla/week10/ui/utils/async_value.dart';
import 'package:flutter/material.dart';

class ArtistDetailViewModel extends ChangeNotifier {
  final ArtistRepository artistRepository;
  final SongRepository songRepository;
  final CommentRepository commentRepository;
  final SongInteractionService songInteractionService;
  final Artist artist;

  AsyncValue<List<ArtistDetail>> data = AsyncValue.loading();

  ArtistDetailViewModel({
    required this.artistRepository,
    required this.songRepository,
    required this.commentRepository,
    required this.songInteractionService,
    required this.artist,
  }) {
    songInteractionService.addListener(notifyListeners);
    _init();
  }

  @override
  void dispose() {
    songInteractionService.removeListener(notifyListeners);
    super.dispose();
  }

  void _init() async {
    fetchData();
  }

  void fetchData() async {
    // 1- Loading state
    data = AsyncValue.loading();
    notifyListeners();

    try {
      final songs = await songRepository.fetchSongsByArtistId(artist.id);
      final comments = await commentRepository.fetchComments(artist.id);
      data = AsyncValue.success([
        ArtistDetail(artist: artist, songs: songs, comments: comments),
      ]);
    } catch (e) {
      data = AsyncValue.error(e);
    }
    notifyListeners();
  }

  bool isSongPlaying(Song song) => songInteractionService.isSongPlaying(song);

  void start(Song song) => songInteractionService.start(song);

  void stop() => songInteractionService.stop();

  bool isSongLiked(Song song) => songInteractionService.isSongLiked(song);

  Future<void> toggleLike(Song song) async {
    final Song updatedSong = await songInteractionService.toggleLike(song);

    if (data.state == AsyncValueState.success && data.data != null) {
      final ArtistDetail current = data.data!.first;
      final List<Song> updatedSongs = current.songs
          .map((item) => item.id == song.id ? updatedSong : item)
          .toList();

      data = AsyncValue.success([
        ArtistDetail(
          artist: current.artist,
          songs: updatedSongs,
          comments: current.comments,
        ),
      ]);
    }

    notifyListeners();
  }

  Future<void> addComment(String content) async {
    if (content.trim().isEmpty) {
      return;
    }

    if (data.state != AsyncValueState.success || data.data == null) {
      return;
    }

    final Comment createdComment = await commentRepository.addComment(
      Comment(id: '', artistId: artist.id, content: content.trim()),
    );

    final ArtistDetail current = data.data!.first;
    data = AsyncValue.success([
      ArtistDetail(
        artist: current.artist,
        songs: current.songs,
        comments: [...current.comments, createdComment],
      ),
    ]);

    notifyListeners();
  }
}
