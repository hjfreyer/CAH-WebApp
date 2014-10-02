import 'dart:async';
import 'dart:convert';

import 'package:polymer/polymer.dart';

import 'base.dart';

@CustomTag('create-game')
class CreateGameElement extends CahElement {
  @observable String gameId;

  CreateGameElement.created() : super.created();

  onCreated(e) => gameId = e.detail['response']['gameid'];
}
