import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment_entity.freezed.dart';
// part 'comment_model.g.dart';

@freezed
class CommentEntity with _$CommentEntity {
  const factory CommentEntity({
    required int postId,
    required String name,
    required String email,
    required String body,
  }) = _CommentEntity;

  // factory CommentModel.fromJson(Map<String, dynamic> json) =>
  //     _$CommentModelFromJson(json);
}
