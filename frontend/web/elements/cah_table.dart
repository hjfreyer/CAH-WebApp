import 'package:polymer/polymer.dart';

import 'base.dart';

@CustomTag('cah-table')
class TableElement extends CahElement {
  @published String gameId;
  @published String playerId;

  @observable List<String> whiteCards;
  @observable List<String> blackCards;

  @observable var handResponse;

  TableElement.created() : super.created();
}
