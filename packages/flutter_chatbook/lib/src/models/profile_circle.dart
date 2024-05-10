import 'package:flutter/material.dart';

import '../../flutter_chatbook.dart';

class ProfileCircleConfiguration {
  /// Used to give padding to profile circle.
  final EdgeInsetsGeometry? padding;

  /// Provides image url of user
  final String? profileImageUrl;

  /// Used for give bottom padding to profile circle
  final double? bottomPadding;

  /// Used for give circle radius to profile circle
  final double? circleRadius;



  const ProfileCircleConfiguration({
    this.padding,
    this.profileImageUrl,
    this.bottomPadding,
    this.circleRadius,
  });
}
