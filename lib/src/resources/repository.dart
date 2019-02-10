import 'dart:async';
import 'news_api_provider.dart';
import 'news_db_provider.dart';
import '../models/item_model.dart';

class Repository {
  List<Source> sources = <Source>[
    newsDbProvider,
    NewsApiProvider(),
  ];

  List<Cache> caches = <Cache>[
    newsDbProvider,
  ];

  Future<List<int>> fetchTopIds() {
    // Future<List<int>> topIds;
    // Source s;

    // for (s in sources) {
    //    topIds = s.fetchTopIds();

    //    if (topIds != null) {
    //      return topIds;
    //    }
    // }

    // return null;

    // GAMBIARRA
    return sources[1].fetchTopIds();
  }

  Future<ItemModel> fetchItem(int id) async {
    ItemModel item;
    Source source;

    for (source in sources) {
      item = await source.fetchItem(id);
      if (item != null) {
        break;
      }
    }

    for (Cache cache in caches) {
      /*
      Resolve o problema de pegar de uma Source
      e adicionar no Cache que é a mesma instância,
      como é o caso do NewsDbProvider, que implementa
      tanto o Source quanto o Cache
      */
      if (source != (cache as dynamic)) {
        cache.addItem(item);
      }
    }

    return item;
  }

  clearCache() async {
    ///
    /// @todo: Future.wait([Futures])
    for (var cache in caches) {
      await cache.clear();
    }
  }
}

abstract class Source {
  Future<List<int>> fetchTopIds();
  Future<ItemModel> fetchItem(int id);
}

abstract class Cache {
  Future<int> addItem(ItemModel item);
  Future<int>clear();
}
