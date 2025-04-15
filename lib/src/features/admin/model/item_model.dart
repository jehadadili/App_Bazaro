import 'package:bazaro_cs/src/core/config/helpers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ItemsModel {
  String id;
  String title;
  String description;
  String quintity;
  String image;
  String userId;
  String orderData;
  String orderTime;
  String type;
  String sellerName;
  String whatsappNumber;

  ItemsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.quintity,
    required this.image,
    required this.userId,
    required this.orderTime,
    required this.orderData,
    required this.type,
    this.sellerName = '',
    this.whatsappNumber = '',
  });

  factory ItemsModel.fromQuery(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    return ItemsModel(
      id: testDocuments(doc, 'id', ''),
      title: testDocuments(doc, 'title', ''),
      description: testDocuments(doc, 'description', ''),
      quintity: testDocuments(doc, 'quintity', ''),
      image: testDocuments(doc, 'image', ''),
      userId: testDocuments(doc, 'user_id', ''),
      orderTime: testDocuments(doc, 'order_time', ''),
      orderData: testDocuments(doc, 'order_data', ''),
      type: testDocuments(doc, 'type', ''),
      sellerName: testDocuments(doc, 'seller_name', ''),
      whatsappNumber: testDocuments(doc, 'whatsapp_number', ''),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description.isNotEmpty ? description : null,
      'quintity': quintity,
      'image': image,
      'user_id': userId.isNotEmpty ? userId : null,
      'order_time': orderTime.isNotEmpty ? orderTime : null,
      'order_data': orderData.isNotEmpty ? orderData : null,
      'type': type.isNotEmpty ? type : null,
      'seller_name': sellerName.isNotEmpty ? sellerName : null,
      'whatsapp_number': whatsappNumber.isNotEmpty ? whatsappNumber : null,
    };
  }
  

}
