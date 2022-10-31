import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fake_store/features/home/model/product_model.dart';
import 'package:fake_store/features/home/services/home_services.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.homeServices) : super(HomeInitial()) {
    loadHome();
  }
  final HomeServices homeServices;

  void loadHome() async {
    try {
      emit(HomeLoading());

      final response = await homeServices.fetchAllProducts();

      emit(HomeLoaded(response));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
