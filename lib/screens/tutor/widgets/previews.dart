import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lettutor/services/models/feedback.dart';
import 'package:lettutor/widgets/custom_avatar.dart';
import 'package:lettutor/widgets/star_rating.dart';

class Previews extends StatelessWidget {
  const Previews({Key? key, required this.feedback}) : super(key: key);

  final FeedBack feedback;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 10, right: 15),
                  height: 40,
                  width: 40,
                  child: CustomAvatar(
                    imgUrl: feedback.firstInfo.avatar,
                    height: 70,
                    width: 70,
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          feedback.firstInfo.name,
                          style: const TextStyle(fontSize: 16),
                        ),
                        StarRating(
                          rating: feedback.rating,
                          color: Colors.yellow,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                child: feedback.content.isNotEmpty
                    ? Text(feedback.content)
                    : null),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  DateFormat.yMEd().add_jm().format(
                      DateFormat("yyyy-MM-dd").parse(feedback.createdAt)),
                  style: const TextStyle(color: Colors.grey),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
