// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hms_system_application/models/comment.dart';

class CommentProvider with ChangeNotifier {
  final String boxName = "commentBox";
  late List<Comment> _comments;

  List<Comment> get comments => _comments;

  Future<Box<Comment>> getCommentBox() async {
    if (Hive.isBoxOpen(boxName)) {
      return Hive.box<Comment>(boxName);
    } else {
      return await Hive.openBox<Comment>(boxName);
    }
  }

  Future<Comment?> get comment async {
    final box = await getCommentBox();
    return box.getAt(0);
  }

  Future<bool> storeCommentDetails(Comment? comment) async {
    try {
      final box = await getCommentBox();

      if (comment != null) {
        await box.clear();
        await box.add(comment);

        notifyListeners();
        print('Comment saved successfully');
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
}
