import 'package:api_testing_app/api_service.dart';
import 'package:api_testing_app/model/post_model.dart';
import 'package:api_testing_app/util/app_contant.dart';
import 'package:flutter/material.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  ApiService apiService = ApiService();
  @override
  void initState() {
    super.initState();
    // apiService.getPost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Posts Data"),
        ),
        body: FutureBuilder(
            future: apiService.getData<PostModel>(
              url: "${AppContant.baseUrl}/posts",
              fromjson: (json) => PostModel.fromJson(json),
            ),
            builder: (context, AsyncSnapshot<PostModel?> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("Error: ${snapshot.hasError}"),
                );
              } else if (snapshot.hasData) {
                final posts = snapshot.data!.posts;
                return ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      final post = posts[index];
                      return Card(
                          margin: EdgeInsets.only(left: 10, right: 10, top: 15),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    post.title,
                                    style: TextStyle(fontSize: 21),
                                  ),
                                  Text(
                                    post.body,
                                    maxLines: 3,
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.thumb_up_alt_outlined,
                                            size: 18,
                                          ),
                                          SizedBox(
                                            width: 6,
                                          ),
                                          Text(post.reactions.likes.toString()),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 16,
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.thumb_down_alt_outlined,
                                            size: 18,
                                          ),
                                          SizedBox(
                                            width: 6,
                                          ),
                                          Text(post.reactions.dislikes
                                              .toString()),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 150,
                                      ),
                                      Text("#${post.tags.last}"),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ));
                    });
              }
              return Container();
            }));
  }
}
