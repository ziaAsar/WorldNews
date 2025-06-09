// // To parse this JSON data, do
// //
// //     final newsChannelHeadlinesModels = newsChannelHeadlinesModelsFromJson(jsonString);
//
// import 'dart:convert';
//
// NewsChannelHeadlinesModels newsChannelHeadlinesModelsFromJson(String str) => NewsChannelHeadlinesModels.fromJson(json.decode(str));
//
// String newsChannelHeadlinesModelsToJson(NewsChannelHeadlinesModels data) => json.encode(data.toJson());
//
// class NewsChannelHeadlinesModels {
//   String status;
//   int totalResults;
//   List<Article> articles;
//
//   NewsChannelHeadlinesModels({
//     required this.status,
//     required this.totalResults,
//     required this.articles,
//   });
//
//   factory NewsChannelHeadlinesModels.fromJson(Map<String, dynamic> json) => NewsChannelHeadlinesModels(
//     status: json["status"],
//     totalResults: json["totalResults"],
//     articles: List<Article>.from(json["articles"].map((x) => Article.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "status": status,
//     "totalResults": totalResults,
//     "articles": List<dynamic>.from(articles.map((x) => x.toJson())),
//   };
// }
//
// class Article {
//   Source source;
//   Author author;
//   String title;
//   String description;
//   String url;
//   String urlToImage;
//   DateTime publishedAt;
//   String content;
//
//   Article({
//     required this.source,
//     required this.author,
//     required this.title,
//     required this.description,
//     required this.url,
//     required this.urlToImage,
//     required this.publishedAt,
//     required this.content,
//   });
//
//   factory Article.fromJson(Map<String, dynamic> json) => Article(
//     source: Source.fromJson(json["source"]),
//     author: authorValues.map[json["author"]]!,
//     title: json["title"],
//     description: json["description"],
//     url: json["url"],
//     urlToImage: json["urlToImage"],
//     publishedAt: DateTime.parse(json["publishedAt"]),
//     content: json["content"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "source": source.toJson(),
//     "author": authorValues.reverse[author],
//     "title": title,
//     "description": description,
//     "url": url,
//     "urlToImage": urlToImage,
//     "publishedAt": publishedAt.toIso8601String(),
//     "content": content,
//   };
// }
//
// enum Author {
//   BBC_NEWS
// }
//
// final authorValues = EnumValues({
//   "BBC News": Author.BBC_NEWS
// });
//
// class Source {
//   Id id;
//   Author name;
//
//   Source({
//     required this.id,
//     required this.name,
//   });
//
//   factory Source.fromJson(Map<String, dynamic> json) => Source(
//     id: idValues.map[json["id"]]!,
//     name: authorValues.map[json["name"]]!,
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": idValues.reverse[id],
//     "name": authorValues.reverse[name],
//   };
// }
//
// enum Id {
//   BBC_NEWS
// }
//
// final idValues = EnumValues({
//   "bbc-news": Id.BBC_NEWS
// });
//
// class EnumValues<T> {
//   Map<String, T> map;
//   late Map<T, String> reverseMap;
//
//   EnumValues(this.map);
//
//   Map<T, String> get reverse {
//     reverseMap = map.map((k, v) => MapEntry(v, k));
//     return reverseMap;
//   }
// }

class NewsChannelHeadlinesModels {
  String? status;
  int? totalResults;
  List<Articles>? articles;

  NewsChannelHeadlinesModels({this.status, this.totalResults, this.articles});

  NewsChannelHeadlinesModels.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalResults = json['totalResults'];
    if (json['articles'] != null) {
      articles = <Articles>[];
      json['articles'].forEach((v) {
        articles!.add(new Articles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['totalResults'] = this.totalResults;
    if (this.articles != null) {
      data['articles'] = this.articles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Articles {
  Source? source;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? publishedAt;
  String? content;

  Articles(
      {this.source,
        this.author,
        this.title,
        this.description,
        this.url,
        this.urlToImage,
        this.publishedAt,
        this.content});

  Articles.fromJson(Map<String, dynamic> json) {
    source =
    json['source'] != null ? new Source.fromJson(json['source']) : null;
    author = json['author'];
    title = json['title'];
    description = json['description'];
    url = json['url'];
    urlToImage = json['urlToImage'];
    publishedAt = json['publishedAt'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.source != null) {
      data['source'] = source!.toJson();
    }
    data['author'] = this.author;
    data['title'] = this.title;
    data['description'] = this.description;
    data['url'] = this.url;
    data['urlToImage'] = this.urlToImage;
    data['publishedAt'] = this.publishedAt;
    data['content'] = this.content;
    return data;
  }
}

class Source {
  String? id;
  String? name;

  Source({this.id, this.name});

  Source.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
