import '../product_model.dart';

abstract class ListProductEvent {
  const ListProductEvent();
}

class LoadProducts extends ListProductEvent {
  const LoadProducts();
}

class SearchProducts extends ListProductEvent {
  final String query;
  const SearchProducts(this.query);
}

class AddProduct extends ListProductEvent {
  final Product product;
  const AddProduct(this.product);
}

class UpdateProduct extends ListProductEvent {
  final Product product;
  const UpdateProduct(this.product);
}

class DeleteProduct extends ListProductEvent {
  final String id;
  const DeleteProduct(this.id);
}