class Quote {
  final String id;
  final String content;
  final String author;

  const Quote({required this.id, required this.content, required this.author});

  Map<String, String> toMap() {
    return {'id': id, 'content': content, 'author': author};
  }
}
