import 'package:flutter/material.dart';

class NYCWSq extends StatefulWidget {
  static final squares = List<NYCWSq>();
  static Color normalColor = Colors.yellow;
  static Color unusedColor = Colors.black;
  static Color selectedColor = Colors.deepOrange;
  static Color selectedRowColor = Colors.deepOrangeAccent;
  final int rowId;
  final int colId;
  bool isSelected = false;
  Color c = NYCWSq.normalColor;

  String displayChar = "A";

  NYCWSq(this.rowId, this.colId) {
    print("--cstr-- + ${this.rowId} - ${this.colId}");

    squares.add(this);
  }

  void jjj() {
    print("**jjj: $rowId - $colId");
  }
//    setState

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

    //print("Build");
    return InkWell(
      splashColor: Colors.blue.withAlpha(30),
      onTap: () {
//        print('Card tapped.' + NYCWSq.squares.length.toString());
        //int n = 0;
        for (var s in NYCWSq.squares) {
          //n++;
          // print("n:" + (n++).toString());
          colorSquares(s, widget);
        }
      },
      child: Container(
          color: widget.c,
          height: 40.0,
          width: 60.0,
          child: Center(child: Text(widget.displayChar))),
    );
  }

  void colorSquares(NYCWSq s, NYCWSq tappedSquare) {
    print(
        "** ${widget.rowId} - ${widget.colId} % ${s.rowId} - ${s.colId} % ${tappedSquare.rowId} - ${tappedSquare.colId}");

    setState(() {
      s.isSelected = (s == widget);
      if (s.isSelected) {
        print("----if-- + ${widget.rowId} - ${widget.colId}");

        s.displayChar = s.displayChar == "D" ? "B" : "D";
        s.c = NYCWSq.selectedColor;
      } else {
        s.jjj();
        print("----else-- + ${widget.rowId} - ${widget.colId}");
        s.displayChar = "X";
        s.c = NYCWSq.normalColor;
      }
    });
  }
}
