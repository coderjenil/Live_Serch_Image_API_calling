class Images
{
  String url;
  int width;
  int height;
  int size;
  int views;
  int downloads;
  int likes;
  String userName;
  String userImageUrl;

  Images({
    required this.url,
    required this.width,
    required this.height,
    required this.size,
    required this.views,
    required this.downloads,
    required this.likes,
    required this.userName,
    required this.userImageUrl,
});

  factory Images.fromJson(Map<String , dynamic> json){
    return Images(
      url: json['largeImageURL'],
      width: json['imageWidth'],
      height: json['imageHeight'],
      size: json['imageSize'],
      views: json['views'],
      downloads: json['downloads'],
      likes: json['likes'],
      userName: json['user'],
      userImageUrl: json['userImageURL'],
    );
  }
}