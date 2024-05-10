import 'package:flutter/material.dart';

class OnTapMoreActions {
  final GestureTapCallback? onAttachDoc;
  final GestureTapCallback? onTapScheduleShift;
  final GestureTapCallback? onTapSendMoney;
  final GestureTapCallback? onTapSendMedia;
  final GestureTapCallback? onTapLocation;
  final GestureTapCallback? onTapPeople;

  OnTapMoreActions({
    this.onAttachDoc,
    this.onTapScheduleShift,
    this.onTapSendMoney,
    this.onTapSendMedia,
    this.onTapLocation,
    this.onTapPeople,
  });
}
