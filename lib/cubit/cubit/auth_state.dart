part of 'auth_cubit.dart';

@immutable
class AuthState {
  final bool isLoggedIn;
  final String accessToken;
  final int idPengguna;
final String role;

  const AuthState({
    required this.isLoggedIn,
    required this.accessToken,
    required this.idPengguna,
    required this.role,
  });
}

class AuthInitialState extends AuthState {
  const AuthInitialState()
      : super(isLoggedIn: false, accessToken: '', idPengguna: -1, role: 'customer');
}
