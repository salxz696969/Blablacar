import 'package:blabla/week10/model/artist/artist.dart';
import 'package:blabla/week10/model/comment/comment.dart';
import 'package:blabla/week10/model/songs/song.dart';

class ArtistDetail {
  final Artist artist;
  final List<Song> songs;
  final List<Comment> comments;

  ArtistDetail({
    required this.artist,
    required this.songs,
    required this.comments,
  });
}
