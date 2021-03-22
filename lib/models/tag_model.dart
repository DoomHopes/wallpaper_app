class Tag {
  Tag({
    this.type,
    this.title,
  });

  String type;
  String title;

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        type: json["type"],
        title: json["title"],
      );
}
