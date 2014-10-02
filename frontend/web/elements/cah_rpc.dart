import 'dart:convert';

import 'package:polymer/polymer.dart';

import "../config.dart";
import "base.dart";

@CustomTag('cah-rpc')
class RpcElement extends CahElement {
  @published bool auto = false;
  @published String action;
  @published var params;
  @published var response;

  RpcElement.created() : super.created();

  attached() {
    if (auto) {
      go();
    }
  }

  go() {
    var rpc = $['rpc'];
    rpc.url = RPC_ENDPOINT;

    var internalParams = {};
    if (action != null) {
      internalParams['action'] = action;
    }

    params.forEach((k, v) {
      internalParams[k] = v;
    });

    rpc.params = JSON.encode(internalParams);
    rpc.go();
  }
}
