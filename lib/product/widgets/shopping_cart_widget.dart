import 'package:fake_store/core/shopping_cart/shopping_cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SoppingCartWidget extends StatelessWidget {
  const SoppingCartWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext bottomContext) => Column(
                    children: [
                      Checkbox(
                          value: false,
                          onChanged: (value) {
                            value = !value!;
                            print(value);
                          })
                    ],
                  ));
        },
        icon: Icon(Icons.shopping_cart,
            color: context.watch<ShoppingCartProvider>().isShoppingCartEmpty
                ? Colors.white
                : Colors.amber));
  }
}
