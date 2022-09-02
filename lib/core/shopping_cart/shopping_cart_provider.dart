import 'package:flutter/material.dart';

class ShoppingCartProvider with ChangeNotifier {
  bool _isShoppingCartEmpty = true;
  bool get isShoppingCartEmpty => _isShoppingCartEmpty;

  Map<int, int> _shoppingListById = {};
  Map<int, int> get shoppingListById => _shoppingListById;
  void addToCart(int productId) {
    if (_isShoppingCartEmpty == true) {
      _isShoppingCartEmpty = false;
    }

    if (_shoppingListById.containsKey(productId) ||
        _shoppingListById[productId] == 0) {
      _shoppingListById[productId] = _shoppingListById.update(
          productId, (value) => (_shoppingListById[productId]! + 1));
    } else {
      _shoppingListById.addAll({productId: 1});
    }
    print(_shoppingListById);
    notifyListeners();
  }

  void deleteToCart(int productId) {
    _shoppingListById.remove(productId);
    if (_shoppingListById.isEmpty) {
      _isShoppingCartEmpty = true;
    }

    notifyListeners();
  }

  void decramentProductInCart(int productId) {
    if (_shoppingListById[productId] != null) {
      if (_shoppingListById[productId]! > 1) {
        _shoppingListById[productId] = _shoppingListById.update(
            productId, (value) => (_shoppingListById[productId]! - 1));
      } else if (_shoppingListById[productId]! == 1) {
        _shoppingListById.remove(productId);
      }
      print(_shoppingListById);
      if (_shoppingListById.isEmpty) {
        _isShoppingCartEmpty = true;
      }
    }
    notifyListeners();
  }
}
