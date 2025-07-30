import 'package:flutter/material.dart';
import 'package:api_testing_app/api_service.dart';
import 'package:api_testing_app/model/comment_model.dart';
import 'package:api_testing_app/util/app_contant.dart';

class CommentsScreen extends StatelessWidget {
  const CommentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ApiService apiService = ApiService();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Comments Data"),
      ),
      body: FutureBuilder<CommentsModel?>(
        future: apiService.getData<CommentsModel>(
          url: "${AppContant.baseUrl}/comments",
          fromjson: (json) => CommentsModel.fromJson(json),
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print("Error: ${snapshot.hasError}");
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData && snapshot.data != null) {
            final comments = snapshot.data!.comments;

            return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: comments.length,
              itemBuilder: (context, index) {
                final comment = comments[index];

                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          comment.user.fullName ?? "No Name",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          comment.user.username ?? "No Email",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        const Divider(height: 16),
                        Text(
                          comment.body ?? "No Comment",
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return const Center(child: Text("No comments available."));
        },
      ),
    );
  }
}
