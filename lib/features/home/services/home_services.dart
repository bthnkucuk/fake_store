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

    for (var element in (response.data as List)) {
      listem.add(ProductsModel.fromJson(element));
    }

    return listem;
  }
}
