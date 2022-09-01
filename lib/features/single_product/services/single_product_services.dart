import 'package:dio/dio.dart';
import 'package:fake_store/features/single_product/model/single_product_model.dart';

abstract class ISingleProductServices {
  Future<SingleProductModel>? fetchSingleProduct(int? productId);
}

class SingleProductServices extends ISingleProductServices {
  @override
  Future<SingleProductModel>? fetchSingleProduct(int? productId) async {
    final response =
        await Dio().get("https://fakestoreapi.com/products/$productId");

    return SingleProductModel.fromJson(response.data);
  }
}
