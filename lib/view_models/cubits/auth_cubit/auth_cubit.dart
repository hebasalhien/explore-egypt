import 'package:explore_egypt/models/user_model.dart';
import 'package:explore_egypt/services/profile_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:explore_egypt/services/auth_services.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthServices _authServices;
  final ProfileService _profileService;
  AuthCubit(this._authServices, this._profileService) : super(AuthInitial());

  Future<dynamic> login({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      final data = await _authServices.login(email: email, password: password);
      final userData = await _profileService.getUserProfile();

      emit(AuthSuccess(data,userData));
    } on Exception catch (e) {
      String errorMessage = e.toString().replaceFirst('Exception: ', '');
      emit(AuthError(errorMessage));
    } catch (e) {
      emit(AuthError('An unexpected error occurred:$e'));
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

      emit(AuthSuccess(data,null));
    } on Exception catch (e) {
      String errorMessage = e.toString().replaceFirst('Exception: ', '');
      emit(AuthError(errorMessage));
    } catch (e) {
      emit(AuthError('An un expected error occured'));
    }
  }


}
