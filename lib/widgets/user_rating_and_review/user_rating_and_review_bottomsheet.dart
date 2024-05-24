import 'package:assisto/models/user_model/user_model.dart';
import 'package:assisto/widgets/app_filled_button.dart';
import 'package:assisto/widgets/rating_bar/rating_bar.dart';
import 'package:assisto/widgets/text_widgets.dart';
import 'package:assisto/widgets/user_avatar.dart';
import 'package:flutter/material.dart';

class RatingAndReviewBottomSheet extends StatefulWidget {
  final void Function(int stars, String review) onRatingAndReviews;
  final UserModel userModel;
  final String taskName;
  const RatingAndReviewBottomSheet(
      {super.key,
      required this.userModel,
      required this.taskName,
      required this.onRatingAndReviews});

  @override
  _RatingAndReviewBottomSheetState createState() =>
      _RatingAndReviewBottomSheetState();
}

class _RatingAndReviewBottomSheetState
    extends State<RatingAndReviewBottomSheet> {
  double _rating = 0.0;
  final TextEditingController _reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ListTile(
                title: const TitleLarge(
                  text: 'Rate and Review',
                  weight: FontWeight.bold,
                ),
                subtitle: Text(
                  'Give us your experience with ${widget.userModel.name} for task ${widget.taskName}',
                )),
            ListTile(
                leading: UserAvatar(imageUrl: widget.userModel.avatarUrl),
                title: TitleMedium(text: widget.userModel.name),
                subtitle: widget.userModel.description != null
                    ? Text(
                        widget.userModel.description!,
                      )
                    : null),
            const SizedBox(height: 16.0),
            RatingBar.builder(
              initialRating: _rating,
              minRating: 1,
              glow: false,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
              itemSize: 40.0,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Theme.of(context).colorScheme.primary,
              ),
              onRatingUpdate: (rating) {
                setState(() {
                  _rating = rating;
                });
              },
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _reviewController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Theme.of(context).colorScheme.onInverseSurface,
                hintText: 'Write your review...',
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              maxLines: null,
            ),
            const SizedBox(height: 16.0),
            AppFilledButton(label: 'Submit')
          ],
        ),
      ),
    );
  }
}

void showRatingAndReviewBottomSheet(BuildContext context,
    {required void Function(int stars, String review)? onRatingAndReviews,
    required String taskName,
    required UserModel userModel}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          top: 10,
        ),
        child: RatingAndReviewBottomSheet(
          taskName: taskName,
          onRatingAndReviews:
              onRatingAndReviews ?? (int stars, String review) {},
          userModel: userModel,
        ),
      );
    },
  );
}
