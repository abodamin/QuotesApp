// To parse this JSON data, do
//
//     final quotes = quotesFromJson(jsonString);

import 'dart:convert';

Quotes quotesFromJson(String str) => Quotes.fromJson(json.decode(str));

String quotesToJson(Quotes data) => json.encode(data.toJson());

class Quotes {
  Quotes({
    this.count,
    this.totalCount,
    this.lastItemIndex,
    this.results,
  });

  final int count;
  final int totalCount;
  final int lastItemIndex;
  final List<Result> results;

  factory Quotes.fromJson(Map<String, dynamic> json) => Quotes(
        count: json["count"] == null ? null : json["count"],
        totalCount: json["totalCount"] == null ? null : json["totalCount"],
        lastItemIndex:
            json["lastItemIndex"] == null ? null : json["lastItemIndex"],
        results: json["results"] == null
            ? null
            : List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count == null ? null : count,
        "totalCount": totalCount == null ? null : totalCount,
        "lastItemIndex": lastItemIndex == null ? null : lastItemIndex,
        "results": results == null
            ? null
            : List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    this.tags,
    this.id,
    this.content,
    this.author,
    this.isLiked,
    this.length,
  });

  final List<String> tags;
  final String id;
  final String content;
  final String author;
  bool isLiked;
  final int length;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        tags: json["tags"] == null
            ? null
            : List<String>.from(json["tags"].map((x) => x)),
        id: json["_id"] == null ? null : json["_id"],
        content: json["content"] == null ? null : json["content"],
        author: json["author"] == null ? null : json["author"],
        isLiked: json["isLiked"] == null ? null : json["isLiked"],
        length: json["length"] == null ? null : json["length"],
      );

  Map<String, dynamic> toJson() => {
        "tags": tags == null ? null : List<dynamic>.from(tags.map((x) => x)),
        "_id": id == null ? null : id,
        "content": content == null ? null : content,
        "author": author == null ? null : author,
        "length": length == null ? null : length,
      };
}
