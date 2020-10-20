import 'package:flutter/material.dart';

class NYCWSq extends StatefulWidget {
  static final squares = List<NYCWSq>();
  static Color normalColor = Colors.yellow;
  static Color unusedColor = Colors.black;
  static Color selectedColor = Colors.deepOrange;
  static Color selectedRowColor = Colors.deepOrangeAccent;
  int rowID, colId;
  bool isSelected = false;
  Color c = NYCWSq.normalColor;

  String displayChar = "A";

  NYCWSq(this.rowID, this.colId) {
    squares.add(this);
  }

  @override
  _NYCWSqState createState() => _NYCWSqState();
}

class _NYCWSqState extends State<NYCWSq> {
  //final _chars = 'ABCDEGFHIJKLMNO';

  //Random _rnd = Random();

  // String getRandomString(int length) => _rnd.nextBool()
  //     ? ""
  //     : String.fromCharCodes(Iterable.generate(
  //         length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  @override
  Widget build(BuildContext context) {
    //Color c;
    //c = computeColor(c);

    print("Build");
    return InkWell(
      splashColor: Colors.blue.withAlpha(30),
      onTap: () {
        print('Card tapped.' + NYCWSq.squares.length.toString());
        int n = 0;
        for (var s in NYCWSq.squares) {
          n++;
          // print("n:" + (n++).toString());
          colorSquares(s, n);
        }
      },
      child: Container(
          color: widget.c,
          height: 40.0,
          width: 60.0,
          child: Center(child: Text(widget.displayChar))),
    );
  }

  void colorSquares(NYCWSq s, int n) {
    setState(() {
      print("c");
      s.isSelected = (s == widget);
      if (s.isSelected) {
        print("----if--" + n.toString());

        s.displayChar = "C";
        s.c = NYCWSq.selectedColor;
        //c = Colors.amber;
//      c = (s.isSelected == true) ? NYCWSq.selectedColor : NYCWSq.normalColor;
        //   aa(s, "1");
        // } else {
        //   aa(s, "2");
      } else {
        print("--else--" + n.toString());
        s.displayChar = "B";
        s.c = NYCWSq.normalColor;
        //c = Colors.red;
      }
    });
  }

  // Color computeColor2(Color c) {
  //   int r = _rnd.nextInt(100);
  //   r < 10
  //       ? c = NYCWSq.unusedColor
  //       : r < 15
  //           ? c = NYCWSq.selectedColor
  //           : r < 30
  //               ? c = NYCWSq.selectedRowColor
  //               : c = NYCWSq.normalColor;
  //   return c;
  // }
}
