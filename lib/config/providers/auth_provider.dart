import 'package:fablab_app/data/services/auth_service.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:fablab_app/domain/models/user_model.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(),
);

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthService _authService = AuthService();

  AuthNotifier() : super(AuthState.initial()) {
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final loggedIn = await _authService.isLoggedIn();

    if (loggedIn) {
      // Por ahora NO tenemos getProfile(),
      // así que dejamos user en null hasta que tu backend exponga un endpoint.
      state = state.copyWith(
        isAuthenticated: true,
        status: AuthStatus.authenticated,
      );
    } else {
      state = state.copyWith(status: AuthStatus.unauthenticated);
    }
  }

  Future<void> login(String email, String password) async {
    state = state.copyWith(status: AuthStatus.loading);

    final success = await _authService.login(email, password);

    if (success) {
      state = state.copyWith(
        isAuthenticated: true,
        status: AuthStatus.authenticated,
      );
    } else {
      state = state.copyWith(status: AuthStatus.error);
    }
  }

  Future<void> logout() async {
    await _authService.logout();
    state = AuthState.initial();
  }
}

class AuthState {
  final bool isAuthenticated;
  final AuthStatus status;
  final UserModel? user;

  const AuthState({
    required this.isAuthenticated,
    required this.status,
    this.user,
  });

  factory AuthState.initial() {
    return const AuthState(
      isAuthenticated: false,
      status: AuthStatus.unauthenticated,
      user: null,
    );
  }

  AuthState copyWith({
    bool? isAuthenticated,
    AuthStatus? status,
    UserModel? user,
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      status: status ?? this.status,
      user: user ?? this.user,
    );
  }
}

enum AuthStatus {
  unauthenticated,
  authenticated,
  loading,
  error,
}
