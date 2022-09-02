import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fake_store/core/shopping_cart/shopping_cart_provider.dart';
import 'package:fake_store/features/shopping_cart/model/shopping_cart_item_model.dart';
import 'package:fake_store/features/shopping_cart/services/shopping_cart_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

part 'shopping_cart_state.dart';

class ShoppingCartCubit extends Cubit<ShoppingCartState> {
  ShoppingCartCubit(this.shoppingCartServices, this.context)
      : super(ShoppingCartInitial()) {
    loadShoppingCart();
  }
  final ShoppingCartServices shoppingCartServices;
  final BuildContext context;

  void loadShoppingCart() async {
    try {
      emit(ShoppingCartLoading());
      final shoppingListByProviderKeys =
          context.read<ShoppingCartProvider>().shoppingListById.keys.toList();
      final shoppingListByProviderValuse =
          context.read<ShoppingCartProvider>().shoppingListById.values.toList();

      double summCart = 0;

      final response = await shoppingCartServices
          .fetchCartProducts(shoppingListByProviderKeys);

      for (var i = 0; i < shoppingListByProviderValuse.length; i++) {
        summCart += double.parse(response![i].price.toString()) *
            shoppingListByProviderValuse[i];
      }
      print(summCart);

      emit(ShoppingCartLoaded(response, summCart));
    } catch (e) {
      emit(ShoppingCartError(e));
    }
  }
}
