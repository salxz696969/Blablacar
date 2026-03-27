import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../model/songs/song.dart';
import '../../dtos/song_dto.dart';
import 'song_repository.dart';

class SongRepositoryFirebase extends SongRepository {
  final Uri songsUri = Uri.https(
    'class-8804f-default-rtdb.asia-southeast1.firebasedatabase.app',
    '/songs.json',
  );

  final List<Song> _cachedSongs = [];

  @override
  Future<List<Song>> fetchSongs() async {

    if (_cachedSongs.isNotEmpty) {
      return _cachedSongs;
    }

    final http.Response response = await http.get(songsUri);

    if (response.statusCode == 200) {
      // 1 - Send the retrieved list of songs
      Map<String, dynamic> songJson = json.decode(response.body);

      List<Song> result = [];
      for (final entry in songJson.entries) {
        result.add(SongDto.fromJson(entry.key, entry.value));
      }
      return result;
    } else {
      // 2- Throw expcetion if any issue
      throw Exception('Failed to load posts');
    }
  }

  @override
  Future<Song> likeSong(Song song) async {
    final Uri songUri = Uri.https(
      'class-8804f-default-rtdb.asia-southeast1.firebasedatabase.app',
      '/songs/${song.id}.json',
    );
    final Song updatedSong = Song(
      id: song.id,
      title: song.title,
      artistId: song.artistId,
      duration: song.duration,
      imageUrl: song.imageUrl,
      like: song.like + 1,
    );
    final http.Response response = await http.patch(
      songUri,
      body: json.encode(SongDto().toJson(updatedSong)),
    );

    Map<String, dynamic> songJson = json.decode(response.body);
    return SongDto.fromJson(song.id, songJson);
  }

  @override
  Future<Song> unlikeSong(Song song) async {
    final Uri songUri = Uri.https(
      'class-8804f-default-rtdb.asia-southeast1.firebasedatabase.app',
      '/songs/${song.id}.json',
    );
    final Song updatedSong = Song(
      id: song.id,
      title: song.title,
      artistId: song.artistId,
      duration: song.duration,
      imageUrl: song.imageUrl,
      like: song.like > 0 ? song.like - 1 : 0,
    );
    final http.Response response = await http.patch(
      songUri,
      body: json.encode(SongDto().toJson(updatedSong)),
    );

    Map<String, dynamic> songJson = json.decode(response.body);
    return SongDto.fromJson(song.id, songJson);
  }

  @override
  Future<Song?> fetchSongById(String id) async {}
}
