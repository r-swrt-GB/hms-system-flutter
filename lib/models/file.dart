import 'package:hive/hive.dart';
import 'package:starter_application/utils/data_sanitiser.dart';

part 'file.g.dart';

@HiveType(typeId: 3)
class File extends HiveObject {
  @HiveField(0)
  int fileId;

  @HiveField(1)
  String fileName;

  @HiveField(2)
  String mimeType;

  @HiveField(3)
  String fileExtension;

  @HiveField(4)
  int size;

  @HiveField(5)
  String baseUrl;

  @HiveField(6)
  String fileKey;

  @HiveField(7)
  String thumbnailKey;

  File({
    required this.fileId,
    required this.fileName,
    required this.mimeType,
    required this.fileExtension,
    required this.size,
    required this.baseUrl,
    required this.fileKey,
    required this.thumbnailKey,
  });

  factory File.fromJson(Map<String, dynamic> json) {
    return File(
      fileId: int.parse(json['id'].toString()),
      fileName: coalesceString(json['filename']),
      mimeType: coalesceString(json['mimetype']),
      fileExtension: coalesceString(json['extension']),
      size: int.parse(json['size']),
      baseUrl: coalesceString(json['base_url']),
      fileKey: coalesceString(json['key']),
      thumbnailKey: coalesceString(json['thumbnail_key']),
    );
  }

  static List<File> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((item) => File.fromJson(item)).toList();
  }
}
