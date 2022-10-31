part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<ProductsModel>? allProducts;

  const HomeLoaded(this.allProducts);
}

class HomeError extends HomeState {
  final String error;

  const HomeError(this.error);
}
