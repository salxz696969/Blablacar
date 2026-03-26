import 'dart:convert';

import 'package:blabla/firebase/model/artists/artist.dart';
import 'package:http/http.dart' as http;

import '../../../model/songs/song.dart';
import '../../dtos/song_dto.dart';
import 'song_repository.dart';

class SongRepositoryFirebase extends SongRepository {
  SongRepositoryFirebase({required super.artistRepository});

  final Uri songsUri = Uri.https(
    'class-8804f-default-rtdb.asia-southeast1.firebasedatabase.app',
    '/songs.json',
  );

  @override
  Future<List<Song>> fetchSongs() async {
    final http.Response response = await http.get(songsUri);

    if (response.statusCode == 200) {
      final songJson = json.decode(response.body);

      final List<Song> songs = [];

      for (var song in songJson.entries) {
        songs.add(
          SongDto.fromJson({
            "id": song.key,
            "title": song.value['title'],
            "artistId": song.value['artistId'],
            "imageUrl": song.value['imageUrl'],
            "duration": song.value['duration'],
          }),
        );
      }

      final List<Artist> artists = await artistRepository.fetchArtistByIds(
        songs.map((song) => song.artistId).toList(),
      );

      for (Song song in songs) {
        song.setArtist(
          artists.firstWhere((artist) => artist.id == song.artistId),
        );
      }
      return songs;
    } else {
      throw Exception('Failed to load songs');
    }
  }

  @override
  Future<Song?> fetchSongById(String id) async {}
}
