import 'post.dart';

abstract class PostRepository {
  Future<List<Post>> getPosts();
  Future<Post> createPost(Post post);
  Future<Post> getPostById(String id);
  Future<Post> updatePost(Post post);
  Future<void> deletePost(int id);
}