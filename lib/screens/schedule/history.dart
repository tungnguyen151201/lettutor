import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lettutor/screens/schedule/widgets/history_card.dart';
import 'package:lettutor/services/functions/schedule_functions.dart';
import 'package:lettutor/services/models/booking_info.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  bool isLoading = true;
  int page = 1;
  int perPage = 10;

  List<BookingInfo> bookedList = [];

  void fetchUpcoming() async {
    setState(() {
      isLoading = true;
    });
    final res = await ScheduleFunctions.getBookedClass(page, perPage);
    if (mounted && isLoading) {
      setState(() {
        bookedList = res ?? [];
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
          title: const Text('Lịch sử các buổi học'),
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lịch sử các buổi học'),
      ),
      body: Column(
        children: [
          Expanded(
            child: bookedList.isEmpty
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
                              'Chưa có buổi học nào',
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: bookedList.length,
                    // controller: _scrollController,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        child: HistoryCard(
                          history: bookedList[index],
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
