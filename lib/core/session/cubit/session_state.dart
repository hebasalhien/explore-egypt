part of 'session_cubit.dart';

abstract class SessionState {}

final class SessionCubitInitial extends SessionState {}
final class SessionAuthenticated extends SessionState {
String Token;
  SessionAuthenticated(this.Token);

}
class SessionUnauthenticated extends SessionState {}
