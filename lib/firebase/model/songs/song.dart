import 'package:blabla/firebase/model/artists/artist.dart';

class Song {
  final String id;
  final String title;
  Artist? artist;
  final String artistId;
  final Uri imageUrl;
  final Duration duration;

  Song({
    this.artist,
    required this.id,
    required this.title,
    required this.artistId,
    required this.imageUrl,
    required this.duration,
  });

  @override
  String toString() {
    return 'Song(id: $id, title: $title, artist: $artist, imageUrl: $imageUrl, duration: $duration)';
  }

  void setArtist(Artist artist) {
    if (artist.id != artistId) {
      throw Exception('Artist ID does not match');
    }
    this.artist = artist;
  }
}
