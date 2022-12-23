import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lettutor/services/functions/schedule_functions.dart';
import 'package:lettutor/services/models/schedule.dart';
import 'package:lettutor/services/models/schedule_detail.dart';
import 'package:lettutor/utils/generate_ratio.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class BookingFeature extends StatefulWidget {
  const BookingFeature({Key? key, required this.tutorId}) : super(key: key);

  final String tutorId;

  @override
  State<BookingFeature> createState() => _BookingFeatureState();
}

class _BookingFeatureState extends State<BookingFeature> {
  List<Schedule> _schedules = [];
  bool isLoading = true;

  void fetchSchedules() async {
    List<Schedule>? res =
        await ScheduleFunctions.getScheduleByTutorId(widget.tutorId);
    res = res!.where((schedule) {
      final now = DateTime.now();
      final start =
          DateTime.fromMillisecondsSinceEpoch(schedule.startTimestamp);
      return start.isAfter(now) ||
          (start.day == now.day &&
              start.month == now.month &&
              start.year == now.year);
    }).toList();
    res.sort((s1, s2) => s1.startTimestamp.compareTo(s2.startTimestamp));

    List<Schedule> tempRes = [];

    for (int index = 0; index < res.length; index++) {
      bool isExist = false;
      for (int index_2 = 0; index_2 < tempRes.length; index_2++) {
        final DateTime first =
            DateTime.fromMillisecondsSinceEpoch(res[index].startTimestamp);
        final DateTime second = DateTime.fromMillisecondsSinceEpoch(
            tempRes[index_2].startTimestamp);
        if (first.day == second.day &&
            first.month == second.month &&
            first.year == second.year) {
          tempRes[index_2].scheduleDetails.addAll(res[index].scheduleDetails);
          isExist = true;
          break;
        }
      }

      if (!isExist) {
        tempRes.add(res[index]);
      }
    }

    for (int index = 0; index < tempRes.length; index++) {
      tempRes[index].scheduleDetails.sort((s1, s2) => DateTime
              .fromMillisecondsSinceEpoch(s1.startPeriodTimestamp)
          .compareTo(
              DateTime.fromMillisecondsSinceEpoch(s2.startPeriodTimestamp)));
    }

    if (mounted) {
      setState(() {
        _schedules = tempRes;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (mounted && isLoading) {
      fetchSchedules();
    }

    Future showTutorTimePicker(Schedule schedules) {
      List<ScheduleDetails> scheduleDetails = schedules.scheduleDetails;

      return showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(10),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        isScrollControlled: true,
        builder: (context) {
          return SafeArea(
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) =>
                  Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height * 0.6,
                child: Column(
                  children: [
                    Container(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        margin: const EdgeInsets.only(bottom: 10),
                        width: double.infinity,
                        decoration: BoxDecoration(color: Colors.grey[300]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const <Widget>[
                            Text(
                              'Chọn giờ học',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        )),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: 10, left: 10, bottom: 10),
                        child: GridView.count(
                          crossAxisCount:
                              generateAsisChildRatio(constraints)[0].toInt(),
                          childAspectRatio:
                              (1 / generateAsisChildRatio(constraints)[1]),
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          shrinkWrap: true,
                          children: List.generate(
                            scheduleDetails.length,
                            (index) => ElevatedButton(
                              onPressed: () async {
                                if (!scheduleDetails[index].isBooked &&
                                    DateTime.fromMillisecondsSinceEpoch(
                                            scheduleDetails[index]
                                                .startPeriodTimestamp)
                                        .isAfter(DateTime.now())) {
                                  try {
                                    final res =
                                        await ScheduleFunctions.bookAClass(
                                            scheduleDetails[index].id);
                                    if (res && mounted) {
                                      scheduleDetails[index].isBooked = true;
                                      Navigator.pop(context);
                                      Navigator.pop(context);

                                      showTopSnackBar(
                                        context,
                                        const CustomSnackBar.success(
                                          message: 'Đặt lịch thành công',
                                          backgroundColor: Colors.green,
                                        ),
                                        showOutAnimationDuration:
                                            const Duration(milliseconds: 700),
                                        displayDuration:
                                            const Duration(milliseconds: 200),
                                      );
                                    }
                                  } catch (e) {
                                    showTopSnackBar(
                                      context,
                                      CustomSnackBar.error(
                                          message: e.toString()),
                                      showOutAnimationDuration:
                                          const Duration(milliseconds: 700),
                                      displayDuration:
                                          const Duration(milliseconds: 200),
                                    );
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    scheduleDetails[index].isBooked ||
                                            DateTime.fromMillisecondsSinceEpoch(
                                                    scheduleDetails[index]
                                                        .startPeriodTimestamp)
                                                .isBefore(DateTime.now())
                                        ? Colors.grey[200]
                                        : Colors.white,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  side:
                                      BorderSide(color: Colors.blue, width: 1),
                                ),
                              ),
                              child: Container(
                                padding:
                                    const EdgeInsets.only(top: 13, bottom: 13),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${DateFormat('HH:mm').format(DateTime.fromMillisecondsSinceEpoch(scheduleDetails[index].startPeriodTimestamp))} - ',
                                      style:
                                          const TextStyle(color: Colors.blue),
                                    ),
                                    Text(
                                      DateFormat('HH:mm').format(
                                          DateTime.fromMillisecondsSinceEpoch(
                                              scheduleDetails[index]
                                                  .endPeriodTimestamp)),
                                      style:
                                          const TextStyle(color: Colors.blue),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }

    Future showTutorDatePicker() {
      return showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(10),
          ),
        ),
        isScrollControlled: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        builder: (context) {
          return SafeArea(
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) =>
                  Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height * 0.6,
                constraints: const BoxConstraints(maxWidth: 1000),
                child: Column(
                  children: [
                    Container(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        margin: const EdgeInsets.only(bottom: 10),
                        width: double.infinity,
                        decoration: BoxDecoration(color: Colors.grey[300]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const <Widget>[
                            Text('Chọn ngày học',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                          ],
                        )),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: 10, left: 10, bottom: 10),
                        child: GridView.count(
                          crossAxisCount:
                              generateAsisChildRatio(constraints)[0].toInt(),
                          childAspectRatio:
                              (1 / generateAsisChildRatio(constraints)[1]),
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          shrinkWrap: true,
                          children: List.generate(
                            _schedules.length,
                            (index) => ElevatedButton(
                              onPressed: () {
                                showTutorTimePicker(_schedules[index]);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  side:
                                      BorderSide(color: Colors.blue, width: 1),
                                ),
                              ),
                              child: Container(
                                padding:
                                    const EdgeInsets.only(top: 13, bottom: 13),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      DateFormat.MMMEd().format(
                                          DateTime.fromMillisecondsSinceEpoch(
                                              _schedules[index]
                                                  .startTimestamp)),
                                      style:
                                          const TextStyle(color: Colors.blue),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }

    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20),
          child: ElevatedButton(
            onPressed: () {
              showTutorDatePicker();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(1000))),
            ),
            child: Container(
              padding: const EdgeInsets.only(top: 13, bottom: 13),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('Đặt lịch học', style: TextStyle(color: Colors.white))
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
