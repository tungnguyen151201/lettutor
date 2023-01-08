import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:lettutor/providers/app_provider.dart';
import 'package:lettutor/screens/schedule/widgets/record_video.dart';
import 'package:lettutor/services/models/booking_info.dart';
import 'package:lettutor/widgets/custom_avatar.dart';
import 'package:provider/provider.dart';

class HistoryCard extends StatelessWidget {
  final BookingInfo history;
  const HistoryCard({super.key, required this.history});

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
                      imgUrl: history.scheduleDetailInfo!.scheduleInfo!
                          .tutorInfo!.avatar as String,
                      height: 70,
                      width: 70,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text(
                          history.scheduleDetailInfo!.scheduleInfo!.tutorInfo!
                              .name as String,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Row(
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.only(right: 10),
                              width: 20,
                              child: SvgPicture.asset(
                                  "asset/svg/ic_calendar.svg",
                                  width: 15),
                            ),
                            Text(
                              DateFormat.yMEd().add_jm().format(
                                  DateTime.fromMillisecondsSinceEpoch(history
                                      .scheduleDetailInfo!
                                      .startPeriodTimestamp)),
                              style: const TextStyle(fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Row(
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.only(right: 10),
                              width: 20,
                              child: SvgPicture.asset("asset/svg/ic_clock.svg",
                                  width: 15),
                            ),
                            Text(
                              "${DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(history.scheduleDetailInfo!.startPeriodTimestamp))} - ${DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(history.scheduleDetailInfo!.endPeriodTimestamp))}",
                              style: const TextStyle(fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Row(
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.only(right: 10),
                              width: 20,
                              child: SvgPicture.asset("asset/svg/ic_score.svg",
                                  width: 15),
                            ),
                            Text(
                              history.scoreByTutor != null
                                  ? '${lang.feedback}: ${history.scoreByTutor.toString()}'
                                  : lang.tutorNotMark,
                              style: const TextStyle(fontSize: 13),
                            ),
                          ],
                        ),
                      ),
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
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xff0070F3)),
                          color: const Color(0xff0070F3),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4),
                            bottomLeft: Radius.circular(4),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              lang.feedback,
                              style: const TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    RecordVideo(url: history.recordUrl ?? '')));
                      },
                      child: Container(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: history.showRecordUrl
                                  ? Colors.blue
                                  : Colors.grey[200] as Color),
                          color: history.showRecordUrl
                              ? Colors.white
                              : Colors.grey[200] as Color,
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(4),
                            bottomRight: Radius.circular(4),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              lang.watchRecord,
                              style: TextStyle(
                                  color: history.showRecordUrl
                                      ? Colors.blue
                                      : Colors.grey[500] as Color),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
