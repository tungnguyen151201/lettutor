class Tutor {
  final String? avatar;
  final String? name;
  final String? bio;
  final String? specialties;
  final double? rating;
  final bool? isFavorite;

  Tutor(
      {this.avatar,
      this.name,
      this.bio,
      this.specialties,
      this.rating,
      this.isFavorite});

  factory Tutor.fromJson(Map<String, dynamic> json) {
    return Tutor(
      avatar: json['avatar'],
      name: json['name'],
      bio: json['bio'],
      specialties: json['specialties'],
      rating: json['rating'],
      isFavorite: json['isFavorite'],
    );
  }
}
