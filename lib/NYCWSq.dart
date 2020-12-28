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
  bool isUnused = false;
  bool isCircled = false;
  bool isHilighted = false;
  bool isSelected = false;
  bool wasExposed = false;
  Color c = NYCWSq.normalColor;
  String squareNumber = " ";
  static int nextSquareNumber = 1;

  String displayChar = " ";
  String char = " ";

  NYCWSq(this.rowId, this.colId, this.isUnused, this.isCircled, this.char) {
    char = char.toUpperCase();
    squares.add(this);
    // if (squares.length == 1 ||
    //     squares.length == 5 ||
    //     squares.length == 21 ||
    //     squares.length == 25) {
    //   this.isUnused = true;
    // }

    try {
      assignNumber();
    } on Exception catch (e) {
      print(e);
      // TODO
    }
    if (this.isUnused) {
      this.char = "";
    }
    this.displayChar = this.char;
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
    var ss = "";
    print("atRowCol($rowId, $colId) -- length=${squares.length}");
    for (var s in NYCWSq.squares) {
      ss += ("[${s.rowId}, ${s.colId}]");
    }
    print(ss);
    for (var s in NYCWSq.squares) {
      if (s.rowId == rowId && s.colId == colId) {
        return s;
      }
    }
    return NYCWSq.squares[0];
    //return null;
  }

  bool topOfColumn() {
    if (this.rowId == 0) return true;
    var jj = atRowCol(rowId - 1, colId);
    return jj.isUnused;
//    return atRowCol(rowId - 1, colId).isUnused;
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
        //print("w.x = ${widget.c}");
        if (widget.c == NYCWSq.selectedColor) {
          NYCWSq.doingRows = !NYCWSq.doingRows;
        }

//        print('Card tapped.' + NYCWSq.squares.length.toString());
        //int n = 0;
        for (var s in NYCWSq.squares) {
          colorSquares(s);
        }
        if (NYCWSq.doingRows) {
          highlightRow(widget);
        } else {
          highlightColumn(widget);
        }
      },
      child: Stack(
        children: [
          buildBox(),
          widget.isCircled ? buildCircle() : Text(""),
          widget.isInError && !widget.isUnused
              ? diagonalStrikethrough(ss)
              : Container(),
          widget.wasExposed && !widget.isUnused
              ? CustomPaint(
                  painter: TrianglePainter(),
                  child: Container(
                    height: NYCWSq.width,
                    width: NYCWSq.width,
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  Container buildCircle() {
    return Container(
      //alignment: FractionalOffset(99.5, 99.5),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.red.withOpacity(0.5),
          width: NYCWSq.width * .50,
        ),
        shape: BoxShape.circle,
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
                            fontSize: NYCWSq.width * .25),
                      )),
                  Container(
                      //color: Colors.blue,
                      height: NYCWSq.width * .65,
                      width: NYCWSq.width,
                      child: Center(
                          heightFactor: 2.5,
                          child: Text(
                            widget.displayChar,
                            style: TextStyle(
                                color: Colors.purple[100],
                                fontWeight: FontWeight.bold,
                                fontSize: NYCWSq.width * .65),
                            textAlign: TextAlign.center,
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

  void highlightColumn(NYCWSq selectedSquare) {
    for (var s in NYCWSq.squares) {
      if (s.isUnused) {
        s.c = NYCWSq.unusedColor;
        continue;
      }

      if (s != selectedSquare) {
        var smCol = sameColumn(s, selectedSquare);
        print(
            "smCol = $smCol, col=${s.colId} - ${selectedSquare.colId}, s.rowId=${s.rowId} - ${selectedSquare.rowId})");
        if (sameColumn(s, selectedSquare)) {
          s.c = NYCWSq.selectedRowColor;
          s.isHilighted = true;
        } else {
          s.c = NYCWSq.normalColor;
          s.isHilighted = false;
        }
        s.callBackSetState();
      }
    }
  }

  bool sameColumn(NYCWSq sq1, sq2) {
    if (sq1.colId != sq2.colId) return false;
    List<int> t2 = getRowBorders(sq1);
    var c1 = 0;
    var c2 = 0;

    for (int i = 0; i < t2.length; i++) {
      if (sq1.rowId > t2[i]) c1 = i + 1;
      if (sq2.rowId > t2[i]) c2 = i + 1;
    }
    return c1 == c2;
  }

  bool sameRow(NYCWSq sq1, sq2) {
    if (sq1.rowId != sq2.rowId) return false;
    List<int> t2 = getColBorders(sq1);
    var c1 = 0;
    var c2 = 0;

    for (int i = 0; i < t2.length; i++) {
      if (sq1.colId > t2[i]) c1 = i + 1;
      if (sq2.colId > t2[i]) c2 = i + 1;
    }
    return c1 == c2;
  }

  List<int> getRowBorders(NYCWSq sq1) {
    var borders =
        NYCWSq.squares.where((sq) => sq.isUnused && sq.colId == sq1.colId);
    var tt = borders.map((e) => e.rowId);
    List<int> t2 = tt.toList();
    t2.sort();
    return t2;
  }

  List<int> getColBorders(NYCWSq sq1) {
    var borders =
        NYCWSq.squares.where((sq) => sq.isUnused && sq.rowId == sq1.rowId);
    var tt = borders.map((e) => e.colId);
    List<int> t2 = tt.toList();
    t2.sort();
    return t2;
  }

  void highlightRow(NYCWSq selectedSquare) {
//    setState(() {
    for (var s in NYCWSq.squares) {
      if (s.isUnused) {
        // print("unused: ${s.colId}, ${s.rowId}");
        s.c = NYCWSq.unusedColor;
        s.callBackSetState();
        continue;
      }
      if (s != selectedSquare) {
        var smRow = sameColumn(s, selectedSquare);
        print(
            "smCol = $smRow, col=${s.colId} - ${selectedSquare.colId}, s.rowId=${s.rowId} - ${selectedSquare.rowId})");
        if (sameRow(s, selectedSquare)) {
          s.c = NYCWSq.selectedRowColor;
          s.isHilighted = true;
        } else {
          s.c = NYCWSq.normalColor;
          s.isHilighted = false;
        }
        s.callBackSetState();
      }
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
