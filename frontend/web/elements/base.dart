import 'dart:convert';

import 'package:polymer/polymer.dart';

class CahElement extends PolymerElement {
  CahElement.created(): super.created();

  String stringify(obj) => JSON.encode(obj);
}
