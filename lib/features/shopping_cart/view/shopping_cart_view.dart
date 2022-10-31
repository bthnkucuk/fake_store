import 'package:fake_store/core/shopping_cart/shopping_cart_provider.dart';
import 'package:fake_store/features/shopping_cart/cubit/shopping_cart_cubit.dart';
import 'package:fake_store/features/shopping_cart/services/shopping_cart_services.dart';
import 'package:fake_store/product/func/first_letter_upper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShoppingCartView extends StatefulWidget {
  const ShoppingCartView({super.key});

  @override
  State<ShoppingCartView> createState() => _ShoppingCartViewState();
}

class _ShoppingCartViewState extends State<ShoppingCartView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShoppingCartCubit(ShoppingCartServices(), context),
      child: BlocBuilder<ShoppingCartCubit, ShoppingCartState>(
        builder: (context, state) {
          if (state is ShoppingCartLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ShoppingCartLoaded) {
            return Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 15, left: 15, top: 30),
                  child: ListView.builder(
                    itemCount: state.shoppingCart!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black.withOpacity(0.3)),
                                    borderRadius: BorderRadius.circular(10)),
                                height: 70,
                                width: 70,
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: Image.network(state
                                      .shoppingCart![index].image
                                      .toString()),
                                ),
                              ),
                              Column(
                                children: [
                                  Container(
                                      margin: const EdgeInsets.only(
                                          right: 5, left: 5),
                                      width: 200,
                                      child: Text(
                                        state.shoppingCart![index].title
                                            .toString(),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500),
                                      )),
                                  const SizedBox(height: 5),
                                  Container(
                                      margin: const EdgeInsets.only(
                                          right: 5, left: 5),
                                      width: 200,
                                      child: Text(
                                        firstLetterUpper(state
                                            .shoppingCart![index].category
                                            .toString()),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            color: Colors.blue,
                                            fontSize: 11,
                                            fontWeight: FontWeight.w500),
                                      )),
                                  const SizedBox(height: 10),
                                  Container(
                                      margin: const EdgeInsets.only(
                                          right: 5, left: 5),
                                      width: 200,
                                      child: Text(
                                        (double.parse(state
                                                    .shoppingCart![index].price
                                                    .toString()) *
                                                double.parse(context
                                                    .read<
                                                        ShoppingCartProvider>()
                                                    .shoppingListById[state
                                                        .shoppingCart![index]
                                                        .id]
                                                    .toString()))
                                            .toString(),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
                                      )),
                                ],
                              ),
                              Column(
                                children: [
                                  IconButton(
                                      onPressed: (() {
                                        context
                                            .read<ShoppingCartProvider>()
                                            .addToCart(state
                                                .shoppingCart![index]
                                                .id as int);
                                        context
                                            .read<ShoppingCartCubit>()
                                            .loadShoppingCart();
                                      }),
                                      icon: const Icon(
                                        Icons.add,
                                        color: Colors.amber,
                                      )),
                                  Text(context
                                      .read<ShoppingCartProvider>()
                                      .shoppingListById[
                                          state.shoppingCart![index].id]
                                      .toString()),
                                  IconButton(
                                      onPressed: (() {
                                        context
                                            .read<ShoppingCartProvider>()
                                            .decramentProductInCart(state
                                                .shoppingCart![index]
                                                .id as int);
                                        context
                                            .read<ShoppingCartCubit>()
                                            .loadShoppingCart();
                                      }),
                                      icon: const Icon(
                                        Icons.remove,
                                        color: Colors.amber,
                                      )),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(height: 10)
                        ],
                      );
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 20, left: 15, top: 0),
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.black.withOpacity(0.1)),
                    child: const Text("Back"),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.1),
                        border:
                            Border.all(color: Colors.white.withOpacity(0.3))),
                    margin: const EdgeInsets.only(bottom: 25),
                    height: 50,
                    child: Container(
                      margin: const EdgeInsets.only(right: 15, left: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(state.summCart.toString(),
                              style: const TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold)),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.black.withOpacity(0.1)),
                            child: const Text("Buy Now"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            final error = state as ShoppingCartError;

            return Text(state.error.toString());
          }
        },
      ),
    );
  }
}
