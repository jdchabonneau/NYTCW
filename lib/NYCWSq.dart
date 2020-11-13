import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:math';

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    paint.color = Colors.red;
    // create a path
    var path = Path();
    // path.moveTo(size.width / 2, 0);
    // path.lineTo(size.width / 2, size.height / 4);
    // path.lineTo(size.width / 2 - size.height / 4, 0);
    path.moveTo(size.width / 2, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height / 2);
    print("w:${size.width}, h:${size.height}");
    // close the path to form a bounded shape
    path.close();
    canvas.drawPath(path, paint);
    paint.color = Colors.white;
    canvas.drawCircle(
        Offset(size.width * 0.85, size.height * 0.15), 6.0, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class NYCWSq extends StatefulWidget {
  static final squares = List<NYCWSq>();
  static bool doingRows = true;

  static Color normalColor = Colors.grey;
  static Color unusedColor = Colors.black;
  static Color selectedColor = Colors.lightBlue;
  static Color selectedRowColor = Colors.purple;
  static double width;
  Function callBackSetState;
  Function cs;
  final int rowId;
  final int colId;
  bool isInError = false;
  bool isExposed = false;
  bool isUnused = false;
  bool isHilighted = false;
  bool isSelected = false;
  bool wasExposed = true;
  Color c = NYCWSq.normalColor;
  String squareNumber = " ";
  static int nextSquareNumber = 1;

  String displayChar = " ";
  String char = " ";

  NYCWSq(this.rowId, this.colId) {
    squares.add(this);
    if (squares.length == 1 ||
        squares.length == 5 ||
        squares.length == 21 ||
        squares.length == 25) {
      this.isUnused = true;
    }
    assignNumber();
  }

  void assignNumber() {
    if (this.isUnused || this.squareNumber != " ") {
      return;
    }
    if (topOfColumn()) {
      squareNumber = (nextSquareNumber++).toString();
      return;
    }
    if (startOfRow()) {
      squareNumber = (nextSquareNumber++).toString();
      return;
    }
  }

  NYCWSq atRowCol(int rowId, int colId) {
    for (var s in NYCWSq.squares) {
      if (s.rowId == rowId && s.colId == colId) {
        return s;
      }
    }
    return null;
  }

  bool topOfColumn() {
    if (this.rowId == 0) return true;
    return atRowCol(rowId - 1, colId).isUnused;
  }

  bool startOfRow() {
    if (this.colId == 0) return true;
    return atRowCol(rowId, colId - 1).isUnused;
  }

  static void selectSquare() {
    for (var s in NYCWSq.squares) {
      if (s.isSelected) {
        s.callBackSetState();
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
        } else {}
        s.displayChar = inputChar;
      }
      previous = s;

      s.cs(s, null);
      s.callBackSetState();
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
        (MediaQuery.of(context).size.width /
            (sqrt(NYCWSq.squares.length) + 1.5));
//    double height = MediaQuery.of(context).size.height;
    double ss = sqrt((NYCWSq.width * NYCWSq.width) * 1.8);
    widget.cs = (a, b) {
      colorSquares(a);
    };
    widget.callBackSetState = () {
      setState(() {});
    };

    //print("Build");
    return InkWell(
      splashColor: Colors.blue.withAlpha(30),
      onTap: () {
        print("w.x = ${widget.c}");
        if (widget.c == NYCWSq.selectedColor) {
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
      child: Stack(
        children: [
          buildBox(),
          widget.isInError && !widget.isUnused
              ? diagonalStrikethrough(ss)
              : Container(),
          CustomPaint(
            painter: TrianglePainter(),
            child: Container(
              height: NYCWSq.width,
              width: NYCWSq.width,
            ),
          ),
        ],
      ),
    );
  }

  Container buildBox() {
    return Container(
        color: widget.c,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(0),
              ),
              child: Column(
                children: [
                  Container(
                      height: NYCWSq.width * .35,
                      width: NYCWSq.width,
//                        child: Center(child: Text("2"))),
                      child: Text(
                        widget.squareNumber,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 12),
                      )),
                  Container(
                      //color: Colors.blue,
                      height: NYCWSq.width * .65,
                      width: NYCWSq.width,
                      child: Center(
                          child: Text(
                        widget.displayChar,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ))),
                ],
              ),
            ),
          ],
        ));
  }

  Transform diagonalStrikethrough(double ss) {
    return Transform.rotate(
      origin: Offset(50, 30),
      angle: -pi / 4,
      child: Container(
        color: Colors.red,
        width: ss * .75,
        height: 10,
      ),
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
      s.callBackSetState();
    }
    //  });
  }

  void highlightRow(int rowId, NYCWSq selectedSquare) {
//    setState(() {
    for (var s in NYCWSq.squares) {
      if (s.isUnused) {
        print("unused: ${s.colId}, ${s.rowId}");
        s.c = NYCWSq.unusedColor;
        s.callBackSetState();
        continue;
      }
      if (s != selectedSquare) if (s.rowId == rowId) {
        s.c = NYCWSq.selectedRowColor;
        // print("yes: ${s.colId}, ${s.rowId}");
      } else {
        s.c = NYCWSq.normalColor;
        //print("no: ${s.colId}, ${s.rowId}");
      }
      s.callBackSetState();
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
