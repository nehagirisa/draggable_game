import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dragebale_example_game/data/data.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ref = FirebaseFirestore.instance.collection("fruits");

  final snackBar = SnackBar(
    content: "Yay! Correct 🥳".text.center.make(),
    backgroundColor: Colors.green,
  );
  final snackBar1 = SnackBar(
    content: "Opps! Wrong 😥".text.center.make(),
    backgroundColor: Colors.red,
  );

  List<Data>? items = [];
  List<Data>? items2 = [];

  // int score;
  //  bool? gameOver;
  bool? accepting = false;

  get child => null;

  @override
  void initState() {
    super.initState();
  }

  // gameOver = false;
  int score = 0;
//     items= items.take(5).toList();
//     items2 = List<Data>.from(items);
  initGame() {
    // items= items!.take(5).toList();
    //  items2 = List<Data>.from(items!);
    // items!.shuffle();
    // items2!.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    // if (items!.length == 0) gameOver = true;
    //  final data = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: Colors.greenAccent.shade100,
      appBar: AppBar(
        title: Text('Drag & Drop Game').text.make(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text.rich(TextSpan(children: [
              TextSpan(
                  text: "Score: ",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              TextSpan(
                  text: "$score",
                  style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0))
            ])),
            FutureBuilder(
                future: FirebaseFirestore.instance.collection("fruits").get(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    List<Data> dataList = snapshot.data!.docs
                        .map((e) =>
                            Data.fromJson(e.data() as Map<String, dynamic>))
                        .toList();
                    items = dataList;
                    items2 = dataList;
                    // initGame();
                    return Container(
                      height: 600,
                      width: 800,
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: items!.length,
                          itemBuilder: (context, index) {
                            return Row(
                              children: <Widget>[
                                Column(children: [
                                  Draggable<Data>(
                                      data: items![index],
                                      feedback: Image.network(
                                        items![index].imgurl.toString(),
                                        height: 100,
                                        width: 100,
                                      ),
                                      childWhenDragging: Image.network(
                                        items![index].imgurl.toString(),
                                        height: 100,
                                        width: 100,
                                        colorBlendMode: BlendMode.softLight,
                                      ),
                                      child: Image.network(
                                        items![index].imgurl.toString(),
                                        height: 100,
                                        width: 100,
                                      ).p12())
                                ]).p12(),
                                Spacer(),
                                Expanded(
                                  child: Container(
                                      child: DragTarget<Data>(
                                    onAccept: (receivedItem) {
                                      if (items2![index].value ==
                                          receivedItem.value) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                        setState(() {
                                          items2![index].accepting = true;
                                          items2!.removeWhere((dataList) =>
                                              dataList.imgurl ==
                                              receivedItem.value);
                                          items!.removeWhere((dataList) =>
                                              dataList.imgurl ==
                                              receivedItem.value);

                                          score += 10;
                                        });
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar1);
                                        setState(() {
                                          score -= 5;
                                          items![index].accepting = false;
                                        });
                                      }
                                    },
                                    onLeave: (receivedItem) {
                                      setState(() {
                                        items![index].accepting = false;
                                      });
                                    },
                                    onWillAccept: (receivedItem) {
                                      setState(() {
                                        items![index].accepting = true;
                                      });
                                      return true;
                                    },
                                    builder: (context, acceptedItems,
                                            rejectedItems) =>
                                        CircleAvatar(
                                            radius: 60,
                                            child: Text(
                                              dataList[index].name.toString(),
                                            )),
                                  )),
                                )
                              ],
                            );
                          }),
                    );
                  }
                  return CircularProgressIndicator().centered();
                }),
          ],
        ).centered(),
      ),
    );
  }
}
