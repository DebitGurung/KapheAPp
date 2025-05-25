import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:kapheapp/data/repositories/authentication/authentication_repository.dart';
import '../../../features/shop/models/order_model.dart';

class OrderRepository extends GetxController {
  static OrderRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Get all orders related to current user
  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final authUser = AuthenticationRepository.instance.authUser;
      if (authUser == null || authUser.uid.isEmpty) {
        throw 'Unable to find user information. Please try again';
      }

      final result = await _db
          .collection('Users')
          .doc(authUser.uid)
          .collection('orders')
          .get();
      return result.docs
          .map((documentSnapshot) => OrderModel.fromSnapshot(documentSnapshot))
          .toList();
    } catch (e) {
      throw 'Something went wrong while fetching order information. Try again later';
    }
  }

  // Store new user order
  Future<void> saveOrder(OrderModel order, String userId) async {
    try {
      await _db
          .collection('Users')
          .doc(userId)
          .collection('orders')
          .add(order.toJson());
    } catch (e) {
      throw 'Something went wrong while saving order information. Try again later';
    }
  }
}