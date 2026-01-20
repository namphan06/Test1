import 'post.dart';

abstract class PostEvent{
  const PostEvent();
}

class LoadPosts extends PostEvent{
  const LoadPosts();
}

class AddPost extends PostEvent{
  final Post post;
  const AddPost(this.post);
}

class UpdatePost extends PostEvent{
  final Post post;
  const UpdatePost(this.post);
}

class DeletePost extends PostEvent{
  final int id;
  const DeletePost(this.id);
}