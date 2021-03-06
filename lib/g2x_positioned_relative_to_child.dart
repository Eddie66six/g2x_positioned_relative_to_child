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
  final Function? callbackOnHide;
  final Color? backdropColor;
  final Key? backdropKey;
  final bool closeOnTapOutside;

  G2xPositionedRelativeToChild({
    this.callbackOnHide,
    this.backdropColor,
    this.backdropKey,
    this.closeOnTapOutside = false,
  });

  show({
    required BuildContext context, required GlobalKey parentKey, required Widget child,
    Offset offSet = Offset.zero,
    G2xHorizontalPositionAxis horizontalAxis = G2xHorizontalPositionAxis.left,
    G2xVerticalPositionAxis verticalAxis = G2xVerticalPositionAxis.bottom
  }){
    _overlayEntry = _createOverlayEntry(parentKey, child, offSet, horizontalAxis, verticalAxis);
    Overlay.of(context)!.insert(_overlayEntry!);
  }

  hide() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    callbackOnHide?.call();
  }

  _backDrop(BuildContext context, Widget child) {
    return 
      SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {
                if(closeOnTapOutside) {
                  hide();
                }
              },
              child: Container(
                key: backdropKey,
                color: closeOnTapOutside && backdropColor == null ?
                  Colors.transparent : backdropColor
              ),
            ),
            child
          ],
        ),
      );
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

    var innerChild = 
      Positioned(
        left: left + offSet.dx,
        top: top + offSet.dy,
        child: child,
      );

    return OverlayEntry(
      builder: (context) {
        return _backDrop(context, innerChild);
      }
    );
  }
}
