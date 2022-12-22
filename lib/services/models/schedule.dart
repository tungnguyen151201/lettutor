import 'package:lettutor/services/models/schedule_detail.dart';
import 'package:lettutor/services/models/tutor.dart';

class Schedule {
  late String id;
  late String tutorId;
  late String startTime;
  late String endTime;
  late int startTimestamp;
  late int endTimestamp;
  late String createdAt;
  bool isBooked = false;
  List<ScheduleDetails> scheduleDetails = [];
  Tutor? tutorInfo;

  Schedule({
    required this.id,
    required this.tutorId,
    required this.startTime,
    required this.endTime,
    required this.startTimestamp,
    required this.endTimestamp,
    required this.createdAt,
    required this.isBooked,
    required this.scheduleDetails,
    this.tutorInfo,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    List<ScheduleDetails> scheduleDetails = [];
    if (json['scheduleDetails'] != null) {
      for (var v in json['scheduleDetails']) {
        scheduleDetails.add(ScheduleDetails.fromJson(v));
      }
    }

    return Schedule(
      id: json['id'],
      tutorId: json['tutorId'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      startTimestamp: json['startTimestamp'],
      endTimestamp: json['endTimestamp'],
      createdAt: json['createdAt'],
      isBooked: json['isBooked'] ?? false,
      scheduleDetails: scheduleDetails,
      tutorInfo:
          json['tutorInfo'] != null ? Tutor.fromJson(json['tutorInfo']) : null,
    );
  }
}
