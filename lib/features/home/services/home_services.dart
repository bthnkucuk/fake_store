import 'package:dio/dio.dart';
import 'package:fake_store/features/home/model/product_model.dart';

abstract class IHomeServices {
  Future<List<ProductsModel>?> fetchAllProducts();
}

class HomeServices extends IHomeServices {
  @override
  Future<List<ProductsModel>?> fetchAllProducts() async {
    final response = await Dio().get("https://fakestoreapi.com/products");
    List<ProductsModel>? listem = [];

    (response.data as List).forEach((element) {
      listem.add(ProductsModel.fromJson(element));
    });

    return listem;
  }
}
