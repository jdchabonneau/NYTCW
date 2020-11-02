import 'package:flutter/material.dart';
import 'dart:math';

class NYCWSq extends StatefulWidget {
  static final squares = List<NYCWSq>();
  static bool doingRows = true;

  static Color normalColor = Colors.yellow;
  static Color unusedColor = Colors.black;
  static Color selectedColor = Colors.deepOrange;
  static Color selectedRowColor = Colors.deepOrangeAccent;
  static double width;
  Function cb;
  Function cs;
  final int rowId;
  final int colId;
  bool isUnused = false;
  bool isHilighted = false;
  bool isSelected = false;
  Color c = NYCWSq.normalColor;

  String displayChar = "A";

  NYCWSq(this.rowId, this.colId) {
    squares.add(this);
    if (squares.length == 1) {
      this.isUnused = true;
    }
  }

  static void selectSquare() {
    for (var s in NYCWSq.squares) {
      if (s.isSelected) {
        s.cb();
      }
    }
  }

  static void changeDispChar(inputChar) {
    var previous;
    for (var s in NYCWSq.squares) {
      if (s.isSelected) {
        if (inputChar == "<") {
          inputChar = " ";
          s.isSelected = false;
          previous.isSelected = true;
        }
        s.displayChar = inputChar;
      }
      previous = s;

      s.cs(s, null);
      s.cb();
    }
    // int i = cb(9);
    // print("**jjj: $rowId - $colId, $i");
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
    NYCWSq.width =
//        (MediaQuery.of(context).size.width / NYCWSq.squares.length).floor();
        (MediaQuery.of(context).size.width / sqrt(NYCWSq.squares.length));
//    double height = MediaQuery.of(context).size.height;
    widget.cs = (a, b) {
      colorSquares(a);
    };
    widget.cb = () {
      setState(() {});
    };

    //print("Build");
    return InkWell(
      splashColor: Colors.blue.withAlpha(30),
      onTap: () {
        print("w.x = ${widget.c}");
        if (widget.c != NYCWSq.normalColor) {
          NYCWSq.doingRows = !NYCWSq.doingRows;
        }

//        print('Card tapped.' + NYCWSq.squares.length.toString());
        //int n = 0;
        for (var s in NYCWSq.squares) {
          colorSquares(s);
        }
        if (NYCWSq.doingRows) {
          highlightRow(widget.rowId, widget);
        } else {
          highlightColumn(widget.colId, widget);
        }
      },
      child: Container(
          color: widget.c,
          height: NYCWSq.width,
          width: NYCWSq.width,
          child: Center(child: Text(widget.displayChar))),
    );
  }

  void highlightColumn(int colId, NYCWSq selectedSquare) {
//    setState(() {
    for (var s in NYCWSq.squares) {
      if (s.isUnused) {
        s.c = NYCWSq.unusedColor;
        continue;
      }

      if (s != selectedSquare) if (s.colId == colId) {
        s.c = NYCWSq.selectedRowColor;
        s.isHilighted = true;
//        s.c = Colors.amber;
//        print("yes: ${s.colId}, ${s.rowId}");
      } else {
        s.c = NYCWSq.normalColor;
        s.isHilighted = false;
        //      print("no: ${s.colId}, ${s.rowId}");
      }
      s.cb();
    }
    //  });
  }

  void highlightRow(int rowId, NYCWSq selectedSquare) {
//    setState(() {
    for (var s in NYCWSq.squares) {
      if (s.isUnused) {
        print("unused: ${s.colId}, ${s.rowId}");
        s.c = NYCWSq.unusedColor;
        s.cb();
        continue;
      }
      if (s != selectedSquare) if (s.rowId == rowId) {
        s.c = NYCWSq.selectedRowColor;
        // print("yes: ${s.colId}, ${s.rowId}");
      } else {
        s.c = NYCWSq.normalColor;
        //print("no: ${s.colId}, ${s.rowId}");
      }
      s.cb();
    }
    //});
  }

  void colorSquares(NYCWSq s) {
    setState(() {
      if (s.isUnused) {
        s.c = NYCWSq.unusedColor;
        return;
      }
      s.isSelected = (s == widget);
      if (s.isSelected) {
        s.c = NYCWSq.selectedColor;
      } else {
        s.c = NYCWSq.normalColor;
      }
    });
  }
}
