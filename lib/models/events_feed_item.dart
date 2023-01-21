class EventFeedItemModel {
  String title;
  String desc;
  int registeredPeople;
  String imgUrl;
  double height;
  double width;
  String id;
  DateTime dateTime;
  EventFeedItemModel(
      {required this.id,
      required this.title,
      required this.desc,
      required this.registeredPeople,
      required this.dateTime,
      required this.imgUrl,
      required this.height,
      required this.width});
}
