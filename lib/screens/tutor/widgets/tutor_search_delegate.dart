import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lettutor/providers/app_provider.dart';
import 'package:lettutor/screens/tutor/widgets/tutor_list_item.dart';
import 'package:lettutor/services/functions/tutor_functions.dart';
import 'package:lettutor/services/models/tutor.dart';
import 'package:lettutor/widgets/custom_avatar.dart';
import 'package:provider/provider.dart';

typedef TutorChangeCallback = void Function(String tutorName);

class TutorSearchDelegate extends SearchDelegate {
// first overwrite to
// clear the search text
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

// second overwrite to pop out of search menu
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

// third overwrite to show query result
  @override
  Widget buildResults(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    final lang = appProvider.language;

    return FutureBuilder(
      future: TutorFunctions.searchTutor(1, 10, search: query),
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
              List<Tutor> matchQuery = [];
              for (Tutor tutor in snapshot.data) {
                if (tutor.name!.toLowerCase().contains(query.toLowerCase())) {
                  matchQuery.add(tutor);
                }
              }
              return matchQuery.isEmpty
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "asset/svg/ic_notfound.svg",
                              width: 200,
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              child: Text(
                                lang.errNotAnyResult,
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: matchQuery.length,
                      itemBuilder: (context, index) {
                        Tutor result = matchQuery[index];
                        return Column(
                          children: <Widget>[
                            TutorListItem(
                              userId: result.userId,
                              avatar: CustomAvatar(
                                imgUrl: result.avatar,
                              ),
                              name: result.name,
                              bio: result.bio,
                              specialties: result.specialties,
                              rating: result.rating,
                              feedbacks: result.feedbacks,
                            ),
                          ],
                        );
                      },
                    );
            }
        }
      },
    );
  }

// last overwrite to show the
// querying process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    final lang = appProvider.language;

    return FutureBuilder(
      future: TutorFunctions.searchTutor(1, 10, search: query),
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
              List<Tutor> matchQuery = [];
              for (Tutor tutor in snapshot.data) {
                if (tutor.name!.toLowerCase().contains(query.toLowerCase())) {
                  matchQuery.add(tutor);
                }
              }
              return matchQuery.isEmpty
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "asset/svg/ic_notfound.svg",
                              width: 200,
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              child: Text(
                                lang.errNotAnyResult,
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: matchQuery.length,
                      itemBuilder: (context, index) {
                        Tutor result = matchQuery[index];
                        return Column(
                          children: <Widget>[
                            TutorListItem(
                              userId: result.userId,
                              avatar: CustomAvatar(
                                imgUrl: result.avatar,
                              ),
                              name: result.name,
                              bio: result.bio,
                              specialties: result.specialties,
                              rating: result.rating,
                              feedbacks: result.feedbacks,
                            ),
                          ],
                        );
                      },
                    );
            }
        }
      },
    );
  }
}
