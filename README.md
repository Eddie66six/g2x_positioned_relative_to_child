# g2x_positioned_relative_to_child
creates an overlay with position relative to the child

## Getting Started

    import 'package:g2x_positioned_relative_to_child/g2x_positioned_relative_to_child.dart';

    var g2xPositionedRelative = G2xPositionedRelativeToChild();
    var globalKey = GlobalKey();
    var opened = false;

    ElevatedButton(
      key: globalKey,
      child: Text("Aqui"),
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