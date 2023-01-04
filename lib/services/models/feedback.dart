class FeedBack {
  late String id;
  String? bookingId;
  late String firstId;
  late String secondId;
  late double rating;
  late String content;
  late String createdAt;
  late String updatedAt;
  late FirstInfo firstInfo;

  FeedBack(
      {required this.id,
      this.bookingId,
      required this.firstId,
      required this.secondId,
      required this.rating,
      required this.content,
      required this.createdAt,
      required this.updatedAt,
      required this.firstInfo});

  factory FeedBack.fromJson(Map<String, dynamic> json) {
    return FeedBack(
      id: json['id'],
      bookingId: json['bookingId'],
      firstId: json['firstId'],
      secondId: json['secondId'],
      rating: json['rating'].runtimeType == double
          ? json['rating']
          : double.parse(json['rating'].toString()),
      content: json['content'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      firstInfo: FirstInfo.fromJson(json['firstInfo']),
    );
  }
}

class FirstInfo {
  String? id;
  late String email;
  String? google;
  String? facebook;
  String? apple;
  late String name;
  late String avatar;
  String? country;
  String? phone;
  String? language;
  String? birthday;
  bool? isActivated;
  String? level;
  bool? requestPassword;
  bool? isPhoneActivated;
  String? studySchedule;
  int? timezone;
  String? phoneAuth;
  bool? isPhoneAuthActivated;
  late String createdAt;
  late String updatedAt;
  String? deletedAt;

  FirstInfo({
    this.id,
    required this.email,
    this.google,
    this.facebook,
    this.apple,
    required this.name,
    required this.avatar,
    this.country,
    this.phone,
    this.language,
    this.birthday,
    this.isActivated,
    this.level,
    this.requestPassword,
    this.isPhoneActivated,
    this.studySchedule,
    this.timezone,
    this.phoneAuth,
    this.isPhoneAuthActivated,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory FirstInfo.fromJson(Map<String, dynamic> json) {
    return FirstInfo(
      id: json['id'],
      email: json['email'],
      google: json['google'],
      facebook: json['facebook'],
      apple: json['apple'],
      name: json['name'],
      avatar: json['avatar'],
      country: json['country'],
      phone: json['phone'],
      language: json['language'],
      birthday: json['birthday'],
      isActivated: json['isActivated'],
      level: json['level'],
      requestPassword: json['requestPassword'],
      isPhoneActivated: json['isPhoneActivated'],
      studySchedule: json['studySchedule'],
      timezone: json['timezone'],
      phoneAuth: json['phoneAuth'],
      isPhoneAuthActivated: json['isPhoneAuthActivated'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      deletedAt: json['deletedAt'],
    );
  }
}
