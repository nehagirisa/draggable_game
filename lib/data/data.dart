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
   

   Data({required this.name, required this.value,required this.imgurl,});

    Data.fromJson(Map data) {
    this.name = data['name'];
    this.value = data['value'];
    this.imgurl = data['imgurl'];
   }

    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = new Map<String, dynamic>();
        data['name'] = this.name;
        data['value'] = this.name;
        data['imgurl'] = this.name;
        return data;
      // data['name']= this.name;
      // data['value']= this.value;
      // data['imgurl']= this.imgurl;

  //  Map<String, dynamic> toJson() => {
  //     final Map<String, dynamic> data = new Map<String, dynamic>();
  //       "name": name == null ? null : name,
  //       "value": value == null ? null : value,
  //       "imgurl": imgurl == null ? null : imgurl,
 }
 }
  

  // PaymentCard.fromJson(Map data) {
  //   this._cardholderName = data['cardholderName'];

  //   this._cardNumber = data['cardNumber'];
  //   this._cardType = data['cardType'];
  //   this._cvcCode = data['cvcCode'];
  //   this._expiryDate = data['expiryDate'];
  //   this._uid = data['uid'];
  //   this._showBack = data['showBack'];

  //   //this._username=data['uid'];
  // }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['cardholderName'] = this._cardholderName;
  //   data['cardNumber'] = this._cardNumber;
  //   data['cardType'] = this._cardType;
  //   data['showBack'] = this._showBack;
  //   data['expiryDate'] = this._expiryDate;
  //   data['uid'] = this._uid;
  //   return data;
  // }
