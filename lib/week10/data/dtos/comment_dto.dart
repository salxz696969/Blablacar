import '../../model/comment/comment.dart';

class CommentDto {
  static const String idKey = 'id';
  static const String artistIdKey = 'artistId';
  static const String contentKey = 'content';

  static Comment fromJson(String id, Map<String, dynamic> json) {
    assert(json[idKey] is String);
    assert(json[artistIdKey] is String);
    assert(json[contentKey] is String);

    return Comment(
      id: id,
      artistId: json[artistIdKey],
      content: json[contentKey],
    );
  }

  /// Convert Comment to JSON
  Map<String, dynamic> toJson(Comment comment) {
    return {
      idKey: comment.id,
      artistIdKey: comment.artistId,
      contentKey: comment.content,
    };
  }
}
