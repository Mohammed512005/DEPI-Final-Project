// lib/logic/cubits/auth_cubit/auth_state.dart
part of 'auth_cubit.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final String uid;
  AuthSuccess(this.uid);
}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}
