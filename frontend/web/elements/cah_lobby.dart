import 'dart:async';
import 'dart:convert';
import 'package:polymer/polymer.dart';

import 'base.dart';

@CustomTag('cah-lobby')
class LobbyElement extends CahElement {
  Timer pollTimer;

  @published String gameId;
  @published bool owner;

  @observable String name;
  @observable String playerId = null;

  @observable var configResponse;
  @observable var roundResponse;

  LobbyElement.created(): super.created() {
    pollTimer = new Timer.periodic(new Duration(seconds: 1), poll);
  }

  detached() {
    pollTimer.cancel();
  }

  joinGame(e) {
    $['joinRpc'].params = JSON.encode({
      'action': 'register',
      'gameid': gameId,
      'name': name,
      'type': 'web',
      'watcher': 'false',
    });
    $['joinRpc'].go();
    e.preventDefault();
  }

  joined() {
    var resp = $['joinRpc'].response;
    playerId = resp['playerid'];
  }

  poll(timer) {
    $['configRpc'].go();
    $['roundRpc'].go();
    print('poll');
  }

  start() {
    $['startRpc'].go();
  }

  roundResponseChanged() {
    if (roundResponse['blackCard'] != -1 && playerId != null) {
      print('started');
      fire('game-started', detail: {
        'gameId': gameId,
        'playerId': playerId,
      });
    }
  }
}
