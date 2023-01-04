class CourseCategory {
  late String id;
  late String title;
  String? description;
  late String key;
  late String createdAt;
  late String updatedAt;

  CourseCategory({
    required this.id,
    required this.title,
    this.description,
    required this.key,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CourseCategory.fromJson(Map<String, dynamic> json) {
    return CourseCategory(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      key: json['key'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
