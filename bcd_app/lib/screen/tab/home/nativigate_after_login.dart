import 'package:bcd_app/bloc/login/login_bloc.dart';
import 'package:bcd_app/screen/tab/crack/component/crack_loading/crack_loading.dart';
import 'package:bcd_app/screen/tab/crack/crack_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NativigateAfterLogin extends StatefulWidget {
  final String username;
  final String password;

  const NativigateAfterLogin({
    Key key,
    this.username,
    this.password,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return NativigateAfterLoginState();
  }
}

class NativigateAfterLoginState extends State<NativigateAfterLogin> {
  LoginBloc _getBloc = new LoginBloc();
  @override
  void dispose() {
    super.dispose();
    _getBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    _getBloc.add(Login(widget.username, widget.password));
    return BlocProvider(
      create: (context) => _getBloc,
      child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
        if (state is LoginLoading) {
          return Scaffold(body: CrackLoading());
        } else if (state is LoginSuccess) {
          return CrackScreen(
            page: 1,
            flushBarMessage: null,
            dto: state.dto,
          );
        } else
          return Container(child: Text("error"));
      }),
    );
  }
}
