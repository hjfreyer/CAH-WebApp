import 'dart:convert';

import 'package:polymer/polymer.dart';

@CustomTag('create-game')
class CreateGameElement extends PolymerElement {
  @observable String gameId;

  CreateGameElement.created() : super.created();

  onCreated() => gameId = $['createRpc'].response["gameid"];
}
