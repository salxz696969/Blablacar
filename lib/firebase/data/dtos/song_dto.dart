import '../../model/songs/song.dart';

class SongDto {
  static const String idKey = 'id';
  static const String titleKey = 'name';
  static const String artistIdKey = 'artistId';
  static const String durationKey = 'durations'; // in ms
  static const String imageUrlKey = 'imageUrl';

  static Song fromJson(Map<String, dynamic> json) {
    assert(json[idKey] is String);
    assert(json[titleKey] is String);
    assert(json[artistIdKey] is String);
    assert(json[durationKey] is int);

    return Song(
      id: json[idKey],
      title: json[titleKey],
      artistId: json[artistIdKey],
      imageUrl: Uri.parse(json[imageUrlKey] as String),
      duration: Duration(milliseconds: json[durationKey]),
    );
  }

  /// Convert Song to JSON
  Map<String, dynamic> toJson(Song song) {
    return {
      idKey: song.id,
      titleKey: song.title,
      artistIdKey: song.artistId,
      imageUrlKey: song.imageUrl.toString(),
      durationKey: song.duration.inMilliseconds,
    };
  }
}
