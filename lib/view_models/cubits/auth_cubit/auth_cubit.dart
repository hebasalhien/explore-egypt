import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:explore_egypt/services/auth_services.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthServices _authServices;
  AuthCubit(this._authServices) : super(AuthInitial());

  Future<dynamic> login({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      final data = await _authServices.login(email: email, password: password);
      emit(AuthSuccess(data));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<dynamic> register({
    required String email,
    required String username,
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      final data = await _authServices.createUser(
        email: email,
        password: password,
        username: username,
      );
      emit(AuthSuccess(data));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
