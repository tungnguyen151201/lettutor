import 'package:lettutor/services/models/feedback.dart';

class Tutor {
  final String userId;
  final String? avatar;
  final String? name;
  final String? bio;
  final String? specialties;
  final String? video;
  final String? experience;
  final String? languages;
  final String? interests;
  final String? country;
  final double? rating;
  final bool? isFavorite;
  final List<FeedBack>? feedbacks;

  Tutor(
      {required this.userId,
      this.avatar,
      this.name,
      this.bio,
      this.specialties,
      this.rating,
      this.video,
      this.experience,
      this.languages,
      this.interests,
      this.country,
      this.isFavorite,
      this.feedbacks});

  factory Tutor.fromJson(Map<String, dynamic> json) {
    List<FeedBack> feedbacks = [];
    if (json['feedbacks'] != null) {
      for (var v in json['feedbacks']) {
        feedbacks.add(FeedBack.fromJson(v));
      }
    }

    return Tutor(
      userId: json['userId'] ?? json['id'],
      avatar: json['avatar'],
      name: json['name'],
      bio: json['bio'],
      specialties: json['specialties'],
      rating: json['rating'],
      isFavorite: json['isFavorite'],
      feedbacks: feedbacks,
    );
  }

  factory Tutor.fromJson2(Map<String, dynamic> json) {
    return Tutor(
      userId: json['User']['id'],
      avatar: json['User']['avatar'],
      name: json['User']['name'],
      country: json['User']['country'],
      bio: json['bio'],
      specialties: json['specialties'],
      rating: json['rating'],
      video: json['video'],
      experience: json['experience'],
      languages: json['languages'],
      interests: json['interests'],
      isFavorite: json['isFavorite'],
    );
  }
}
