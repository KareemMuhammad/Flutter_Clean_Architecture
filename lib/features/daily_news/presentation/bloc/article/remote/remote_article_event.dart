abstract class RemoteArticlesEvent {
  const RemoteArticlesEvent();
}

class GetArticles extends RemoteArticlesEvent {
  const GetArticles();
}

class RefreshArticles extends RemoteArticlesEvent {
  const RefreshArticles();
}