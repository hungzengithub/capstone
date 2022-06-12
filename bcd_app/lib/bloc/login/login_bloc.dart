import 'package:bcd_app/objects/userDTO.dart';
import 'package:bcd_app/repositories/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  @override
  LoginState get initialState => LoginLoading();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is Login) {
      UserRepository _userRepository = new UserRepository();
      UserDTO dto = await _userRepository.login(event.username, event.password);
      yield* _mapAppStartedToState(dto);
    }
  }

  Stream<LoginState> _mapAppStartedToState(UserDTO dto) async* {
    if (dto != null) {
      yield LoginSuccess(dto);
    } else {
      yield LoginError();
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
