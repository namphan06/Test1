import 'package:supabase_flutter/supabase_flutter.dart';
import '../product_model.dart';
import '../supabase_config.dart';
import 'list_product_repository.dart';

class ListProductRepositoryImpl implements ListProductRepository {
  final SupabaseClient _client;

  ListProductRepositoryImpl(this._client);

  @override
  Future<List<Product>> getProducts() async {
    final result = await _client.from('products').select('*');
    return (result as List).map((e) => Product.fromMap(e)).toList();
  }

  @override
  Future<List<Product>> searchProducts(String query) async {
    final result = await _client
        .from('products')
        .select('*')
        .ilike('name', '%$query%');
    return (result as List).map((e) => Product.fromMap(e)).toList();
  }

  @override
  Future<Product> getProductById(String id) async {
    final result = await _client.from('products').select('*').eq('id', id).single();
    return Product.fromMap(result);
  }

  @override
  Future<void> addProduct(Product product) async {
    await _client.from('products').insert(product.toMap());
  }

  @override
  Future<void> updateProduct(Product product) async {
    await _client.from('products').update(product.toMap()).eq('id', product.id);
  }

  @override
  Future<void> deleteProduct(String id) async {
    await _client.from('products').delete().eq('id', id);
  }
}