import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product_model.dart';

class ProductService {
  final _firestore = FirebaseFirestore.instance;
  final _collection = 'products';

  Future<void> addProduct(ProductModel product) async {
    await _firestore.collection(_collection).add(product.toMap());
  }

  Future<void> updateProduct(String id, ProductModel product) async {
    await _firestore.collection(_collection).doc(id).update(product.toMap());
  }

  Future<void> deleteProduct(String id) async {
    await _firestore.collection(_collection).doc(id).delete();
  }

  Stream<List<ProductModel>> getAllProducts() {
    return _firestore.collection(_collection).snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => ProductModel.fromMap(doc.data(), doc.id))
          .toList();
    });
  }
}
