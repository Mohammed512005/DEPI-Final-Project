// lib/logic/cubits/auth_cubit/auth_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:community_tools_sharing/services/auth_service.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthService _authService;

  AuthCubit(this._authService) : super(AuthInitial());

  Future<void> register(String email, String password) async {
    emit(AuthLoading());

    final (uid, error) = await _authService.register(email: email, password: password);

    if (error != null) {
      emit(AuthError(error));
    } else if (uid != null) {
      emit(AuthSuccess(uid));
    }
  }
}
