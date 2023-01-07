import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:lettutor/providers/app_provider.dart';
import 'package:lettutor/screens/tutor/widgets/tutor_main_info.dart';
import 'package:lettutor/services/functions/tutor_functions.dart';
import 'package:lettutor/services/models/feedback.dart';
import 'package:lettutor/services/models/tutor.dart';
import 'package:lettutor/services/settings/languages_list.dart';
import 'package:lettutor/services/settings/learning_topics.dart';
import 'package:lettutor/screens/tutor/widgets/booking_feature.dart';
import 'package:lettutor/widgets/infor_chip.dart';
import 'package:lettutor/screens/tutor/widgets/previews.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class DetailScreen extends StatefulWidget {
  final String userId;
  final List<FeedBack>? feedbacks;
  const DetailScreen({super.key, required this.userId, this.feedbacks});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  VideoPlayerController? _controller;
  ChewieController? _chewieController;
  bool isLoading = true;
  Tutor? tutor;

  @override
  DetailScreen get widget => super.widget;
  void getTutor() async {
    final tutor = await TutorFunctions.getTutorInfomation(widget.userId);

    setState(() {
      this.tutor = tutor;
      isLoading = false;
      _controller = VideoPlayerController.network(this.tutor!.video as String);
      _chewieController = ChewieController(
        aspectRatio: 3 / 2,
        videoPlayerController: _controller as VideoPlayerController,
        autoPlay: true,
        looping: true,
      );
    });
  }

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
    final appProvider = Provider.of<AppProvider>(context);
    final lang = appProvider.language;

    if (isLoading) {
      getTutor();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lettutor'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
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
                      child: _chewieController != null
                          ? Chewie(
                              controller: _chewieController as ChewieController)
                          : Container(),
                    ),
                    MainInfo(tutor: tutor as Tutor),
                    BookingFeature(tutorId: tutor!.userId),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Text(tutor!.bio ?? '',
                          style: const TextStyle(fontSize: 13)),
                    ),
                    InforChips(
                        title: lang.languages,
                        chips: listLanguages.entries
                            .where((element) => tutor!.languages!
                                .split(",")
                                .contains(element.key))
                            .map((e) => e.value["name"] as String)
                            .toList()),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            lang.interests,
                            style: const TextStyle(
                                fontSize: 17, color: Colors.blue),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            child: Text(
                              (tutor!.interests as String).trim(),
                              style: const TextStyle(
                                  fontSize: 13, color: Colors.grey),
                            ),
                          )
                        ],
                      ),
                    ),
                    InforChips(
                        title: lang.specialties,
                        chips: listLearningTopics.entries
                            .where((element) => tutor!.specialties!
                                .split(",")
                                .contains(element.key))
                            .map((e) => e.value)
                            .toList()),
                    Container(
                      margin: const EdgeInsets.only(bottom: 6, top: 15),
                      child: Text(
                        lang.feedback,
                        style:
                            const TextStyle(fontSize: 17, color: Colors.blue),
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
