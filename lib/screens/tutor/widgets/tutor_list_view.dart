import 'package:flutter/material.dart';
import 'package:lettutor/screens/tutor/widgets/tutor_list_item.dart';
import 'package:lettutor/services/functions/tutor_functions.dart';
import 'package:lettutor/services/models/tutor.dart';
import 'package:lettutor/widgets/custom_avatar.dart';

class TutorListView extends StatefulWidget {
  final String? specialties;
  const TutorListView({super.key, this.specialties});
  @override
  State<TutorListView> createState() => _TutorListViewState();
}

class _TutorListViewState extends State<TutorListView> {
  @override
  TutorListView get widget => super.widget;
  List<Tutor> data = [];
  bool isLoading = true;
  bool isLoadMore = false;
  int page = 1;
  int perPage = 10;

  late ScrollController _scrollController;
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

  void getListTutor(int page, int size) async {
    List<Tutor>? response = await TutorFunctions.getTutorList(
      page,
      size,
    );
    if (mounted) {
      setState(() {
        data.addAll(response!);
        isLoading = false;
      });
    }
  }

  void loadMore() async {
    if (_scrollController.position.extentAfter < page * perPage) {
      setState(() {
        isLoadMore = true;
        page++;
      });

      try {
        List<Tutor>? response =
            await TutorFunctions.getTutorList(page, perPage);
        if (mounted) {
          setState(() {
            data.addAll(response!);
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
    if (isLoading) {
      getListTutor(page, perPage);
    }

    if (data.isEmpty) return Container();

    List<Tutor> values = <Tutor>[];

    if (widget.specialties == 'All' || widget.specialties == null) {
      values = data;
    } else {
      for (Tutor tutor in data) {
        if (tutor.specialties!
            .toLowerCase()
            .contains(widget.specialties!.toLowerCase())) {
          values.add(tutor);
        }
      }
    }
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : ListView.builder(
            itemCount: values.length,
            padding: const EdgeInsets.all(10.0),
            controller: _scrollController,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: <Widget>[
                  TutorListItem(
                    userId: values[index].userId,
                    avatar: CustomAvatar(
                      imgUrl: values[index].avatar,
                    ),
                    name: values[index].name,
                    bio: values[index].bio,
                    specialties: values[index].specialties,
                    rating: values[index].rating,
                    feedbacks: values[index].feedbacks,
                  ),
                ],
              );
            },
          );
  }
}
