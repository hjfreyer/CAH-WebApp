/// Raises a 'remote-update' event when we should refresh our view from the
/// server.
///
/// TODO(hjfreyer): Use the channel api rather than periodic polling.

import 'dart:async';
import 'package:polymer/polymer.dart';

@CustomTag('cah-poller')
class PollerElement extends PolymerElement {
  Timer pollTimer;

  PollerElement.created(): super.created() {
    pollTimer = new Timer.periodic(new Duration(seconds: 1), poll);
  }

  void detached() {
    pollTimer.cancel();
  }

  void poll(timer) {
    fire('remote-update', detail: {});
  }
}
