import 'package:assisto/core/admob/ad_units.dart';
import 'package:assisto/core/analytics/analytics_events.dart';
import 'package:assisto/core/analytics/app_analytics.dart';
import 'package:assisto/core/extensions/datetime_extension.dart';
import 'package:assisto/core/extensions/string_extension.dart';
import 'package:assisto/core/respositories/task_repository/base_task_repository.dart';
import 'package:assisto/core/theme/theme_constants.dart';
import 'package:assisto/core/utils/string_constants.dart';
import 'package:assisto/models/task_model.dart/task_model.dart';
import 'package:assisto/widgets/app_filled_button.dart';
import 'package:assisto/widgets/text_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:readmore/readmore.dart';
import 'package:url_launcher/url_launcher.dart';

class TaskProfilePageView extends ConsumerStatefulWidget {
  final TaskModel model;
  final BidInfo? bidInfo;
  final Future<void> Function()? onPressMarkAsCompleted;

  const TaskProfilePageView(this.model,
      {this.bidInfo, super.key, this.onPressMarkAsCompleted});

  @override
  _TaskProfilePageViewState createState() => _TaskProfilePageViewState();
}

class _TaskProfilePageViewState extends ConsumerState<TaskProfilePageView> {
  late BannerAd _bannerAd;

  @override
  void initState() {
    super.initState();
    _bannerAd = BannerAd(
      adUnitId: AdUnits.taskProfileAdUnit.unitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {},
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
        },
      ),
    )..load();
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    super.dispose();
  }

  String generateGoogleMapsUrl(double latitude, double longitude) {
    return 'https://www.google.com/maps/dir/?api=1&destination=$latitude,$longitude';
  }

  @override
  Widget build(BuildContext context) {
    final model = widget.model;
    final bidInfo = widget.bidInfo;
    final isTaskAssigned = model.status != TaskStatus.unassigned;

    return SingleChildScrollView(
      child: Padding(
        padding: kWidgetHorizontalPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleLarge(
              text: model.title.capitalize,
              weight: FontWeight.bold,
              maxLines: 5,
            ),
            kWidgetMinVerticalGap,
            ReadMoreText(model.description.capitalize),
            if (model.address != null ||
                model.deadline != null ||
                model.expectedPrice != null ||
                model.ageGroup != null)
              CupertinoListSection(
                backgroundColor: Theme.of(context).colorScheme.surface,
                children: [
                  if (model.address != null)
                    CupertinoListTile(
                      backgroundColor: Theme.of(context).colorScheme.surface,
                      onTap: () async {
                        AppAnalytics.instance.logEvent(
                            name: AnalyticsEvent
                                .taskProfile.locationTaskProfilePressEvent);
                        final url = generateGoogleMapsUrl(
                            model.address!.latlng.lat,
                            model.address!.latlng.lng);
                        if (await canLaunchUrl(Uri.parse(url))) {
                          launchUrl(Uri.parse(url));
                        }
                      },
                      padding: const EdgeInsets.all(5),
                      leading: Icon(Icons.near_me_outlined,
                          color: Theme.of(context).colorScheme.primary),
                      title: const TitleMedium(text: 'Location'),
                      subtitle: BodyMedium(text: model.address!.address),
                      additionalInfo: model.distance != null
                          ? BodyLarge(
                              text: '${model.distance?.toInt().toString()} Kms')
                          : null,
                      trailing: const CupertinoListTileChevron(),
                    ),
                  if (model.deadline != null)
                    CupertinoListTile(
                      backgroundColor: Theme.of(context).colorScheme.surface,
                      padding: const EdgeInsets.all(5),
                      leading: Icon(Icons.lock_clock,
                          color: Theme.of(context).colorScheme.primary),
                      title: const TitleMedium(text: 'Deadline'),
                      additionalInfo:
                          BodyLarge(text: model.deadline!.formattedDateTime()),
                    ),
                  if (model.expectedPrice != null)
                    CupertinoListTile(
                      backgroundColor: Theme.of(context).colorScheme.surface,
                      padding: const EdgeInsets.all(5),
                      leading: Icon(Icons.credit_card,
                          color: Theme.of(context).colorScheme.primary),
                      title: const TitleMedium(text: 'Max Budget'),
                      additionalInfo: BodyLarge(
                          text:
                              '${model.expectedPrice!.toString().capitalize} $kRupeeSymbol'),
                    ),
                  if (model.ageGroup != null)
                    CupertinoListTile(
                      backgroundColor: Theme.of(context).colorScheme.surface,
                      padding: const EdgeInsets.all(5),
                      leading: Icon(Icons.person_outline_outlined,
                          color: Theme.of(context).colorScheme.primary),
                      title: const TitleMedium(text: 'Only Age Between'),
                      additionalInfo: BodyLarge(
                          text:
                              '${model.ageGroup!.toString().replaceAll('-', ' to ').capitalize} years'),
                    ),
                ],
              ),
            // CupertinoListSection(
            //   header: const TitleLarge(text: 'Tags', weight: FontWeight.bold),
            //   backgroundColor: Theme.of(context).colorScheme.surface,
            //   children: [
            //     CupertinoListTile(
            //       padding: const EdgeInsets.all(5),
            //       leading: Icon(Icons.tag,
            //           color: Theme.of(context).colorScheme.primary),
            //       title: Wrap(
            //         spacing: 8.0,
            //         children: [
            //           ...model.tags.map(
            //             (tag) => Chip(
            //               side: BorderSide.none,
            //               backgroundColor:
            //                   Theme.of(context).colorScheme.primary.tone(80),
            //               label: Text(
            //                 tag,
            //                 style: TextStyle(
            //                     color: Theme.of(context).colorScheme.onPrimary,
            //                     fontWeight: FontWeight.bold),
            //               ),
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ],
            // ),
            kWidgetVerticalGap,
            if (bidInfo != null)
              CupertinoListSection(
                header:
                    const TitleLarge(text: 'Bidding', weight: FontWeight.bold),
                backgroundColor: Theme.of(context).colorScheme.surface,
                children: [
                  CupertinoListTile(
                    padding: const EdgeInsets.all(5),
                    leading: Icon(Icons.person_outline_outlined,
                        color: Theme.of(context).colorScheme.primary),
                    title: const TitleMedium(text: 'Your bidding amount'),
                    additionalInfo:
                        BodyLarge(text: '${bidInfo.amount} $kRupeeSymbol'),
                  ),
                ],
              ),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: AdWidget(ad: _bannerAd),
            ),

            kWidgetVerticalGap,
            if (isTaskAssigned &&
                model.isUserTaskUser &&
                ![TaskStatus.blocked, TaskStatus.completed]
                    .contains(model.status))
              AppFilledButton(
                label: 'Mark as completed',
                asyncTap: widget.onPressMarkAsCompleted,
              ),
          ],
        ),
      ),
    );
  }
}
