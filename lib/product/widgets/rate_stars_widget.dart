import 'package:flutter/material.dart';

class RateStars extends StatelessWidget {
  int starCount;
  int? voleCount;
  RateStars({Key? key, required this.starCount, required this.voleCount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: List.generate(
              5,
              (indexStar) => Icon(
                    Icons.star,
                    size: 14,
                    color: indexStar + 1 <= starCount
                        ? Colors.amber
                        : Colors.black.withOpacity(0.2),
                  )),
        ),
        Opacity(opacity: 0.8, child: Text(" ($voleCount)"))
      ],
    );
  }
}
