import '../../../domain/repositories/comment_repository.dart';
import '../data_sources/comment_remote_data_source.dart';
import '../models/comment_model.dart';

class CommentRepositoryImpl implements CommentRepository {
  final CommentRemoteDataSource remoteDataSource;

  CommentRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<CommentModel>> fetchComments(int page, int limit)  {
    return  remoteDataSource.fetchComments(page, limit);
  }
}
