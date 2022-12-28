class TestPreparation {
  late int id;
  late String key;
  late String name;

  TestPreparation({required this.id, required this.key, required this.name});

  TestPreparation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['key'] = key;
    data['name'] = name;
    return data;
  }
}
