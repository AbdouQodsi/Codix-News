class Post {
  final int id;
  final String title;
  final String content;
  final List<String> categories;
  final String featuredMedia;
  final String date;

  Post({
    required this.id,
    required this.title,
    required this.content,
    required this.categories,
    required this.featuredMedia,
    required this.date,
  });
}
