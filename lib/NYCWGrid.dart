//import 'dart:math';

import 'package:nytCW/CWFileReader.dart';

import 'NYCWSq.dart';
import 'package:flutter/material.dart';

class NYCWGrid extends StatelessWidget {
  int numRows, numCols;
  CWFileReader parser;
  //// final _random = new Random();
  NYCWGrid(this.numRows, this.numCols);
  @override
  Widget build(BuildContext context) {
    //return aa1(3, 3);

    // ChangeNotifierProvider(
    //   create: (context) => NYCWBloc(),
    //   child: drawGrid(),
    // );

    return drawGrid();
    // Text("NYCWGrid");
  }

  Widget drawGrid() {
    NYCWSq.squares.clear();
    parser = CWFileReader();
    parser.parseFile("");
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: List.generate(numRows, (index) {
          print("go: $index");
          var rt = makeRow(index);
          print("back");
          return rt;
        }));
  }

  Row makeRow2(int rowID) {
    return Row(children: [Text(rowID.toString())]);
  }

  Row makeRow(int rowID) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(numCols, (index) {
        //int z = _random.nextInt(100);
        //print("v");
        print("NYCWSq.squares[$rowID * $numCols + $index]");
        var j = NYCWSq.squares[rowID * numCols + index];
        print("j OK");
        return NYCWSq.squares[rowID * numCols + index];
        //var y = v.colId;
        // var c = this.parser.wordsMap[1];
        // var cv = this.parser.wordsMap.values;
        // print(cv);
        // var cvv = cv.first;
        // print(cvv);
        //var y = v.colId;
        //print("rowID: $rowID : " + v.toString() + y.toString());

//        print("NYCWSq(rowID=$rowID, index=$index, z < 10=$z, 'p')");
//        print(
        //          "NYCWSq(rowID=$rowID, index=$index, z =${v.isUnused}, ${v.char})");
        //return Text("abc d-");
        //    return NYCWSq.squares[rowID * 4 + index];
        //return NYCWSq(rowID, index, (rowID + index) == 0, false, 'u');
      }),
    );
  }
}
