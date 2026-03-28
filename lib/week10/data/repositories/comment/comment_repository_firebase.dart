import 'dart:convert';

import 'package:blabla/week10/data/repositories/comment/comment_repository.dart';
import 'package:blabla/week10/model/comment/comment.dart';
import 'package:http/http.dart' as http;

class CommentRepositoryFirebase implements CommentRepository {
  final Uri commentUri = Uri.https(
    'class-8804f-default-rtdb.asia-southeast1.firebasedatabase.app',
    '/comments.json',
  );
  final List<Comment> _cachedComments = [];

  Uri _commentByIdUri(String id) => Uri.https(
    'class-8804f-default-rtdb.asia-southeast1.firebasedatabase.app',
    '/comments/$id.json',
  );

  @override
  Future<List<Comment>> fetchComments(String artistId) async {
    if (_cachedComments.isNotEmpty) {
      final List<Comment> comments = [];
      for (Comment comment in _cachedComments) {
        if (comment.artistId == artistId) {
          comments.add(comment);
        }
      }
      return Future.value(comments);
    }

    final http.Response response = await http.get(commentUri);
    if (response.statusCode != 200) {
      throw Exception('Failed to load comments');
    }

    if (response.body == 'null') {
      return Future.value(<Comment>[]);
    }

    final Map<String, dynamic> commentJson = json.decode(response.body);
    for (final entry in commentJson.entries) {
      _cachedComments.add(
        Comment(
          id: entry.key,
          artistId: entry.value['artistId'],
          content: entry.value['content'],
        ),
      );
    }

    final List<Comment> comments = [];
    for (Comment comment in _cachedComments) {
      if (comment.artistId == artistId) {
        comments.add(comment);
      }
    }

    return Future.value(comments);
  }

  @override
  Future<Comment> addComment(Comment comment) async {
    await fetchComments(comment.artistId);

    final String id = "comment_${_cachedComments.length + 1}";
    final Map<String, dynamic> newComment = {
      "artistId": comment.artistId,
      "content": comment.content,
    };

    final http.Response response = await http.post(
      _commentByIdUri(id),
      body: json.encode(newComment),
    );

    if (response.statusCode == 200) {
      final Comment createdComment = Comment(
        id: id,
        artistId: comment.artistId,
        content: comment.content,
      );
      _cachedComments.add(createdComment);
      return createdComment;
    } else {
      throw Exception('Failed to add comment');
    }
  }
}
