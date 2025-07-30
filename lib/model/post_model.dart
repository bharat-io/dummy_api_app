class PostModel {
  int limit;
  List<Posts> posts;
  int skip;
  int total;
  PostModel(
      {required this.limit,
      required this.posts,
      required this.skip,
      required this.total});

  //from json

  factory PostModel.fromJson(Map<String, dynamic> json) {
    List<Posts> postList = [];
    for (Map<String, dynamic> eachPost in json["posts"]) {
      var eachModel = Posts.fromJson(eachPost);
      postList.add(eachModel);
    }
    return PostModel(
        limit: json["limit"],
        posts: postList,
        skip: json["skip"],
        total: json["total"]);
  }
}

class Posts {
  String body;
  int id;
  Reaction reactions;
  List<String> tags;
  String title;
  int userId;
  int views;

  Posts(
      {required this.body,
      required this.id,
      required this.reactions,
      required this.tags,
      required this.title,
      required this.userId,
      required this.views});

  factory Posts.fromJson(Map<String, dynamic> json) {
    return Posts(
        body: json["body"],
        id: json["id"],
        reactions: Reaction.fromJson(json["reactions"]),
        tags: List<String>.from(json["tags"]),
        title: json["title"],
        userId: json["userId"],
        views: json["views"]);
  }

  //fromJson
}

class Reaction {
  int likes;
  int dislikes;
  Reaction({required this.likes, required this.dislikes});

  // fromJson

  factory Reaction.fromJson(Map<String, dynamic> json) {
    return Reaction(
      likes: json["likes"],
      dislikes: json["dislikes"],
    );
  }
}
