class Links {
  String self;
  String html;
  String download;

  Links({this.self, this.download, this.html});

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        self: json["self"],
        html: json["html"],
        download: json["download"],
      );
}
