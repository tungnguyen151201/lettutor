import 'package:cached_network_image/cached_network_image.dart';
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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: TutorFunctions.getTutorList(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return const Center(
              child: CircularProgressIndicator(),
            );
          default:
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return createListView(context, snapshot, widget.specialties);
            }
        }
      },
    );
  }

  Widget createListView(
      BuildContext context, AsyncSnapshot snapshot, String? specialties) {
    List<Tutor>? data = snapshot.data;
    if (data == null) return Container();

    List<Tutor> values = <Tutor>[];

    if (specialties == 'All' || specialties == null) {
      values = data;
    } else {
      for (Tutor tutor in data) {
        if (tutor.specialties!
            .toLowerCase()
            .contains(specialties.toLowerCase())) {
          values.add(tutor);
        }
      }
    }

    return ListView.builder(
      itemCount: values.length,
      padding: const EdgeInsets.all(10.0),
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
