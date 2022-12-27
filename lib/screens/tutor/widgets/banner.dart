import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:lettutor/services/functions/schedule_functions.dart';
import 'package:lettutor/services/models/booking_info.dart';
import 'package:lettutor/utils/join_meeting.dart';

class BannerHomeScreen extends StatefulWidget {
  const BannerHomeScreen({super.key});

  @override
  State<BannerHomeScreen> createState() => _BannerHomeScreenState();
}

class _BannerHomeScreenState extends State<BannerHomeScreen> {
  bool isLoading = true;
  Duration? totalHourLesson;
  BookingInfo? nextClass;

  void getTotalAndNextLesson() async {
    final total = await ScheduleFunctions.getTotalHourLesson();
    final next = await ScheduleFunctions.getNextClass();
    if (mounted) {
      setState(() {
        totalHourLesson = Duration(minutes: total);
        nextClass = next;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      getTotalAndNextLesson();
    }
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30),
      width: MediaQuery.of(context).size.width,
      color: const Color(0xff0040D6),
      child: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: nextClass != null ? 8 : 0),
                  child: Text(
                    nextClass != null
                        ? 'Buổi học sắp diễn ra'
                        : 'Bạn không có buổi học nào',
                    style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  nextClass != null
                      ? '${DateFormat.yMEd().format(DateTime.fromMillisecondsSinceEpoch(nextClass!.scheduleDetailInfo!.startPeriodTimestamp))} ${DateFormat('HH:mm').format(DateTime.fromMillisecondsSinceEpoch(nextClass!.scheduleDetailInfo!.startPeriodTimestamp))} - ${DateFormat('HH:mm').format(DateTime.fromMillisecondsSinceEpoch(nextClass!.scheduleDetailInfo!.endPeriodTimestamp))}'
                      : '',
                  style: const TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                nextClass != null
                    ? Container(
                        margin: const EdgeInsets.only(top: 5),
                        child: ElevatedButton(
                          onPressed: () {
                            joinMeeting(nextClass);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(1000))),
                          ),
                          child: Container(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              child: const Text(
                                'Vào lớp học',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              )),
                        ),
                      )
                    : Container(),
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  child: Text(
                    totalHourLesson != null
                        ? 'Tổng số giờ bạn đã học là ${convertTime(totalHourLesson as Duration)} '
                        : 'Chào mừng đến với Lettutor',
                    style: const TextStyle(fontSize: 13, color: Colors.white),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
    );
  }
}

String convertTime(Duration totalHourLesson) {
  String result = '';
  if (totalHourLesson.inHours > 0) {
    result += '${totalHourLesson.inHours} giờ ';
    totalHourLesson =
        totalHourLesson - Duration(hours: totalHourLesson.inHours);
  }
  if (totalHourLesson.inMinutes > 0) {
    result += '${totalHourLesson.inMinutes} phút';
    totalHourLesson =
        totalHourLesson - Duration(minutes: totalHourLesson.inMinutes);
  }
  return result;
}
