import 'dart:ui';

import 'package:fake_store/features/single_product/cubit/single_product_cubit.dart';
import 'package:fake_store/features/single_product/services/single_product_services.dart';
import 'package:fake_store/product/func/first_letter_upper.dart';
import 'package:fake_store/product/widgets/fake_store_app_bar.dart';
import 'package:fake_store/product/widgets/rate_stars_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/shopping_cart/shopping_cart_provider.dart';

class SingleProductView extends StatefulWidget {
  SingleProductView({super.key, required this.productId});
  int? productId;

  @override
  State<SingleProductView> createState() => _SingleProductViewState();
}

class _SingleProductViewState extends State<SingleProductView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SingleProductCubit(SingleProductServices(), widget.productId),
      child: Scaffold(
        appBar: const FakeStoreAppBar(),
        backgroundColor: Colors.white10.withOpacity(0.9),
        bottomSheet: BlocBuilder<SingleProductCubit, SingleProductState>(
          builder: (context, state) {
            if (state is SingleProductLoaded) {
              return Container(
                alignment: Alignment.topCenter,
                height: 80,
                padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black.withOpacity(0.2))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          state.singleProduct!.price.toString(),
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          " \$",
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                    !context
                            .watch<ShoppingCartProvider>()
                            .shoppingListById
                            .containsKey(state.singleProduct!.id)
                        ? ElevatedButton(
                            onPressed: () {
                              context
                                  .read<ShoppingCartProvider>()
                                  .addToCart(state.singleProduct!.id as int);
                            },
                            child: const Text("Add to Cart"))
                        : Row(
                            children: [
                              IconButton(
                                  onPressed: (() {
                                    context
                                        .read<ShoppingCartProvider>()
                                        .addToCart(
                                            state.singleProduct!.id as int);
                                  }),
                                  icon: const Icon(
                                    Icons.add,
                                    color: Colors.amber,
                                  )),
                              Text(context
                                  .watch<ShoppingCartProvider>()
                                  .shoppingListById[state.singleProduct!.id]
                                  .toString()),
                              IconButton(
                                  onPressed: (() {
                                    context
                                        .read<ShoppingCartProvider>()
                                        .decramentProductInCart(
                                            state.singleProduct!.id as int);
                                  }),
                                  icon: const Icon(
                                    Icons.remove,
                                    color: Colors.amber,
                                  )),
                            ],
                          )
                  ],
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
        body: BlocConsumer<SingleProductCubit, SingleProductState>(
          listener: (context, state) {
            if (state is SingleProductError) {
              Scaffold.of(context).showSnackBar(state.error);
            }
          },
          builder: (context, state) {
            if (state is SingleProductLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is SingleProductLoaded) {
              return SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 80),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(15),
                      color: Theme.of(context).cardColor,
                      child: AspectRatio(
                          aspectRatio: 1,
                          child: Image.network(
                              state.singleProduct!.image.toString())),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      color: Theme.of(context).cardColor,
                      padding: const EdgeInsets.only(
                          right: 15, left: 15, bottom: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextButton(
                              onPressed: () {},
                              child: Text(firstLetterUpper(
                                  state.singleProduct!.category.toString()))),
                          Text(state.singleProduct!.title.toString()),
                          const Divider(color: Colors.transparent),
                          RateStars(
                              voleCount: state.singleProduct!.rating!.count,
                              starCount:
                                  state.singleProduct!.rating!.rate!.floor()),
                          Text(
                            state.singleProduct!.description.toString(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      color: Theme.of(context).cardColor,
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Description",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 5),
                          Text(state.singleProduct!.description.toString()),
                          Text(state.singleProduct!.description.toString())
                        ],
                      ),
                    )
                  ],
                ),
              );
            } else {
              final error = state as SingleProductError;
              return Text(error.error.toString());
            }
          },
        ),
      ),
    );
  }
}
