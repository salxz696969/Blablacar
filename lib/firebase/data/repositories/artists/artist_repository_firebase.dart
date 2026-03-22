import 'dart:convert';

import 'package:blabla/firebase/data/dtos/artist_dto.dart';
import 'package:blabla/firebase/data/repositories/artists/artist_repository.dart';
import 'package:blabla/firebase/model/artists/artist.dart';
import 'package:http/http.dart' as http;

class ArtistRepositoryFirebase extends ArtistRepository {
  final Uri artistsUri = Uri.https(
    'class-8804f-default-rtdb.asia-southeast1.firebasedatabase.app',
    '/artists.json',
  );

  @override
  Future<List<Artist>> fetchArtists() async {
    final http.Response response = await http.get(artistsUri);

    if (response.statusCode == 200) {
      final artistJson = json.decode(response.body);

      final List<Artist> artists = artistJson.entries.map<Artist>((item) {
        return ArtistDto.fromJson({
          "id": item.key,
          "name": item.value['name'],
          "imageUrl": item.value['imageUrl'],
          "genre": item.value['genre'],
        });
      }).toList();

      return artists;
    } else {
      throw Exception('Failed to load artists');
    }
  }

  @override
  Future<Artist?> fetchArtistById(String id) async {}
}
