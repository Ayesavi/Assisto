import 'package:flutter/foundation.dart';

class AdUnits {
  static const taskProfileAdUnit = AdUnit(
    "ca-app-pub-8578806247574371/6091943976",
  );

  static const homeTasksAdUnit = AdUnit(
    "ca-app-pub-8578806247574371/3226209115",
  );
}

class AdUnit {
  /// Real unit Id
  final String _unitId;

  const AdUnit(this._unitId);

  String get unitId =>

      // test id
      kReleaseMode ? _unitId : "ca-app-pub-3940256099942544/6300978111";
}
