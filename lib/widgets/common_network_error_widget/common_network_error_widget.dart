import 'package:assisto/core/theme/theme_constants.dart';
import 'package:assisto/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CommonNetworkErrorWidget extends StatelessWidget {
  final VoidCallback? onReload;
  const CommonNetworkErrorWidget({super.key, this.onReload});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            SizedBox.square(
              dimension: 200,
              child: SvgPicture.asset(Assets.graphics.serverDown),
            ),
            kWidgetVerticalGap,
            const Text(
              'Can\'t connect to the server, make sure you are connected to the internet!!!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            kWidgetVerticalGap,
            ElevatedButton(onPressed: onReload, child: const Text('Reload'))
          ],
        ),
      ),
    );
  }
}
