import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  // Example: login simulation
  void login(String username, String password) async {
    emit(AppLoading());
    await Future.delayed(const Duration(seconds: 1));
    if (username == 'admin' && password == '1234') {
      emit(AppLoggedIn());
    } else {
      emit(AppError('Invalid credentials'));
    }
  }

  void logout() => emit(AppInitial());
}
