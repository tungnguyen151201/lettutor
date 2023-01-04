import 'package:lettutor/services/models/course_category.dart';

class Ebook {
  late String id;
  late String name;
  late String description;
  late String imageUrl;
  late String level;
  late bool visible;
  late String fileUrl;
  late String createdAt;
  late String updatedAt;
  bool? isPrivate;
  String? createdBy;
  List<CourseCategory>? categories;

  Ebook({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.level,
    required this.visible,
    required this.fileUrl,
    required this.createdAt,
    required this.updatedAt,
    this.isPrivate,
    this.createdBy,
    this.categories,
  });

  factory Ebook.fromJson(Map<String, dynamic> json) {
    List<CourseCategory> categories = [];
    if (json['categories'] != null) {
      for (var v in json['categories']) {
        categories.add(CourseCategory.fromJson(v));
      }
    }
    return Ebook(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        imageUrl: json['imageUrl'],
        level: json['level'],
        visible: json['visible'],
        fileUrl: json['fileUrl'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
        isPrivate: json['isPrivate'],
        createdBy: json['createdBy'],
        categories: categories);
  }
}
