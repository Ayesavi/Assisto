import 'dart:async';

class Debouncer {
  final Duration delay;
  Timer? _timer;

  Debouncer({required this.delay});

  void call(Function action) {
    _timer?.cancel();
    _timer = Timer(delay, () {
      action();
    });
  }

  void cancel() {
    _timer?.cancel();
  }
}