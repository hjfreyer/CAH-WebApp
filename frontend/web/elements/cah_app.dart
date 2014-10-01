import 'package:polymer/polymer.dart';

import 'package:route/client.dart';

final allUrls = [homeUrl, articleUrl];

class Page {
  final String name;
  final UrlPattern pattern;
  final List<String> paramNames;

  Page(this.name, patternRE, this.paramNames)
    : pattern = new UrlPattern(patternRE);
}

final INDEX = new Page('INDEX', r'/#/', []);
final NEW_GAME = new Page('NEW_GAME', r'/#/create', []);
final JOIN_GAME = new Page('JOIN_GAME', r'/#/g/(.+)/join', ['gameId']);
final TABLE = new Page('TABLE', r'/#/g/(.+)/play/(.+)', ['gameId', 'playerId']);

final PAGES = [INDEX, NEW_GAME, JOIN_GAME, TABLE];
final TITLE = 'Inhumane Cards';

@CustomTag('cah-app')
class CahAppElement extends PolymerElement {
  final Router router = new Router(useFragment: true);

  @observable String pageName;
  @observable Map<String, String> params = {};

  CahAppElement.created()
    : super.created() {
    for (var p in PAGES) {
      router.addHandler(p.pattern, (path) {
        pageName = p.name;
        params = {};
        var parsed = p.pattern.parse(path);
        for (int i = 0; i < p.paramNames.length; i++) {
          params[p.paramNames[i]] = parsed[i];
        }
      });
    }

    router
      ..addHandler(new UrlPattern('/'), (p) => router.gotoPath('/#/', TITLE))
      ..listen();
  }

  gameStarted(event) {
    var d = event.detail;
    router.gotoUrl(TABLE.pattern, [d['gameId'], d['playerId']], TITLE);
  }
}
