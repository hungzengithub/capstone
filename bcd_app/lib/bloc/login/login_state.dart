part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
  @override
  List<Object> get props => [];
}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final UserDTO dto;
  const LoginSuccess(this.dto);
}

class LoginError extends LoginState {}
