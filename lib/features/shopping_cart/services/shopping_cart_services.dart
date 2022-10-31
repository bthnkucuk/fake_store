import 'package:dio/dio.dart';
import 'package:fake_store/features/shopping_cart/model/shopping_cart_item_model.dart';

abstract class IShoppingCartServices {
  Future<List<ShoppingCartItemModel>?> fetchCartProducts(List askedProducts);
}

class ShoppingCartServices extends IShoppingCartServices {
  @override
  Future<List<ShoppingCartItemModel>?> fetchCartProducts(
      List askedProducts) async {
    List<ShoppingCartItemModel>? listem = [];

    for (var element in askedProducts) {
      final response =
          await Dio().get("https://fakestoreapi.com/products/$element");

      listem.add(ShoppingCartItemModel.fromJson(response.data));
    }

    return listem;
  }
}
