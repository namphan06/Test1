import 'package:flutter_bloc/flutter_bloc.dart';
import 'post.dart';
import 'post_event.dart';
import 'post_state.dart';
import 'post_reponsitory.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
    final PostRepository _repository;
  PostBloc(this._repository) : super(PostState.initial()) {
    on<LoadPosts>(_onLoadPosts);
    on<AddPost>(_onAddPost);
    on<UpdatePost>(_onUpdatePost);
    on<DeletePost>(_onDeletePost);
  }


  Future<void> _onLoadPosts(LoadPosts event, Emitter<PostState> emit) async {
    emit(state.copyWith(status: PostStatus.loading));
    try {
      final posts = await _repository.getPosts();
      emit(state.copyWith(status: PostStatus.success, posts: posts));
    } catch (e) {
      emit(state.copyWith(status: PostStatus.failure, errorMessage: e.toString()));
    }
  }

  Future<void> _onAddPost(AddPost event, Emitter<PostState> emit) async {
    emit(state.copyWith(status: PostStatus.loading));
    try {
      await _repository.createPost(event.post);
      emit(state.copyWith(status: PostStatus.success));
    } catch (e) {
      emit(state.copyWith(status: PostStatus.failure, errorMessage: e.toString()));
    }
  }

  Future<void> _onUpdatePost(UpdatePost event, Emitter<PostState> emit) async {
    emit(state.copyWith(status: PostStatus.loading));
    try {
      await _repository.updatePost(event.post);
      emit(state.copyWith(status: PostStatus.success));
    } catch (e) {
      emit(state.copyWith(status: PostStatus.failure, errorMessage: e.toString()));
    }
  }

  Future<void> _onDeletePost(DeletePost event, Emitter<PostState> emit) async {
    emit(state.copyWith(status: PostStatus.loading));
    try {
      await _repository.deletePost(event.id);
      emit(state.copyWith(status: PostStatus.success));
    } catch (e) {
      emit(state.copyWith(status: PostStatus.failure, errorMessage: e.toString()));
    }
  }

}