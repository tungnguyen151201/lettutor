import 'package:flutter/material.dart';
import 'package:lettutor/providers/app_provider.dart';
import 'package:lettutor/screens/tutor/detail.dart';
import 'package:lettutor/services/models/feedback.dart';
import 'package:lettutor/services/settings/learning_topics.dart';
import 'package:lettutor/widgets/infor_chip.dart';
import 'package:lettutor/widgets/star_rating.dart';
import 'package:provider/provider.dart';

class _TutorDescription extends StatelessWidget {
  const _TutorDescription({
    this.name,
    this.bio,
    this.specialties,
    this.rating,
  });

  final String? name;
  final String? bio;
  final String? specialties;
  final double? rating;

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    final lang = appProvider.language;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                name ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 2.0)),
              Text(
                bio ?? '',
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14.0,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              StarRating(
                color: Colors.yellow,
                rating: rating ?? 0,
              ),
              InforChips(
                  title: lang.specialties,
                  chips: listLearningTopics.entries
                      .where((element) =>
                          specialties!.split(",").contains(element.key))
                      .map((e) => e.value)
                      .toList()),
            ],
          ),
        ),
      ],
    );
  }
}

class TutorListItem extends StatelessWidget {
  const TutorListItem({
    super.key,
    required this.userId,
    this.avatar,
    this.name,
    this.bio,
    this.specialties,
    this.rating,
    this.feedbacks,
  });

  final String userId;
  final Widget? avatar;
  final String? name;
  final String? bio;
  final String? specialties;
  final double? rating;
  final List<FeedBack>? feedbacks;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              userId: userId,
              feedbacks: feedbacks,
            ),
          ),
        )
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: SizedBox(
          height: 200,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: 80,
                height: 80,
                child: avatar,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 2.0, 0.0),
                  child: _TutorDescription(
                    name: name,
                    bio: bio,
                    specialties: specialties,
                    rating: rating,
                  ),
                ),
              ),
              const Icon(
                Icons.more_vert,
                size: 16.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
