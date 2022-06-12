part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  final String username;
  final String password;
  LoginEvent(this.username, this.password);
  @override
  List<Object> get props => [];
}

class Login extends LoginEvent {
  Login(String username, String password) : super(username, password);
}
