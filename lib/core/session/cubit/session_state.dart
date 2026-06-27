part of 'session_cubit.dart';

abstract class SessionState {}

final class SessionCubitInitial extends SessionState {}
final class SessionAuthenticated extends SessionState {
  final String token;
  final String username;
  final String? imageUrl;

  SessionAuthenticated(this.token, this.username, this.imageUrl);

}
class SessionUnauthenticated extends SessionState {}

class SessionNeedsOnboarding extends SessionState { }
