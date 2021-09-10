import 'package:flutter/material.dart';
import 'package:g2x_positioned_relative_to_child/g2x_positioned_relative_to_child.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var g2xPositionedRelative = G2xPositionedRelativeToChild();
  var globalKey = GlobalKey();
  var opened = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              key: globalKey,
              child: Text("Tap"),
              onPressed: (){
                if(opened){
                  g2xPositionedRelative.hide();
                }
                else{
                  g2xPositionedRelative.show(
                    horizontalAxis: G2xHorizontalPositionAxis.center,
                    context: context, 
                    parentKey: globalKey,
                    offSet: Offset(-100, 0),
                    child: Container(
                      height: 50,
                      width: 200,
                      color: Colors.red,
                      child: Center(child: Text("Child")),
                    )
                  );
                }
                opened = !opened;
              },
            )
          ],
        ),
      ),
    );
  }
}
