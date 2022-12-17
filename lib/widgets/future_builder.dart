import 'package:flutter/material.dart';
import 'package:lettutor/services/functions/tutor_functions.dart';
import 'package:lettutor/services/models/tutor.dart';
import 'package:lettutor/widgets/tutor_list_item.dart';

var futureBuilder = FutureBuilder(
  future: TutorFunctions.getTutorList(),
  builder: (BuildContext context, AsyncSnapshot snapshot) {
    switch (snapshot.connectionState) {
      case ConnectionState.none:
      case ConnectionState.waiting:
        return const Text('loading...');
      default:
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return createListView(context, snapshot);
        }
    }
  },
);

Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
  List<Tutor> values = snapshot.data;
  return ListView.builder(
    itemCount: values.length,
    padding: const EdgeInsets.all(10.0),
    itemBuilder: (BuildContext context, int index) {
      return Column(
        children: <Widget>[
          TutorListItem(
            avatar: Image.network(values[index].avatar ?? ''),
            name: values[index].name,
            bio: values[index].bio,
            specialties: values[index].specialties,
            rating: values[index].rating,
          ),
        ],
      );
    },
  );
}
