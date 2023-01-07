import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lettutor/providers/app_provider.dart';
import 'package:lettutor/services/functions/schedule_functions.dart';
import 'package:lettutor/services/models/booking_info.dart';
import 'package:lettutor/services/models/language.dart';
import 'package:lettutor/utils/join_meeting.dart';
import 'package:provider/provider.dart';

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
    final appProvider = Provider.of<AppProvider>(context);
    final lang = appProvider.language;

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
                    nextClass != null ? lang.nextLesson : lang.dontHaveUpcoming,
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
                              child: Text(
                                lang.enterRoom,
                                style: const TextStyle(
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
                        ? '${lang.totalLessonTime} ${convertTime(totalHourLesson as Duration, lang)} '
                        : lang.welcome,
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

String convertTime(Duration totalHourLesson, Language lang) {
  String result = '';
  if (totalHourLesson.inHours > 0) {
    result += '${totalHourLesson.inHours} ${lang.hour} ';
    totalHourLesson =
        totalHourLesson - Duration(hours: totalHourLesson.inHours);
  }
  if (totalHourLesson.inMinutes > 0) {
    result += '${totalHourLesson.inMinutes} ${lang.minute}';
    totalHourLesson =
        totalHourLesson - Duration(minutes: totalHourLesson.inMinutes);
  }
  return result;
}
