import 'package:equatable/equatable.dart';
import '../product_model.dart';

enum ProductStatus { initial, loading, success, failure ,error}

class ListProductState extends Equatable {
  final List<Product> products;
  final List<Product> filteredProducts;
  final String searchQuery;
  final ProductStatus status;
  final String? errorMessage; 
  const ListProductState({
    this.products = const [],
    this.filteredProducts = const [],
    this.searchQuery = '',
    required this.status,
    this.errorMessage,
  });

  factory ListProductState.initial() => const ListProductState(status: ProductStatus.initial);

  @override
  List<Object?> get props => [products, filteredProducts, searchQuery, status];

  List<Product> get displayProducts => 
      searchQuery.isEmpty ? products : filteredProducts;

  ListProductState copyWith({
    List<Product>? products, 
    List<Product>? filteredProducts,
    String? searchQuery,
    ProductStatus? status,
    String? errorMessage,
  }) {
    return ListProductState(
      products: products ?? this.products,
      filteredProducts: filteredProducts ?? this.filteredProducts,
      searchQuery: searchQuery ?? this.searchQuery,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

