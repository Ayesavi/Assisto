import 'dart:async';

/// A stream that queues events added before any listeners are present.
///
/// This is useful for situations where events might be produced before
/// there's a listener ready to consume them. The queued events will be
/// dispatched to the first listener that subscribes.
class QueuedStream<T> {
  final StreamController<T> _controller = StreamController<T>.broadcast();
  final List<T> _eventQueue = [];

  /// Adds an event to the stream.
  ///
  /// If there are active listeners, the event is added to the stream immediately.
  /// Otherwise, the event is queued and will be dispatched when the first
  /// listener subscribes.
  void add(T event) {
    if (_controller.hasListener) {
      _controller.sink.add(event);
    } else {
      _eventQueue.add(event);
    }
  }

  /// The stream of events.
  Stream<T> get stream => _controller.stream;

  /// Listens to the stream of events.
  ///
  /// Any events that were queued before the listener subscribed will be
  /// dispatched immediately.
  StreamSubscription<T> listen(Function(T) onData) {
    final subscription = _controller.stream.listen(onData);
    for (var event in _eventQueue) {
      _controller.add(event);
    }
    _eventQueue.clear();
    return subscription;
  }

  /// Closes the stream.
  ///
  /// No further events can be added to the stream after it has been closed.
  void close() {
    _controller.close();
  }
}
