import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lettutor/services/models/booking_info.dart';
import 'package:lettutor/widgets/custom_avatar.dart';

class UpcomingCard extends StatelessWidget {
  final BookingInfo upcoming;
  const UpcomingCard({super.key, required this.upcoming});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Card(
        elevation: 6,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    height: 70,
                    width: 70,
                    child: CustomAvatar(
                      imgUrl: upcoming.scheduleDetailInfo!.scheduleInfo!
                          .tutorInfo!.avatar as String,
                      height: 70,
                      width: 70,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 5),
                        child: Text(
                          upcoming.scheduleDetailInfo!.scheduleInfo!.tutorInfo!
                              .name as String,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            DateFormat.yMEd().format(
                                DateTime.fromMillisecondsSinceEpoch(upcoming
                                    .scheduleDetailInfo!.startPeriodTimestamp)),
                            style: const TextStyle(fontSize: 13),
                          ),
                          Container(
                            padding: const EdgeInsets.all(3),
                            margin: const EdgeInsets.only(left: 5, right: 5),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.green, width: 1),
                                color: Colors.green[50],
                                borderRadius: BorderRadius.circular(4)),
                            child: Text(
                              DateFormat.Hm().format(
                                  DateTime.fromMillisecondsSinceEpoch(upcoming
                                      .scheduleDetailInfo!
                                      .startPeriodTimestamp)),
                              style: const TextStyle(
                                  fontSize: 10, color: Colors.green),
                            ),
                          ),
                          const Text("-"),
                          Container(
                            padding: const EdgeInsets.all(3),
                            margin: const EdgeInsets.only(left: 5, right: 5),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.red, width: 1),
                                color: Colors.red[50],
                                borderRadius: BorderRadius.circular(4)),
                            child: Text(
                              DateFormat.Hm().format(
                                  DateTime.fromMillisecondsSinceEpoch(upcoming
                                      .scheduleDetailInfo!.endPeriodTimestamp)),
                              style: const TextStyle(
                                  fontSize: 10, color: Colors.red),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 14),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        // final now = DateTime.now();
                        // final start = DateTime.fromMillisecondsSinceEpoch(
                        //     upcoming.scheduleDetailInfo!.startPeriodTimestamp);
                        // if (start.isAfter(now) &&
                        //     now.difference(start).inHours.abs() >= 2) {
                        //   final res = await ScheduleService.cancelClass(
                        //       authProvider.tokens!.access.token,
                        //       upcoming.scheduleDetailId);
                        //   if (res) {
                        //     refetch(authProvider.tokens!.access.token);
                        //     showTopSnackBar(
                        //       context,
                        //       CustomSnackBar.success(
                        //         message: lang.removeUpcomingSuccess,
                        //         backgroundColor: Colors.green,
                        //       ),
                        //       showOutAnimationDuration:
                        //           const Duration(milliseconds: 700),
                        //       displayDuration:
                        //           const Duration(milliseconds: 200),
                        //     );
                        //   }
                        // } else {
                        //   showTopSnackBar(
                        //     context,
                        //     CustomSnackBar.error(
                        //         message: lang.removeUpcomingFail),
                        //     showOutAnimationDuration:
                        //         const Duration(milliseconds: 700),
                        //     displayDuration: const Duration(milliseconds: 200),
                        //   );
                        // }
                      },
                      child: Container(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.grey[200] as Color),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(4),
                                bottomLeft: Radius.circular(4))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const <Widget>[
                            Text(
                              'Hủy',
                              style: TextStyle(color: Colors.red),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        // if (isEnableMetting(upcoming)) {
                        //   final options = JitsiMeetingOptions(room: roomId)
                        //     ..serverURL = "https://meet.lettutor.com"
                        //     ..audioOnly = true
                        //     ..audioMuted = true
                        //     ..token = tokenMeeting
                        //     ..videoMuted = true;

                        //   await JitsiMeet.joinMeeting(options);
                        // }
                      },
                      child: Container(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: isEnableMetting(upcoming)
                                    ? Colors.blue
                                    : Colors.grey[200] as Color),
                            color: isEnableMetting(upcoming)
                                ? Colors.blue
                                : Colors.grey[200] as Color,
                            borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(4),
                                bottomRight: Radius.circular(4))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Vào buổi học',
                              style: TextStyle(
                                  color: isEnableMetting(upcoming)
                                      ? Colors.white
                                      : Colors.grey[500] as Color),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

bool isEnableMetting(BookingInfo bookingInfo) {
  final now = DateTime.now();
  final start = DateTime.fromMillisecondsSinceEpoch(
      bookingInfo.scheduleDetailInfo!.startPeriodTimestamp);
  return (now.day == start.day &&
      now.month == start.month &&
      now.year == start.year);
}
