import 'package:flutter/material.dart';
import 'package:lettutor/widgets/star_rating.dart';

class _TuttorDescription extends StatelessWidget {
  const _TuttorDescription({
    required this.name,
    required this.bio,
    required this.specialities,
    required this.rating,
  });

  final String name;
  final String bio;
  final String specialities;
  final double rating;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 2.0)),
              Text(
                bio,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12.0,
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
              Text(
                'Specialitties: $specialities',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.blueAccent,
                ),
              ),
              StarRating(
                color: Colors.yellow,
                rating: rating,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class TuttorListItem extends StatelessWidget {
  const TuttorListItem({
    super.key,
    required this.avatar,
    required this.name,
    required this.bio,
    required this.specialities,
    required this.rating,
  });

  final Widget avatar;
  final String name;
  final String bio;
  final String specialities;
  final double rating;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        height: 120,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1.0,
              child: avatar,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 2.0, 0.0),
                child: _TuttorDescription(
                  name: name,
                  bio: bio,
                  specialities: specialities,
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
    );
  }
}
