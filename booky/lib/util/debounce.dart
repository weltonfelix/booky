import 'dart:async';

class Debouncer {
  Debouncer({this.waitTimeMs = 300, required this.callback});

  final int waitTimeMs;
  final Function callback;

  Timer? _timer;

  void debounce(value) {
    if (_timer?.isActive ?? false) _timer?.cancel();
    _timer = Timer(Duration(milliseconds: waitTimeMs), () {
      callback(value);
    });
  }

  void dispose() {
    _timer?.cancel();
  }
}
