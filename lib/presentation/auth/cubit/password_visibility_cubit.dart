import 'package:bloc/bloc.dart';

class PasswordVisibilityCubit extends Cubit<bool> {
  PasswordVisibilityCubit() : super(true);

  void setPasswordVisibility(bool isVisible) {
    emit(isVisible); // Update the visiblility state
  }
}
