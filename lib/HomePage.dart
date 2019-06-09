import 'package:flutter/material.dart';
import 'dart:math';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

//TODO:1. import images

AssetImage circle = AssetImage("images/circle.png");
AssetImage lucky = AssetImage("images/rupee.png");
AssetImage unlucky = AssetImage("images/sadFace.png");


//TODO:2. Get an array

List<String> itemArray;
int luckyNumber;

String message ="";//TO show message of win or attempt over
int counter=0;//counter to count attempts

//TODO:3.Initlize your array with 25 elements
  @override
  void initState() {
      // TODO: implement initState
      super.initState();
      itemArray = List<String>.generate(25,(index) => "empty");
      generateRandomNumber();
    }
    generateRandomNumber(){
      int random = Random().nextInt(25);
      print(random);
      setState(() {
              luckyNumber = random;
            });
    }

//TODO:4.define get image maethod
  AssetImage getImage(int index){
      String currentState = itemArray[index];
      switch (currentState) {
        case "lucky":
          return lucky;
          break;
          case "unlucky":
          return unlucky;
          break;
        
      }
      return circle;
  }
//TODO:5.Play game method

  playGame(int index){
    if(this.counter ==5){
      setState(() {
              this.message = " Attempts Over";
              this.resetGame();
              
            });
    }else{
      if(luckyNumber == index){
      setState(() {
              itemArray[index] = "lucky";
              this.message ="Win!!!";
              this.resetGame();

            });
    }else{
      setState(() {
              itemArray[index] = "unlucky";
             this.counter = counter +1;
            });
    }
    }
  }
//TODO:6.showAll
  showAll(){
    setState(() {
          itemArray = List<String>.filled(25, "unlucky");
          itemArray[luckyNumber] = "lucky";
        });
  }
//TODO:7.Reset All
resetGame(){
  Future.delayed(const Duration(milliseconds: 600), () {

  setState(() {
     itemArray =  List<String>.filled(25, "empty");
     this.message = "";
     this.counter=0;
    });
      });
    generateRandomNumber();
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scratch And Win",style: TextStyle(decorationStyle: TextDecorationStyle.double),),

      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(20.0),
              gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                childAspectRatio: 1.0,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemCount:itemArray.length,
              itemBuilder: (context,i)=>SizedBox(
                width: 50.0,
                height: 50.0,
                child: RaisedButton(
                  onPressed:(){
                    this.playGame(i);
                  },
                  child: Image(
                    image: this.getImage(i),
                  ),
                ),
              ),
            ),
          ),
          Container(
        width: 500.0,
         child: Center(child: Text(message,style:TextStyle(fontSize: 30.0,color: Colors.black,fontWeight: FontWeight.bold))),
          ),
         Container(
           
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
            Container(
              margin: EdgeInsets.all(5.0),
              child: RaisedButton(
              onPressed: (){
                this.showAll();
              },
          padding: EdgeInsets.all(10.0),
          color: Colors.red,
          child:Text("Show All",style:TextStyle(fontSize: 10.0,color: Colors.white)) ,
          ),
            ),
           Container(
              margin: EdgeInsets.all(5.0),
             child: RaisedButton(
              onPressed: (){
                this.resetGame();
              },
          padding: EdgeInsets.all(10.0),
          color: Colors.red,
          child:Text("Reset Game",style:TextStyle(fontSize: 10.0,color: Colors.white)) ,
          ),
           ),
            ],
          ),
         ),
         Container(
          color: Colors.black,
          width: 500.0,
         child: Center(child: Text("learncodeonline.in",style:TextStyle(fontSize: 30.0,color: Colors.white))),
         ),
        ],
      ),
    );
  }
}