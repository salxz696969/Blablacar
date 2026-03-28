import '../../../model/songs/song.dart';

abstract class SongRepository {
  Future<List<Song>> fetchSongs();
  Future<Song> likeSong(Song song);
  Future<Song> unlikeSong(Song song);
  Future<Song?> fetchSongById(String id);
  Future<List<Song>> fetchSongsByArtistId(String artistId);
}
