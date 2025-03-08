import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product_model.dart';
import '../models/order_model.dart';

class FirestoreService {
  final CollectionReference _productsCollection = FirebaseFirestore.instance.collection('products');
  final CollectionReference _ordersCollection = FirebaseFirestore.instance.collection('orders');

  Future<List<ProductModel>> getProducts() async {
    QuerySnapshot snapshot = await _productsCollection.get();
    return snapshot.docs.map((doc) => ProductModel.fromJson(doc.data() as Map<String, dynamic>)).toList();
  }

  Future<void> addProduct(ProductModel product) async {
    await _productsCollection.doc(product.id).set(product.toJson());
  }

  Future<void> updateProduct(ProductModel product) async {
    await _productsCollection.doc(product.id).update(product.toJson());
  }

  Future<void> deleteProduct(String productId) async {
    await _productsCollection.doc(productId).delete();
  }

  Future<void> addOrder(OrderModel order) async {
    await _ordersCollection.doc(order.orderId).set(order.toJson());
  }

  Future<List<OrderModel>> getOrders(String userId) async {
    QuerySnapshot snapshot = await _ordersCollection.where('userId', isEqualTo: userId).get();
    return snapshot.docs.map((doc) => OrderModel.fromJson(doc.data() as Map<String, dynamic>)).toList();
  }
}