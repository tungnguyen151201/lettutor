import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lettutor/screens/schedule/widgets/upcoming_card.dart';
import 'package:lettutor/services/functions/schedule_functions.dart';
import 'package:lettutor/services/models/booking_info.dart';

class UpcomingClassScreen extends StatefulWidget {
  const UpcomingClassScreen({super.key});

  @override
  State<UpcomingClassScreen> createState() => _UpcomingClassScreenState();
}

class _UpcomingClassScreenState extends State<UpcomingClassScreen> {
  bool isLoading = true;
  int page = 1;
  int perPage = 10;

  List<BookingInfo> upcomingList = [];

  void fetchUpcoming() async {
    setState(() {
      isLoading = true;
    });
    final res = await ScheduleFunctions.getUpcomingClass(page, perPage);
    if (mounted && isLoading) {
      setState(() {
        upcomingList = res ?? [];
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      fetchUpcoming();
      return Scaffold(
        appBar: AppBar(
          title: const Text('Lịch đã đặt'),
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lịch đã đặt'),
      ),
      body: Column(
        children: [
          Expanded(
            child: upcomingList.isEmpty
                ? SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "asset/svg/ic_empty.svg",
                            width: 200,
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            child: Text(
                              'Chưa có lịch học nào',
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: upcomingList.length,
                    // controller: _scrollController,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        child: UpcomingCard(
                          upcoming: upcomingList[index],
                        ),
                      );
                    },
                  ),
          ),
          // if (isLoadMore)
          //   const SizedBox(
          //     height: 50,
          //     child: Center(
          //       child: CircularProgressIndicator(),
          //     ),
          //   ),
        ],
      ),
    );
  }
}
