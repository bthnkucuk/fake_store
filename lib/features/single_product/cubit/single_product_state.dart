part of 'single_product_cubit.dart';

abstract class SingleProductState extends Equatable {
  const SingleProductState();

  @override
  List<Object> get props => [];
}

class SingleProductInitial extends SingleProductState {}

class SingleProductLoading extends SingleProductState {}

class SingleProductLoaded extends SingleProductState {
  final SingleProductModel? singleProduct;

  const SingleProductLoaded(this.singleProduct);
}

class SingleProductError extends SingleProductState {
  final error;

  SingleProductError(this.error);
}
