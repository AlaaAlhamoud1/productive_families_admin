import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'order_place_state.dart';

class OrderPlaceCubit extends Cubit<OrderPlaceState> {
  OrderPlaceCubit() : super(OrderPlaceInitial());

  void placeOrder() async {
    try {
      emit(OrderPlaceLoading());
      await Future.delayed(const Duration(seconds: 3));
      emit(OrderPlaceSuccess());
    } catch (e) {
      emit(OrderPlaceFail());
    }
  }
}
