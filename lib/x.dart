// import 'dart:core';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:dragebale_example_game/data/data.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:velocity_x/velocity_x.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   await Firebase.initializeApp();

//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final String title = 'Draggable & DragTarget';
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: title,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: HomePage(),
//     );
//   }
// }

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final ref = FirebaseFirestore.instance.collection("fruits");

//   final snackBar = SnackBar(
//     content: "Yay! Correct 🥳".text.center.make(),
//     backgroundColor: Colors.green,
//   );
//   final snackBar1 = SnackBar(
//     content: "Opps! Wrong 😥".text.center.make(),
//     backgroundColor: Colors.red,
//   );

//   List<Data>? items;
//   List<Data>? items2;
//   //int? score;
//   bool? gameOver;
//   bool accepting = false;
//   @override
//   void initState() {
//     super.initState();
//     gameOver = false;
//     //score = 0;
//     items = items!.take(5).toList();
//     items2 = List<Data>.from(items!);
//     items!.shuffle();
//     items2!.shuffle();
//     //initGame();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.greenAccent.shade100,
//       appBar: AppBar(
//         title: Text('Drag&Drop Game'),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Text.rich(TextSpan(children: [
//               TextSpan(
//                   text: "Score: ",
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//               // TextSpan(
//               //     text: "$score",
//               //     style: TextStyle(
//               //         color: Colors.green,
//               //         fontWeight: FontWeight.bold,
//               //         fontSize: 30.0))
//             ])),
//             StreamBuilder(
//                 stream: ref.snapshots(),
//                 builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//                   if (snapshot.hasData) {
//                     return ListView.builder(
//                         shrinkWrap: true,
//                         itemCount: snapshot.data!.docs.length,
//                         itemBuilder: (context, index) {
//                           List<Data> dataList = snapshot.data!.docs
//                               .map((e) => Data.fromJson(
//                                   e.data() as Map<String, dynamic>))
//                               .toList();
//                           return Row(
//                             children: <Widget>[
//                               Column(
//                                 children: items!
//                                     .map((data) => Draggable<Data>(
//                                         data: data,
//                                         feedback: Image.network(
//                                           dataList[index].imgurl.toString(),
//                                           height: 100,
//                                           width: 100,
//                                         ),
//                                         childWhenDragging: Image.network(
//                                           dataList[index].imgurl.toString(),
//                                           height: 100,
//                                           width: 100,
//                                           colorBlendMode: BlendMode.softLight,
//                                         ),
//                                         child: Image.network(
//                                           dataList[index].imgurl.toString(),
//                                           height: 100,
//                                           width: 100,
//                                         )).p12())
//                                     .toList(),
//                               ).p12(),
//                               Spacer(),
//                               Column(
//                                   children: items2!.map((item) {
//                                 return DragTarget<Data>(
//                                     onAccept: (receivedItem) {
//                                       if (item.value == receivedItem.value) {
//                                         ScaffoldMessenger.of(context)
//                                             .showSnackBar(snackBar);
//                                         setState(() {
//                                           items!.remove(receivedItem);
//                                           items2!.remove(item);
//                                           // score += 10;
//                                           item.accepting = false;
//                                         });
//                                       } else {
//                                         ScaffoldMessenger.of(context)
//                                             .showSnackBar(snackBar1);
//                                         setState(() {
//                                           //score -= 5;
//                                           item.accepting = false;
//                                         });
//                                       }
//                                     },
//                                     onLeave: (receivedItem) {
//                                       setState(() {
//                                         item.accepting = false;
//                                       });
//                                     },
//                                     onWillAccept: (receivedItem) {
//                                       setState(() {
//                                         item.accepting = true;
//                                       });
//                                       return true;
//                                     },
//                                     builder: (context, acceptedItems,
//                                             rejectedItems) =>
//                                         Container(
//                                           color: item.accepting!
//                                               ? Colors.blue.shade200
//                                               : Colors.blue,
//                                           height: 100,
//                                           width: 100,
//                                           alignment: Alignment.center,
//                                           margin: const EdgeInsets.all(8.0),
//                                           child: dataList[index]
//                                               .name!
//                                               .text
//                                               .white
//                                               .bold
//                                               .size(18)
//                                               .make(),
//                                         ));
//                               }).toList())
//                             ],
//                           );
//                           // if (gameOver)
//                           //   "Game Over"
//                           //       .text
//                           //       .red600
//                           //       .bold
//                           //       .size(24)
//                           //       .make()
//                           //       .centered();
//                           // if (gameOver)
//                           //   ElevatedButton(
//                           //     style: ElevatedButton.styleFrom(
//                           //         primary: Colors.blue,
//                           //         onPrimary: Colors.white,
//                           //         fixedSize: Size.fromWidth(80)),
//                           //     child: "New Game".text.center.make().centered(),
//                           //     onPressed: () {
//                           //       initGame();
//                           //       setState(() {});
//                           //     },
//                           //   );
//                         });
//                   }
//                   return CircularProgressIndicator();
//                 }),
//           ],
//         ),
//       ),
//     );
//   }
// }