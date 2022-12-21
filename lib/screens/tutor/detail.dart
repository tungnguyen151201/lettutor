import 'package:flutter/material.dart';
import 'package:lettutor/services/functions/tutor_functions.dart';
import 'package:lettutor/services/models/feedback.dart';
import 'package:lettutor/services/models/tutor.dart';
import 'package:lettutor/services/settings/languages_list.dart';
import 'package:lettutor/services/settings/learning_topics.dart';
import 'package:lettutor/widgets/infor_chip.dart';
import 'package:lettutor/widgets/previews.dart';
import 'package:lettutor/widgets/tutor_main_info.dart';

class DetailScreen extends StatefulWidget {
  final String userId;
  final List<FeedBack>? feedbacks;
  const DetailScreen({super.key, required this.userId, this.feedbacks});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  DetailScreen get widget => super.widget;
  renderPreviews() {
    if (widget.feedbacks != null) {
      return ListView.builder(
        itemCount: widget.feedbacks?.length,
        itemBuilder: (context, index) {
          return Previews(feedback: widget.feedbacks?[index] as FeedBack);
        },
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: TutorFunctions.getTutorInfomation(widget.userId),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Scaffold(
              appBar: AppBar(
                title: const Text('Lettutor'),
              ),
              body: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Text('Loading...'),
                ],
              ),
            );
          default:
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              Tutor? tutor = snapshot.data;
              return Scaffold(
                appBar: AppBar(
                  title: const Text('Lettutor'),
                ),
                body: SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.only(
                        left: 15, right: 15, top: 10, bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          color: Colors.black,
                          height: 200,
                          margin: const EdgeInsets.only(bottom: 10),
                          // child: _chewieController != null
                          //     ? Chewie(
                          //         controller:
                          //             _chewieController as ChewieController)
                          child: Container(),
                        ),
                        MainInfo(tutor: tutor as Tutor),
                        // BookingFeature(tutorId: tutor.userId),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Text(tutor.bio ?? '',
                              style: const TextStyle(fontSize: 13)),
                        ),
                        InforChips(
                            title: 'Languages',
                            chips: listLanguages.entries
                                .where((element) => tutor.languages!
                                    .split(",")
                                    .contains(element.key))
                                .map((e) => e.value["name"] as String)
                                .toList()),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Interests',
                                style:
                                    TextStyle(fontSize: 17, color: Colors.blue),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 5),
                                child: Text(
                                  (tutor.interests as String).trim(),
                                  style: const TextStyle(
                                      fontSize: 13, color: Colors.grey),
                                ),
                              )
                            ],
                          ),
                        ),
                        InforChips(
                            title: 'Specialties',
                            chips: listLearningTopics.entries
                                .where((element) => tutor.specialties!
                                    .split(",")
                                    .contains(element.key))
                                .map((e) => e.value)
                                .toList()),
                        Container(
                          margin: const EdgeInsets.only(bottom: 6, top: 15),
                          child: const Text(
                            'Previews',
                            style: TextStyle(fontSize: 17, color: Colors.blue),
                          ),
                        ),
                        renderPreviews(),
                      ],
                    ),
                  ),
                ),
              );
            }
        }
      },
    );
  }
}
