import 'package:ecommerce/model/cart_item_model/history_cart_model.dart';

class ReturnedModel {
  int? id;
  String? reason;
  String? note;
  String? returnedAmount;
  String? type;
  String? status;
  String? createdAt;
  String? updatedAt;
  OrderItems? orderItem;

  ReturnedModel({
    this.id,
    this.reason,
    this.note,
    this.returnedAmount,
    this.type,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.orderItem,
  });

  ReturnedModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reason = json['reason'];
    note = json['note'];
    returnedAmount = json['returned_amount'];
    type = json['type'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    orderItem = json['orderitem'] != null
        ? OrderItems.fromJson(json['orderitem']) // Corrected typo here
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['reason'] = reason;
    data['note'] = note;
    data['returned_amount'] = returnedAmount;
    data['type'] = type;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (orderItem != null) {
      data['orderitem'] = orderItem!.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return 'ReturnedModel{id: $id, reason: $reason, note: $note, returnedAmount: $returnedAmount, type: $type, status: $status, createdAt: $createdAt, updatedAt: $updatedAt, orderItem: $orderItem}';
  }
}