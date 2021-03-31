// To parse this JSON data, do
//
//     final tag = tagFromJson(jsonString);

import 'dart:convert';

class Tag {
  Tag({
    this.id,
    this.tags,
    this.content,
    this.author,
    this.length,
  });

  final String id;
  final List<String> tags;
  final String content;
  final String author;
  final int length;

  factory Tag.fromRawJson(String str) => Tag.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        id: json["_id"] == null ? null : json["_id"],
        tags: json["tags"] == null
            ? null
            : List<String>.from(json["tags"].map((x) => x)),
        content: json["content"] == null ? null : json["content"],
        author: json["author"] == null ? null : json["author"],
        length: json["length"] == null ? null : json["length"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "tags": tags == null ? null : List<dynamic>.from(tags.map((x) => x)),
        "content": content == null ? null : content,
        "author": author == null ? null : author,
        "length": length == null ? null : length,
      };
}
