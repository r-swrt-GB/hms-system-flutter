import 'package:hive/hive.dart';
import 'package:hms_system_application/utils/data_sanitiser.dart';

part 'comment.g.dart';

@HiveType(typeId: 2)
class Comment extends HiveObject {
  @HiveField(0)
  int commentId;

  @HiveField(1)
  String commentText;

  Comment({
    required this.commentId,
    required this.commentText,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      commentId: int.parse(json['id']),
      commentText: coalesceString(json['comment_text']),
    );
  }

  static List<Comment> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((item) => Comment.fromJson(item)).toList();
  }
}
