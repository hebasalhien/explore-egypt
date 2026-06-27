import 'package:bloc/bloc.dart';
import 'package:explore_egypt/features/trending/model/entities/comment_model.dart';
import 'package:explore_egypt/features/trending/model/repo/comment_repo.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'comment_state.dart';

class CommentCubit extends Cubit<CommentState> {
  final CommentRepo _repo;
  CommentCubit(this._repo) : super(CommentInitial());

  Future<void> getLandmarkComments({required String landmarkId}) async {
    try {
      final response = await _repo.getLandmarkComments(landmarkId: landmarkId);
      List<CommentModel> comments = (response as List)
          .map((e) => CommentModel.fromjson(e))
          .toList();
      if (comments.isEmpty) {
        comments = [];
      }
      emit(CommentLoaded(comments: comments));
    } catch (e) {
      emit(CommentFailure());
    }
  }

  Future<void> addNewComment({
    required String landmarkId,
    required String message,
    required double rating,
  }) async {
    try {
      final response = await _repo.addNewComment(
        landmarkId: landmarkId,
        message: message,
        rating: rating,
      );
      if (response.statusCode == 200) {
        final result = await _repo.getLandmarkComments(landmarkId: landmarkId);
        List<CommentModel> comments = (result as List)
            .map((e) => CommentModel.fromjson(e))
            .toList();
        emit(CommentLoaded(comments: comments));
      } else {
        emit(CommentLoaded(comments: []));
      }
    } catch (e) {
      emit(CommentFailure());
    }
  }
}
