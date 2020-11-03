import 'NYCWSq.dart';
import 'package:flutter/material.dart';

class NYCWGrid extends StatelessWidget {
  int numRows, numCols;
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
          return makeRow(index);
        }));
  }

  Row makeRow(int rowID) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(numCols, (index) {
        return NYCWSq(rowID, index);
      }),
    );
  }
}
