import 'package:flutter/material.dart';
import 'package:lettutor/services/functions/schedule_functions.dart';

class BannerHomeScreen extends StatefulWidget {
  const BannerHomeScreen({super.key});

  @override
  State<BannerHomeScreen> createState() => _BannerHomeScreenState();
}

class _BannerHomeScreenState extends State<BannerHomeScreen> {
  bool isLoading = true;
  Duration? totalHourLesson;

  void getToTalHourLesson() async {
    final res = await ScheduleFunctions.getTotalHourLesson();
    if (res != null && mounted) {
      setState(() {
        totalHourLesson = Duration(minutes: res);
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      getToTalHourLesson();
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
                Text(
                  totalHourLesson != null
                      ? 'Tổng số giờ bạn đã học là ${convertTime(totalHourLesson as Duration)} '
                      : 'Chào mừng đến với Lettutor',
                  style: const TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                // nextlesson != null
                //     ? Container(
                //         margin: const EdgeInsets.only(top: 8, bottom: 8),
                //         child: Text(
                //           lang.nextLesson,
                //           style: const TextStyle(fontSize: 13, color: Colors.white),
                //         ),
                //       )
                //     : Container(),
                // Text(
                //   nextlesson != null
                //       ? DateFormat.yMEd().format(DateTime.fromMillisecondsSinceEpoch(
                //               nextlesson!.scheduleDetailInfo!.startPeriodTimestamp)) +
                //           " " +
                //           DateFormat('HH:mm').format(DateTime.fromMillisecondsSinceEpoch(
                //               nextlesson!.scheduleDetailInfo!.startPeriodTimestamp)) +
                //           " - " +
                //           DateFormat('HH:mm').format(
                //               DateTime.fromMillisecondsSinceEpoch(nextlesson!.scheduleDetailInfo!.endPeriodTimestamp))
                //       : "",
                //   style: const TextStyle(fontSize: 13, color: Colors.white),
                // ),
                // Container(
                //   margin: const EdgeInsets.only(top: 10),
                //   child: ElevatedButton(
                //     onPressed: () async {
                //       if (nextlesson != null) {
                //         final base64Decoded = base64
                //             .decode(base64.normalize(nextlesson!.studentMeetingLink.split("token=")[1].split(".")[1]));
                //         final urlObject = utf8.decode(base64Decoded);
                //         final jsonRes = json.decode(urlObject);
                //         final String roomId = jsonRes['room'];
                //         final String tokenMeeting = nextlesson!.studentMeetingLink.split("token=")[1];

                //         final options = JitsiMeetingOptions(room: roomId)
                //           ..serverURL = "https://meet.lettutor.com"
                //           ..audioOnly = true
                //           ..audioMuted = true
                //           ..token = tokenMeeting
                //           ..videoMuted = true;

                //         await JitsiMeet.joinMeeting(options);
                //       } else {
                //         navigationIndex.index = 3;
                //       }
                //     },
                //     child: Container(
                //         padding: const EdgeInsets.only(top: 10, bottom: 10),
                //         child: Text(
                //           nextlesson != null ? lang.enterRoom : lang.bookAlesson,
                //           style: const TextStyle(color: Colors.blue, fontSize: 14, fontWeight: FontWeight.bold),
                //         )),
                //     style: ElevatedButton.styleFrom(
                //       backgroundColor: Colors.white,
                //       shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(1000))),
                //     ),
                //   ),
                // )
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
