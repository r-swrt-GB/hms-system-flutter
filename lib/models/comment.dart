import 'package:hive/hive.dart';
import 'package:starter_application/utils/data_sanitiser.dart';

part 'comment.g.dart';

@HiveType(typeId: 2)
class Comment extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String commentText;

  Comment({
    required this.id,
    required this.commentText,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: int.parse(json['id']),
      commentText: coalesceString(json['comment_text']),
    );
  }

  static List<Comment> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((item) => Comment.fromJson(item)).toList();
  }
}
