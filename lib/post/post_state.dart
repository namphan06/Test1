import 'post.dart';
import 'package:equatable/equatable.dart';

enum PostStatus {
  initial,
  loading,
  success,
  failure,
}

class PostState {
  final PostStatus status;
  final List<Post> posts;
  final String errorMessage;

  const PostState({
    required this.status,
    required this.posts,
    required this.errorMessage,
  });

  factory PostState.initial() {
    return const PostState(
      status: PostStatus.initial,
      posts: [],
      errorMessage: '',
    );
  }

  PostState copyWith({
    PostStatus? status,
    List<Post>? posts,
    String? errorMessage,
  }) {
    return PostState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, posts, errorMessage];
}