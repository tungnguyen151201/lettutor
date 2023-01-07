import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lettutor/providers/app_provider.dart';
import 'package:lettutor/services/functions/schedule_functions.dart';
import 'package:lettutor/services/models/booking_info.dart';
import 'package:lettutor/utils/join_meeting.dart';
import 'package:lettutor/widgets/custom_avatar.dart';
import 'package:provider/provider.dart';

typedef Callback = void Function();

class UpcomingCard extends StatefulWidget {
  const UpcomingCard(
      {super.key, required this.upcoming, required this.callback});
  final BookingInfo upcoming;
  final Callback callback;

  @override
  State<UpcomingCard> createState() => _UpcomingCardState();
}

class _UpcomingCardState extends State<UpcomingCard> {
  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    final lang = appProvider.language;

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
                      imgUrl: widget.upcoming.scheduleDetailInfo!.scheduleInfo!
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
                          widget.upcoming.scheduleDetailInfo!.scheduleInfo!
                              .tutorInfo!.name as String,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            DateFormat.yMEd().format(
                                DateTime.fromMillisecondsSinceEpoch(widget
                                    .upcoming
                                    .scheduleDetailInfo!
                                    .startPeriodTimestamp)),
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
                                  DateTime.fromMillisecondsSinceEpoch(widget
                                      .upcoming
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
                                  DateTime.fromMillisecondsSinceEpoch(widget
                                      .upcoming
                                      .scheduleDetailInfo!
                                      .endPeriodTimestamp)),
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
                        final now = DateTime.now();
                        final start = DateTime.fromMillisecondsSinceEpoch(widget
                            .upcoming.scheduleDetailInfo!.startPeriodTimestamp);
                        if (start.isAfter(now) &&
                            now.difference(start).inHours.abs() >= 2) {
                          final res = await ScheduleFunctions.cancelClass(
                              widget.upcoming.id);
                          if (res) {
                            widget.callback();
                          }
                        }
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
                          children: <Widget>[
                            Text(
                              lang.cancel,
                              style: const TextStyle(color: Colors.red),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        if (isEnableMetting(widget.upcoming)) {
                          joinMeeting(widget.upcoming);
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: isEnableMetting(widget.upcoming)
                                    ? Colors.blue
                                    : Colors.grey[200] as Color),
                            color: isEnableMetting(widget.upcoming)
                                ? Colors.blue
                                : Colors.grey[200] as Color,
                            borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(4),
                                bottomRight: Radius.circular(4))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              lang.enterRoom,
                              style: TextStyle(
                                  color: isEnableMetting(widget.upcoming)
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
