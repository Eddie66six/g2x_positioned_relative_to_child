library g2x_positioned_relative_to_child;

import 'package:flutter/material.dart';

enum G2xHorizontalPositionAxis {
  right,
  left,
  center
}
enum G2xVerticalPositionAxis {
  top,
  bottom,
  center
}

class G2xPositionedRelativeToChild {
  OverlayEntry? _overlayEntry;

  show({
    required BuildContext context, required GlobalKey parentKey, required Widget child,
    Offset offSet = Offset.zero,
    G2xHorizontalPositionAxis horizontalAxis = G2xHorizontalPositionAxis.left,
    G2xVerticalPositionAxis verticalAxis = G2xVerticalPositionAxis.bottom
  }){
    _overlayEntry = _createOverlayEntry(parentKey, child, offSet, horizontalAxis, verticalAxis);
    Overlay.of(context)!.insert(_overlayEntry!);
  }
  hide(){
    _overlayEntry?.remove();
  }

  OverlayEntry _createOverlayEntry(
    GlobalKey parentKey,
    Widget child,
    Offset offSet,
    G2xHorizontalPositionAxis horizontalAxis,
    G2xVerticalPositionAxis verticalAxis
  ) {
    RenderBox renderBox = parentKey.currentContext!.findRenderObject() as RenderBox;
    var childSize = renderBox.size;
    var childOffset = renderBox.localToGlobal(Offset.zero);
    
    double top = childOffset.dy - childSize.height;
    double left = childOffset.dx;
    if(verticalAxis == G2xVerticalPositionAxis.bottom){
      top = childOffset.dy + childSize.height;
    }
    else if(verticalAxis == G2xVerticalPositionAxis.center){
      top = childOffset.dy + childSize.height/2;
    }
    if(horizontalAxis == G2xHorizontalPositionAxis.right){
      left = childOffset.dx + childSize.width;
    }
    else if(horizontalAxis == G2xHorizontalPositionAxis.center){
      left = childOffset.dx + childSize.width/2;
    }

    return OverlayEntry(
      builder: (context) => Positioned(
        left: left + offSet.dx,
        top: top + offSet.dy,
        //width: childSize.width,
        child: Material(
          elevation: 4.0,
          child: child,
        ),
      )
    );
  }
}