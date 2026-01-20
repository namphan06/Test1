import 'package:flutter_bloc/flutter_bloc.dart';
import '../product_model.dart';
import 'list_product_event.dart';
import 'list_product_repository.dart';
import 'list_product_state.dart';

class ListProductBloc extends Bloc<ListProductEvent, ListProductState> {
  final ListProductRepository _repository;

  ListProductBloc(this._repository) : super(ListProductState.initial()) {
    on<LoadProducts>(_onLoadProducts);
    on<SearchProducts>(_onSearchProducts);
    on<AddProduct>(_onAddProduct);
    on<UpdateProduct>(_onUpdateProduct);
    on<DeleteProduct>(_onDeleteProduct);
  }

  Future<void> _onLoadProducts(
    LoadProducts event,
    Emitter<ListProductState> emit,
  ) async {
    emit(state.copyWith(status: ProductStatus.loading));
    try {
      final products = await _repository.getProducts();
      emit(state.copyWith(
        status: ProductStatus.success,
        products: products,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ProductStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onSearchProducts(
    SearchProducts event,
    Emitter<ListProductState> emit,
  ) async {
    final query = event.query.toLowerCase();
    
    if (query.isEmpty) {
      emit(state.copyWith(
        filteredProducts: [],
        searchQuery: '',
      ));
    } else {
      final filtered = state.products
          .where((p) => p.name.toLowerCase().contains(query))
          .toList();
      emit(state.copyWith(
        filteredProducts: filtered,
        searchQuery: event.query,
      ));
    }
  }

  Future<void> _onAddProduct(
    AddProduct event,
    Emitter<ListProductState> emit,
  ) async {
    emit(state.copyWith(status: ProductStatus.loading));
    try {
      await _repository.addProduct(event.product);
      final products = await _repository.getProducts();
      emit(state.copyWith(
        status: ProductStatus.success,
        products: products,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ProductStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onUpdateProduct(
    UpdateProduct event,
    Emitter<ListProductState> emit,
  ) async {
    emit(state.copyWith(status: ProductStatus.loading));
    try {
      await _repository.updateProduct(event.product);
      final products = await _repository.getProducts();
      emit(state.copyWith(
        status: ProductStatus.success,
        products: products,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ProductStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onDeleteProduct(
    DeleteProduct event,
    Emitter<ListProductState> emit,
  ) async {
    emit(state.copyWith(status: ProductStatus.loading));
    try {
      await _repository.deleteProduct(event.id);
      final products = await _repository.getProducts();
      emit(state.copyWith(
        status: ProductStatus.success,
        products: products,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ProductStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }
}