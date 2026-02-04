part of 'session_cubit.dart';

abstract class SessionState {}

final class SessionCubitInitial extends SessionState {}
final class SessionAuthenticated extends SessionState {
String token;
  SessionAuthenticated(this.token);

}
class SessionUnauthenticated extends SessionState {}
