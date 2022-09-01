import 'package:fake_store/features/home/cubit/home_cubit.dart';
import 'package:fake_store/features/home/services/home_services.dart';
import 'package:fake_store/features/single_product/view/single_product_view.dart';
import 'package:fake_store/product/widgets/rate_stars_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(HomeServices()),
      child: Scaffold(
        appBar: AppBar(),
        body: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state is HomeError) {
              Scaffold.of(context).showSnackBar(
                  SnackBar(content: Text(state.error.toString())));
            }
          },
          builder: (context, state) {
            if (state is HomeLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HomeLoaded) {
              return GridView.builder(
                itemCount: state.allProducts!.length,
                itemBuilder: (BuildContext gridContext, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SingleProductView(
                                    productId: state.allProducts![index].id,
                                  )));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.black.withOpacity(0.3))),
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.all(5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Text(state.response![index].id.toString()),
                          // Text(state.response![index].category.toString()),
                          // Text(state.response![index].description.toString()),
                          // Text(state.response![index].image.toString()),
                          // Text(state.response![index].price.toString()),
                          // Text(state.response![index].rating!.count.toString()),
                          // Text(state.response![index].rating!.rate.toString()),
                          // Text(state.response![index].title.toString()),

                          AspectRatio(
                            aspectRatio: 1,
                            child: Container(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Image.network(
                                state.allProducts![index].image.toString(),
                              ),
                            ),
                          ),
                          Text(
                            state.allProducts![index].title.toString(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.8),
                                fontSize: 12),
                            textAlign: TextAlign.start,
                          ),
                          RateStars(
                              voleCount:
                                  state.allProducts![index].rating!.count,
                              starCount: (state.allProducts![index].rating!.rate
                                      as double)
                                  .floor()),
                          Container(
                              margin:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              child: Text(
                                  (state.allProducts![index].price.toString()),
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold))),

                          Container(
                              margin: EdgeInsets.only(left: 15, right: 15),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color: Colors.black.withOpacity(0.5))),
                              child: TextButton(
                                onPressed: (() {}),
                                child: const Text("Add to Cart"),
                              ))
                        ],
                      ),
                    ),
                  );
                },
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 0.50,
                  crossAxisCount: 2,
                ),
              );
            } else {
              final error = state as HomeError;
              return Text(error.error.toString());
            }
          },
        ),
      ),
    );
  }
}
