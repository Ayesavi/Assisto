import 'package:flutter/material.dart';

class ProfileFormParams {
  final String key;
  final Widget Function(BuildContext context) builder;

  const ProfileFormParams({
    required this.key,
    required this.builder,
  });
}
