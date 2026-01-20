import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'post.dart';

part 'post_api.g.dart';

@RestApi(baseUrl: "https://jsonplaceholder.typicode.com")
abstract class PostApiRetrofit {
  factory PostApiRetrofit(Dio dio) => _PostApiRetrofit(dio);

  @GET("/posts")
  Future<List<Post>> getPosts();

  @POST("/posts")
  Future<Post> createPost(@Body() Post post);

  @GET("/posts/{id}")
  Future<Post> getPostById(@Path("id") int id);

  @PUT("/posts/{id}")
  Future<Post> updatePost(@Path("id") int id, @Body() Post post);

  @DELETE("/posts/{id}")
  Future<void> deletePost(@Path("id") int id);
}

