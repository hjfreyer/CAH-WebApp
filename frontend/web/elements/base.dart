import 'dart:async';
import 'dart:convert';
import 'dart:html';

import 'package:polymer/polymer.dart';

class CahElement extends PolymerElement {
  CahElement.created(): super.created();

  String stringify(obj) => JSON.encode(obj);
}

class Decks {
  static final Decks _singleton = new Decks._internal();

  Future<List<String>> whiteCards;
  Future<List<String>> blackCards;

  factory Decks() {
    return _singleton;
  }

  Decks._internal() {
    whiteCards = HttpRequest.getString('/data/white_cards.json')
      .then(parseList);
    blackCards = HttpRequest.getString('/data/black_cards.json')
      .then(parseList);
  }

  List<String> parseList(String s) {
    return (List<String>) JSON.decode(s);
  }
}
