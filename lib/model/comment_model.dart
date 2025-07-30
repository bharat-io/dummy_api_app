class CommentsModel {
  List<Comments> comments;
  int total;
  int skip;
  int limit;

  CommentsModel({
    required this.comments,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory CommentsModel.fromJson(Map<String, dynamic> json) {
    List<Comments> commentsList = [];
    for (Map<String, dynamic> eachComment in json["comments"]) {
      commentsList.add(Comments.fromJson(eachComment));
    }
    return CommentsModel(
      comments: commentsList,
      total: json["total"],
      skip: json["skip"],
      limit: json["limit"],
    );
  }
}

class Comments {
  int id;
  String body;
  int postId;
  int likes;
  User user;

  Comments({
    required this.id,
    required this.body,
    required this.postId,
    required this.likes,
    required this.user,
  });

  factory Comments.fromJson(Map<String, dynamic> json) {
    return Comments(
      id: json["id"],
      body: json["body"],
      postId: json["postId"],
      likes: json["likes"],
      user: User.fromJson(json["user"]),
    );
  }
}

class User {
  int id;
  String username;
  String fullName;

  User({
    required this.id,
    required this.username,
    required this.fullName,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      username: json["username"],
      fullName: json["fullName"],
    );
  }
}
