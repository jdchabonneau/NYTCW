//import 'dart:math';

import 'NYCWSq.dart';
import 'package:flutter/material.dart';

class NYCWGrid extends StatelessWidget {
  int numRows, numCols;
  //// final _random = new Random();
  NYCWGrid(this.numRows, this.numCols);
  @override
  Widget build(BuildContext context) {
    //return aa1(3, 3);
    return drawGrid();
    // Text("NYCWGrid");
  }

  Widget drawGrid() {
    NYCWSq.squares.clear();
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: List.generate(numRows, (index) {
          var rt = makeRow(index);
          return rt;
        }));
  }

  Row makeRow(int rowID) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(numCols, (index) {
        //int z = _random.nextInt(100);
        print("v");
        var v = NYCWSq.squares[rowID * numCols + index];

        print("rowID: $rowID : " + v.toString());

//        print("NYCWSq(rowID=$rowID, index=$index, z < 10=$z, 'p')");
        print(
            "NYCWSq(rowID=$rowID, index=$index, z =${v.isUnused}, ${v.char})");
        return NYCWSq(rowID, index, v.isUnused, v.char);
      }),
    );
  }
}
