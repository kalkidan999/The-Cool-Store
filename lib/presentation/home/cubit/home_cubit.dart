import 'package:bloc/bloc.dart';

class HomeCubit extends Cubit<int> {
  HomeCubit() : super((0));

  void setIndex(int newIndex) {
    emit(newIndex); // Update the index state
  }
}
