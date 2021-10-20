//import 'package:flutter/material.dart';

// class ItemModel {
//   final String name;
//   final String value;
//   final String imgurl;
//   bool accepting;
//   ItemModel({required this.name, required this.value, required this.imgurl, this.accepting = false});
// }

//  final itemsdata = [
//       ItemModel(
//         name: 'Apple',
//         value: 'Apple',
//         imgurl: "https://tiimg.tistatic.com/fp/1/006/512/fresh-red-apple-fruits-885.jpg?tr=n-w410",
//       ),
//       ItemModel(
//         name: 'Banana',
//         value: 'Banana',
//         imgurl: "https://basket.mu/image/cache/catalog/category/Fruits/Banana-600x600.jpg",
//       ),
//       ItemModel(
//         name: 'Pineapple',
//         value: 'Pineapple',
//         imgurl: "https://d2gg9evh47fn9z.cloudfront.net/800px_COLOURBOX3424674.jpg",
//       ),
//       ItemModel(
//         name: 'orange',
//         value: 'orange',
//         imgurl: "https://5.imimg.com/data5/VN/YP/MY-33296037/orange-600x600-500x500.jpg",
//       ),
//        ItemModel(
//         name: 'Strawberry',
//         value: 'Strawberry',
//         imgurl: "https://i.pinimg.com/originals/13/c4/3a/13c43a93bd3cf6cb84c124f903ff7deb.jpg",
//       ),
//  ];




class Data{
  late String name;
  late String value;
  late String imgurl;
  late bool accepting = false;

  Data({required this.name,required this.imgurl,required this.value,
   required this.accepting
  });
  
  Data.fromJson(Map<String , dynamic> json){
   name = json['name'];
   value = json['value'];
   imgurl = json['imgurl'];
   accepting = false;
  }

  Map<String , dynamic> toJson(){
    final Map<String , dynamic> data = new Map<String , dynamic>();
    data['name'] = this.name;
    data['value'] = this.value;
    data['imgurl'] = this.imgurl;
    return data;
          }

}