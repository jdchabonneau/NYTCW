import 'dart:convert';
//import 'dart:ui';

//import 'package:flutter/cupertino.dart';
import 'package:nytCW/puzzles.dart';

import 'CWKB.dart';
import 'NYCWSq.dart';

//import 'NYCWSq.dart';

class CWFileReader {
  Map wordsMap = Map();

  void parseFile(String pathToFile) {
    List<String> fileSections = Jan092021.jjj();
//    List<String> fileSections = DNums.jjj();
    var wordSection = fileSections[2];
    var hintSection = fileSections[3];
    List<String> wordsAcrossWithNums = wordSection.split(";");

    parseWords(wordsAcrossWithNums);
    parseHints(hintSection);
  }

  void parseHints(String hintsSection) {
    LineSplitter ls = LineSplitter();
    List<String> lines = ls.convert(hintsSection);
    //var hints = lines.split(":");
    //print("lines.length= ${lines.length}");
    //var i = 0;
    for (var line in lines) {
      var h = line.split(":");
      if (h.length == 2) {
        //   print("hint: ${h.length} - $h[0]");
        //print("hint2: ${++i} - ${h[0]} ${h[1]}");
        CWHintBar.definitions[h[0]] = h[1];
      }
    }
  }

  void parseWords(List<String> words2) {
    NYCWSq.squares.clear();
    NYCWSq.nextSquareNumber = 1;
    int boardSize = 7;
    for (var lineInfo in words2) {
      var num_word = lineInfo.split(":");
      // var acrossWords;
      if (num_word.length > 1) {
//        print(
//            "lineInfo=$lineInfo ${num_word.length} xx[0]=${num_word[0]} xx[1]=${num_word[1]}");
        wordsMap[int.parse(num_word[0])] = num_word[1];
        int j = NYCWSq.squares.length % boardSize;
        for (int i = j; i < num_word[1].length + j; i++) {
          String c = num_word[1][i - j];

          int rowId = NYCWSq.squares.length ~/ boardSize;
          //      int colId = rowId % 4;
          //int rowId = i ~/ 4;
          int colId = i % 7;
          //print("SQ:$i c=$c [$rowId, $colId]");
          NYCWSq(rowId, colId, c == "-",
              'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.contains(c), c);
        }
      }
    }
    // print("wordsMap.toString() " + wordsMap.toString());
  }
}
