import 'dart:async';

import 'package:explore_egypt/core/errors/exception.dart';
import 'package:explore_egypt/features/auth/model/repos/auth_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _repo;
  AuthCubit(this._repo) : super(AuthInitial());

  Future<dynamic> login({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      final data = await _repo.login(email: email, password: password);
      emit(AuthSuccess(data));
    }  on ServerException catch (e) {
      emit(AuthError(e.message.message));
    } catch (e) {
      emit(AuthError('An unexpected error occurred'));
    }
  }

  Future<dynamic> register({
    required String email,
    required String username,
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      final data = await _repo.createUser(
        email: email,
        password: password,
        username: username,
      );
      emit(AuthRegisterSuccess(data));
    } on ServerException catch (e) {
      emit(AuthError(e.message.message));
    } catch (e) {
      emit(AuthError('An un expected error occured'));
    }
  }


}
