import 'package:blabla/firebase/model/artists/artist.dart';

abstract class ArtistRepository {
  Future<List<Artist>> fetchArtists();

  Future<List<Artist>> fetchArtistByIds(List<String> ids);
}
