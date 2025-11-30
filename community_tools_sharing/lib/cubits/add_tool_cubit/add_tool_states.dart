abstract class AddToolState {}

class AddToolInitial extends AddToolState {}

class AddToolLoading extends AddToolState {}

class AddToolSuccess extends AddToolState {}

class AddToolError extends AddToolState {
  final String message;
  AddToolError(this.message);
}
