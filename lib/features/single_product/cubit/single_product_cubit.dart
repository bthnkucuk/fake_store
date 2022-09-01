import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fake_store/features/single_product/model/single_product_model.dart';
import 'package:fake_store/features/single_product/services/single_product_services.dart';

part 'single_product_state.dart';

class SingleProductCubit extends Cubit<SingleProductState> {
  SingleProductCubit(
    this.singleProductServices,
    this.productId,
  ) : super(SingleProductInitial()) {
    loadSingleProduct();
  }
  final SingleProductServices singleProductServices;
  int? productId;

  void loadSingleProduct() async {
    try {
      emit(SingleProductLoading());

      final response =
          await singleProductServices.fetchSingleProduct(productId);

      emit(SingleProductLoaded(response));
    } catch (e) {
      emit(SingleProductError(e));
    }
  }
}
