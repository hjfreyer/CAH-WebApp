import 'dart:async';
import 'dart:convert';

import 'package:polymer/polymer.dart';

import 'base.dart';

@CustomTag('join-game')
class JoinGameElement extends CahElement {
  @observable String gameId;

  JoinGameElement.created() : super.created();
}
