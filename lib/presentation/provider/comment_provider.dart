import 'package:flutter/material.dart';
import 'package:lingo_panda/data/models/comment_model.dart';
import 'package:lingo_panda/domain/repositories/comment_repository.dart';

class CommentProvider with ChangeNotifier {
  final CommentRepository commentRepository;

  CommentProvider(this.commentRepository);

  List<CommentModel> _comments = [];
  bool _isLoading = false;
  int _page = 1;
  final int _limit = 20;

  List<CommentModel> get comments => _comments;
  bool get isLoading => _isLoading;

  Future<void> fetchComments() async {
    if (_isLoading) return;

    _isLoading = true;
    notifyListeners();

    try {
      final newComments = await commentRepository.fetchComments(_page, _limit);
      _comments.addAll(newComments);
      _page++;
    } catch (error) {
      print("Error fetching comments: $error");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  bool hasMoreComments(int totalComments) {
    return _comments.length < totalComments;
  }
}
