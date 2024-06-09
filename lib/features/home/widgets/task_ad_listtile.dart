import 'package:assisto/shimmering/shimmering_task_tile.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class TaskAdListTile extends StatefulWidget {
  final String adId;

  const TaskAdListTile({super.key, required this.adId});

  @override
  _TaskAdListTileState createState() => _TaskAdListTileState();
}

class _TaskAdListTileState extends State<TaskAdListTile> {
  late BannerAd _bannerAd;
  bool _isAdLoaded = false;

  @override
  void initState() {
    super.initState();
    _bannerAd = BannerAd(
      adUnitId: widget.adId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
    );

    _bannerAd.load();
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isAdLoaded
        ? ListTile(
            title: Center(
                child: SizedBox(
            height: 50, // Set appropriate height for the banner ad
            child: AdWidget(ad: _bannerAd),
          )))
        : const ShimmeringTaskTile();
  }
}
