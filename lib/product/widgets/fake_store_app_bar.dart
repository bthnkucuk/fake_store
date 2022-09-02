import 'package:fake_store/core/shopping_cart/shopping_cart_provider.dart';
import 'package:fake_store/features/shopping_cart/view/shopping_cart_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FakeStoreAppBar extends StatelessWidget with PreferredSizeWidget {
  const FakeStoreAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("Fake Store"),
      actions: [
        IconButton(
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext bottomContext) =>
                      const ShoppingCartView());
            },
            icon: Icon(Icons.shopping_cart,
                color: context.watch<ShoppingCartProvider>().isShoppingCartEmpty
                    ? Colors.white
                    : Colors.amber))
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(60);
}
