import 'post.dart';
import 'post_api.dart';
import 'post_reponsitory.dart';

class PostRepositoryImpl implements PostRepository {
  final PostApi _postApi;

  PostRepositoryImpl(this._postApi);

  @override
  Future<List<Post>> getPosts() async {
    final response = await _postApi.getPosts();
    return response;
  }

  @override
  Future<Post> createPost(Post post) async {
    final response = await _postApi.createPost(post);
    return response;
  }

  @override
  Future<Post> getPostById(String id) async {
    final response = await _postApi.getPostById(int.parse(id));
    return response;
  }

  @override
  Future<Post> updatePost(Post post) async {
    final response = await _postApi.updatePost(int.parse(post.id), post);
    return response;
  }

  @override
  Future<void> deletePost(int id) async {
    await _postApi.deletePost(id);
  }
}