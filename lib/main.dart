
import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dragebale_example_game/data/data.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'dart:ui';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final String title = 'Draggable & DragTarget';
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}



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

 
   List<Data>? items=[];
   List<Data>? items2=[];
 
  // int score;
   bool? gameOver;
   bool? accepting = false;

  get child => null;
  
  
  @override
   void initState() {
   super.initState();
   initGame();
   }
//   //  gameOver = false;
      int score = 0;
//     items= items.take(5).toList();
//     items2 = List<Data>.from(items);
  initGame(){
    items= items!.take(5).toList();
     items2 = List<Data>.from(items!);
     items!.shuffle();
     items2!.shuffle();
  }

  @override
  Widget build(BuildContext context) {
      // if (items!.length == 0) gameOver = true;
    //  final data = MediaQuery.of(context);
    
    return Scaffold(
      backgroundColor: Colors.greenAccent.shade100,
       appBar:
       AppBar(
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
          
               StreamBuilder(
                stream: ref.snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  
                   if (snapshot.hasData ) {
                  List<Data> dataList = snapshot.data!.docs.map((e) => Data.fromJson(e.data() as Map<String, dynamic>)).toList();
                      items = dataList;
                      items2 = dataList;
                      
                    return Container(
                      height: 600,
                      width: 800,
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: dataList.length,
                          itemBuilder: (context, index) {
                          
                            //  if(!gameOver)
                             return Row(
                                children: <Widget>[
                                    Column(
                                children:[
                                  Draggable<Data>(
                                        data: dataList[index],
                                        feedback: Image.network(
                                          dataList[index].imgurl.toString(),
                                          height: 100,
                                          width: 100,
                                        ),
                                        childWhenDragging: Image.network(
                                          dataList[index].imgurl.toString(),
                                          height: 100,
                                          width: 100,
                                          colorBlendMode: BlendMode.softLight,
                                        ),
                                        child: Image.network(
                                          dataList[index].imgurl.toString(),
                                          height: 100,
                                          width: 100,
                                        ).p12()
                                   )]
                              ).p12(),
                                  Spacer(),
                                  
                                 
                                  Expanded(
                                    child: Container(
                                       
                                      child: DragTarget<Data>(
                                          onAccept: (receivedItem) 
                                          {
                                            // print(receivedItem.value.toString());
                                            if (dataList[index].value == receivedItem.value) {
                                           
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                              setState(() {
                                                 dataList[index].accepting = false;
                                                dataList.removeWhere((element)=>element.value ==receivedItem.value);
                                               dataList.removeWhere((element) => element.value==dataList[index].value);
                                                score += 10;
                                               
                                              });
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar1);
                                              setState(() {
                                                score -= 5;
                                                dataList[index].accepting = false;
                                              });
                                            }
                                          },
                                          onLeave: (receivedItem) {
                                            setState(() {
                                              dataList[index].accepting = false;
                                            });
                                          },
                                          onWillAccept: (receivedItem) {
                                            setState(() {
                                              dataList[index].accepting = true;
                                            });
                                            return true;
                                          },
                                          builder: (context, acceptedItems,
                                                  rejectedItems) =>
                                              Container(
                                                color: dataList[index].accepting
                                                    ? Colors.blue.shade200
                                                    : Colors.blue,
                                                height:50,
                                                width: 50,
                                                alignment: Alignment.center,
                                                margin: const EdgeInsets.all(8.0),
                                                child:Text(dataList[index].name.toString(),)
                                              ))
                                                                
                                     
                                    ),
                                  )
                                 ],
                              );
                            // if (gameOver)
                            //   "Game Over"
                            //       .text
                            //       .red600
                            //       .bold
                            //       .size(24)
                            //       .make()
                            //       .centered();
                            // if (gameOver)
                            //   ElevatedButton(
                            //     style: ElevatedButton.styleFrom(
                            //         primary: Colors.blue,
                            //         onPrimary: Colors.white,
                            //         fixedSize: Size.fromWidth(80)),
                            //     child: "New Game".text.center.make().centered(),
                            //     onPressed: () {
                            //       initGame();
                            //       setState(() {});
                            //     },
                            //   );
                          }),
                    );
                  }
                  return CircularProgressIndicator().centered();
                }  
                 
        ),
          ],
        ).centered(),
      ),
      );
  }
}