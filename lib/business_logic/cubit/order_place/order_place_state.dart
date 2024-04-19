part of 'order_place_cubit.dart';

abstract class OrderPlaceState extends Equatable {
  const OrderPlaceState();
}

class OrderPlaceInitial extends OrderPlaceState {
  @override
  List<Object> get props => [];
}

class OrderPlaceLoading extends OrderPlaceState {
  @override
  List<Object> get props => [];
}

class OrderPlaceSuccess extends OrderPlaceState {
  @override
  List<Object> get props => [];
}

class OrderPlaceFail extends OrderPlaceState {
  @override
  List<Object> get props => [];
}
