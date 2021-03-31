class Record {
  final String id;
  final String content;
  final String author;
  int isLiked;

  static final columns = ["id", "author", "content", "isLiked"];

  Record(
    this.id,
    this.content,
    this.author,
    this.isLiked,
  );

  factory Record.fromMap(Map<String, dynamic> data) {
    return Record(
      data['id'],
      data['content'],
      data['author'],
      data['isLiked'],
    );
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "author": author,
        "content": content,
        "isLiked": isLiked,
      };
}
