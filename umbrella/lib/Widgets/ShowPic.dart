import 'package:flutter/material.dart';
import 'package:zoom_widget/zoom_widget.dart';

///Used to show picture with zoom capabilities - used in quick guidelines

class ShowPic extends StatelessWidget {
  String disaster;
  ShowPic({this.disaster});
  @override
  Widget build(BuildContext context) {
    return Zoom(
        width: 1600,
        height: 1600,
        backgroundColor: Colors.black,
        canvasColor: Colors.black,
        child: Center(
          child: Image.asset("asset/flood-guide.jpg"),
        ));
  }
}
