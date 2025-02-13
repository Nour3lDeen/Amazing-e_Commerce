import 'package:ecommerce/model/cart_item_model/cart_item_model.dart';
import 'package:flutter/cupertino.dart';

class HistoryCartItem {
  int? id;
  String? orderNumber;
  String? paymentMethod;
  String? total;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? address;
  List<CartItem>? orderItems;

  HistoryCartItem({
    this.id,
    this.orderNumber,
    this.paymentMethod,
    this.total,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.address,
    this.orderItems,
  });

  factory HistoryCartItem.fromJson(Map<String, dynamic> json) {
    try {
      return HistoryCartItem(
        id: json['id'] as int?,
        orderNumber: json['order_number']?.toString(), // Safely handle as String
        paymentMethod: json['payment_method'],
        total: json['total']?.toString(), // Safely handle as String
        status: json['status'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
        address: json['address'],
        orderItems: json['orderitems'] != null
            ? List<CartItem>.from(
            (json['orderitems'] as List<dynamic>)
                .map((item) => CartItem.fromJson(item as Map<String, dynamic>)))
            : [],
      );
    } catch (e) {
      debugPrint('Error parsing HistoryCartItem: $e');
      return HistoryCartItem();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['order_number'] = orderNumber; // Fixed key typo
    data['payment_method'] = paymentMethod;
    data['total'] = total;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['address'] = address;
    if (orderItems != null) {
      data['orderitems'] = orderItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return 'HistoryCartItem{id: $id, orderNumber: $orderNumber, paymentMethod: $paymentMethod, '
        'total: $total, status: $status, createdAt: $createdAt, updatedAt: $updatedAt, '
        'address: $address, orderItems: $orderItems}';
  }
}
