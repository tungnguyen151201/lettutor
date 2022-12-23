import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lettutor/services/functions/tutor_functions.dart';
import 'package:lettutor/services/models/tutor.dart';
import 'package:lettutor/services/settings/countries_list.dart';
import 'package:lettutor/widgets/custom_avatar.dart';
import 'package:lettutor/widgets/star_rating.dart';

class MainInfo extends StatefulWidget {
  const MainInfo({Key? key, required this.tutor}) : super(key: key);

  final Tutor tutor;

  @override
  State<MainInfo> createState() => _MainInfoState();
}

class _MainInfoState extends State<MainInfo> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      isFavorite = widget.tutor.isFavorite ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(bottom: 10, right: 15),
                height: 60,
                width: 60,
                child: CustomAvatar(
                  imgUrl: widget.tutor.avatar,
                  height: 70,
                  width: 70,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      widget.tutor.name ?? '',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w400),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      countryList[widget.tutor.country] ?? '',
                      style: const TextStyle(fontSize: 15),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Column(crossAxisAlignment: CrossAxisAlignment.end, children: <Widget>[
          StarRating(
            color: Colors.yellow,
            rating: widget.tutor.rating ?? 0,
          ),
          Container(
            margin: const EdgeInsets.only(top: 8, right: 8),
            child: GestureDetector(
              onTap: () async {
                if (widget.tutor.isFavorite != null && !isFavorite) {
                  final res = await TutorFunctions.manageFavoriteTutor(
                      widget.tutor.userId);
                  if (res) {
                    setState(() {
                      isFavorite = true;
                    });
                  }
                } else {
                  final res = await TutorFunctions.manageFavoriteTutor(
                      widget.tutor.userId);
                  if (res) {
                    setState(() {
                      isFavorite = false;
                    });
                  }
                }
              },
              child: !isFavorite
                  ? SvgPicture.asset(
                      "asset/svg/ic_heart.svg",
                      width: 35,
                      height: 35,
                      color: Colors.pink,
                    )
                  : SvgPicture.asset(
                      "asset/svg/ic_heart_fill.svg",
                      width: 35,
                      height: 35,
                      color: Colors.pink,
                    ),
            ),
          )
        ])
      ],
    );
  }
}
