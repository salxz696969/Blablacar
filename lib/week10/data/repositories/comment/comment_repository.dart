import 'package:blabla/week10/model/comment/comment.dart';

abstract class CommentRepository {
  Future<List<Comment>> fetchComments(String artistId);
  Future<Comment> addComment(Comment comment);
}
