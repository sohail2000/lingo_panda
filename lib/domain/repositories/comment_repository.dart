import '../../data/models/comment_model.dart';

abstract class CommentRepository {
  Future<List<CommentModel>> fetchComments(int page, int limit);
}
