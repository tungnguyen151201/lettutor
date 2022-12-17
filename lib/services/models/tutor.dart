class Tutor {
  final String? avatar;
  final String? name;
  final String? bio;
  final String? specialties;
  final double? rating;

  Tutor({this.avatar, this.name, this.bio, this.specialties, this.rating});

  factory Tutor.fromJson(Map<String, dynamic> json) {
    return Tutor(
      avatar: json['avatar'],
      name: json['name'],
      bio: json['bio'],
      specialties: json['specialties'],
      rating: json['rating'],
    );
  }
}
