import 'package:hive/hive.dart';
import 'package:hms_system_application/models/assignment.dart';
import 'package:hms_system_application/models/comment.dart';
import 'package:hms_system_application/models/file.dart';
import 'package:hms_system_application/models/group.dart';
import 'package:hms_system_application/models/module.dart';
import 'package:hms_system_application/models/notification.dart';
import 'package:hms_system_application/models/submission.dart';
import 'package:hms_system_application/models/user.dart';

registerAdapters() {
  Hive.registerAdapter(AssignmentAdapter());
  Hive.registerAdapter(CommentAdapter());
  Hive.registerAdapter(FileAdapter());
  Hive.registerAdapter(AssignmentAdapter());
  Hive.registerAdapter(GroupAdapter());
  Hive.registerAdapter(ModuleAdapter());
  Hive.registerAdapter(NotificationAdapter());
  Hive.registerAdapter(SubmissionAdapter());
  Hive.registerAdapter(UserAdapter());
}
