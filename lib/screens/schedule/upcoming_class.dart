import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lettutor/providers/app_provider.dart';
import 'package:lettutor/screens/schedule/widgets/upcoming_card.dart';
import 'package:lettutor/services/functions/schedule_functions.dart';
import 'package:lettutor/services/models/booking_info.dart';
import 'package:provider/provider.dart';

class UpcomingClassScreen extends StatefulWidget {
  const UpcomingClassScreen({super.key});

  @override
  State<UpcomingClassScreen> createState() => _UpcomingClassScreenState();
}

class _UpcomingClassScreenState extends State<UpcomingClassScreen> {
  bool isLoading = true;
  int page = 1;
  int perPage = 10;
  bool isLoadMore = false;
  late ScrollController _scrollController;

  List<BookingInfo> upcomingList = [];

  void getUpcoming() async {
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
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(loadMore);
  }

  @override
  void dispose() {
    _scrollController.removeListener(loadMore);
    super.dispose();
  }

  void loadMore() async {
    if (_scrollController.position.extentAfter < page * perPage) {
      setState(() {
        isLoadMore = true;
        page++;
      });

      try {
        List<BookingInfo>? response =
            await ScheduleFunctions.getUpcomingClass(page, perPage);
        if (mounted) {
          setState(() {
            upcomingList.addAll(response!);
            isLoadMore = false;
          });
        }
      } catch (e) {
        const snackBar = SnackBar(
          content: Text('Không thể tải thêm nữa'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    final lang = appProvider.language;

    if (isLoading) {
      getUpcoming();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(lang.schedule),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
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
                                    lang.dontHaveUpcoming,
                                    style: TextStyle(color: Colors.grey[700]),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: upcomingList.length,
                          controller: _scrollController,
                          itemBuilder: (context, index) {
                            return Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: UpcomingCard(
                                upcoming: upcomingList[index],
                                callback: () => getUpcoming(),
                              ),
                            );
                          },
                        ),
                ),
                if (isLoadMore)
                  const SizedBox(
                    height: 50,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
              ],
            ),
    );
  }
}
