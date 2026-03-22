import 'package:blabla/firebase/data/repositories/artists/artist_repository.dart';

import '../../../model/songs/song.dart';

abstract class SongRepository {
  final ArtistRepository artistRepository;
  SongRepository({required this.artistRepository});
  Future<List<Song>> fetchSongs();

  Future<Song?> fetchSongById(String id);
}
