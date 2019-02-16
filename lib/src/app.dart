import 'package:flutter/material.dart';
import 'screens/news_list.dart';
import 'screens/news_detail.dart';
import 'blocs/stories_provider.dart';
import 'blocs/comments_provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CommentsProvider(
      child: StoriesProvider(
        child: MaterialApp(title: 'News!', onGenerateRoute: routes),
      ),
    );
  }

  Route routes(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(builder: (context) {
        final storiesBloc = StoriesProvider.of(context);
        storiesBloc.fetchTopIds();
        
        return NewsList();
      });
    }
    return MaterialPageRoute(builder: (context) {
      /* Ótimo lugar para fazer inicializações e
      chamas em APIs para buscar dados */
      final commentsBloc = CommentsProvider.of(context);
      final itemId = int.parse(settings.name.replaceFirst('/', ''));

      /* Não esperamos por isso finalizar, vamos no async mesmo */
      commentsBloc.fetchItemWithComments(itemId);

      return NewsDetail(
        itemId: itemId,
      );
    });
  }
}
