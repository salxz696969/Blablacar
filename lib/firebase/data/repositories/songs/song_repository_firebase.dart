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

  @override
  Future<List<Song>> fetchSongs() async {
    final http.Response response = await http.get(songsUri);

    if (response.statusCode == 200) {
      final songJson = json.decode(response.body);

      final List<Song> songs = songJson.entries.map<Song>((item) {
        return SongDto.fromJson({
          "id": item.key,
          "title": item.value['title'],
          "artistId": item.value['artistId'],
          "imageUrl": item.value['imageUrl'],
          "duration": item.value['duration'],
        });
      }).toList();

      return songs;
    } else {
      throw Exception('Failed to load songs');
    }
  }

  @override
  Future<Song?> fetchSongById(String id) async {}
}