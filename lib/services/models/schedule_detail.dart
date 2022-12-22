import 'package:lettutor/services/models/booking_info.dart';
import 'package:lettutor/services/models/schedule.dart';

class ScheduleDetails {
  late int startPeriodTimestamp;
  late int endPeriodTimestamp;
  late String id;
  late String scheduleId;
  late String startPeriod;
  late String endPeriod;
  late String createdAt;
  late String updatedAt;
  List<BookingInfo> bookingInfo = [];
  bool isBooked = false;
  Schedule? scheduleInfo;

  ScheduleDetails({
    required this.startPeriodTimestamp,
    required this.endPeriodTimestamp,
    required this.id,
    required this.scheduleId,
    required this.startPeriod,
    required this.endPeriod,
    required this.createdAt,
    required this.updatedAt,
    required this.bookingInfo,
    required this.isBooked,
    this.scheduleInfo,
  });

  factory ScheduleDetails.fromJson(Map<String, dynamic> json) {
    List<BookingInfo> bookingInfo = [];
    if (json['bookingInfo'] != null) {
      for (var v in json['bookingInfo']) {
        bookingInfo.add(BookingInfo.fromJson(v));
      }
    }

    return ScheduleDetails(
      startPeriodTimestamp: json['startPeriodTimestamp'],
      endPeriodTimestamp: json['endPeriodTimestamp'],
      id: json['id'],
      scheduleId: json['scheduleId'],
      startPeriod: json['startPeriod'],
      endPeriod: json['endPeriod'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      isBooked: json['isBooked'] ?? false,
      bookingInfo: bookingInfo,
      scheduleInfo: json['scheduleInfo'] != null
          ? Schedule.fromJson(json['scheduleInfo'])
          : null,
    );
  }
}
