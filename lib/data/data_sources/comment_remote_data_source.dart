import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/comment_model.dart';

class CommentRemoteDataSource {
  final String baseUrl = 'https://jsonplaceholder.typicode.com/comments';

  Future<List<CommentModel>> fetchComments(int page, int limit) async {
    final response = await http.get(Uri.parse('$baseUrl?_page=$page&_limit=$limit'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => CommentModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load comments');
    }
  }
}
