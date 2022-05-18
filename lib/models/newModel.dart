import 'package:timeago/timeago.dart' as timeago;
class NewsModel{
  final String source;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final String content;
  String timeAgo;

  NewsModel({
    this.source,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
    this.timeAgo
  });

  factory NewsModel.fromjson(Map<String, dynamic> data) {
    DateTime newsDate = DateTime.parse(data['publishedAt']);
    String minAgo = timeago.format(newsDate);
    print(minAgo);
    return NewsModel(
      source: data['source']['name'],
      title: data['title'],
      description: data['description'],
      url: data['url'],
      urlToImage: data['urlToImage'],
      publishedAt: data['publishedAt'],
      content: data['content'],
      timeAgo: minAgo
    );
  }
}