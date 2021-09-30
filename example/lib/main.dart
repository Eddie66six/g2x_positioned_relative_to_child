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
  late G2xPositionedRelativeToChild g2xPositionedRelativeWithBackdrop;
  var g2xPositionedRelativeWithoutBackdrop = G2xPositionedRelativeToChild();

  var globalKeyWithBackdrop = GlobalKey();
  var globalKeyWithoutBackdrop = GlobalKey();

  var opened = false;

  _fechar() {
    opened = !opened;
    setState(() {});
  }

  @override
  void initState() {
    g2xPositionedRelativeWithBackdrop = G2xPositionedRelativeToChild(
      callbackOnHide: _fechar,
      closeOnTapOutside: true,
      backdropColor: Colors.black12
    );
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Text("$opened"),

              ElevatedButton(
                key: globalKeyWithBackdrop,
                child: const Text("With Backdrop"),
                onPressed: () {
                  g2xPositionedRelativeWithBackdrop.show(
                    horizontalAxis: G2xHorizontalPositionAxis.center,
                    context: context, 
                    parentKey: globalKeyWithBackdrop,
                    offSet: const Offset(-100, 0),
                    child: Container(
                      height: 50,
                      width: 200,
                      color: Colors.red,
                      child: 
                        const 
                          Center(
                            child: 
                              Text(
                                "Child"
                              )
                          ),
                    )
                  );

                  opened = true;

                  setState(() { });
                },
              ),

              ElevatedButton(
                key: globalKeyWithoutBackdrop,
                child: const Text("Without Backdrop"),
                onPressed: () {
                  if(opened) {
                    g2xPositionedRelativeWithoutBackdrop.hide();
                    opened = false;
                    setState(() { });
                  }
                  else {
                    g2xPositionedRelativeWithoutBackdrop.show(
                      horizontalAxis: G2xHorizontalPositionAxis.center,
                      context: context, 
                      parentKey: globalKeyWithoutBackdrop,
                      offSet: const Offset(-100, 0),
                      child: Container(
                        height: 50,
                        width: 200,
                        color: Colors.red,
                        child: 
                          const 
                            Center(
                              child: 
                                Text(
                                  "Child"
                                )
                            ),
                      )
                    );

                    opened = true;

                    setState(() { });
                  }
                },
              ),
            ],
          ),
        ),
      ),
      
    );
  }
}
