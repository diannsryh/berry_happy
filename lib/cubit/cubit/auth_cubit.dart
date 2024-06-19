import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthInitialState());

  void login(String accessToken, int idUser, String role) {
    emit(AuthState(
        isLoggedIn: true, accessToken: accessToken, idPengguna: idUser, role: role));
  }

  void logout() {
    emit(const AuthState(isLoggedIn: false, accessToken: "", idPengguna: -1, role: "customer"));
  }
}
