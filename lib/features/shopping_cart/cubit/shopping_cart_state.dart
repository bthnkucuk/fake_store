part of 'shopping_cart_cubit.dart';

abstract class ShoppingCartState extends Equatable {
  const ShoppingCartState();

  @override
  List<Object> get props => [];
}

class ShoppingCartInitial extends ShoppingCartState {}

class ShoppingCartLoading extends ShoppingCartState {}

class ShoppingCartLoaded extends ShoppingCartState {
  final double summCart;
  final List<ShoppingCartItemModel>? shoppingCart;

  const ShoppingCartLoaded(this.shoppingCart, this.summCart);
}

class ShoppingCartError extends ShoppingCartState {
  final String error;

  const ShoppingCartError(this.error);
}
