class FeedItemModel{
  String authorName;
  String caption;
  int likes;
  String imgUrl;
  double height;
  double width;
  String id;
  FeedItemModel(
      {
        required this.id,
        required this.authorName,
        required this.caption,
        required this.likes,
        required this.imgUrl,
        required this.height,
        required this.width}
      );
}