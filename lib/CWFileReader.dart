import 'dart:convert';
//import 'dart:ui';

//import 'package:flutter/cupertino.dart';
import 'package:nytCW/puzzles.dart';

import 'NYCWSq.dart';

//import 'NYCWSq.dart';

class CWFileReader {
  Map wordsMap = Map();
  Map definitions = Map();

  checkIntegrity() {
    var wordLength = -1;
    for (var word in wordsMap.values) {
      print("word: $word");
      if (wordLength == -1) {
        wordLength = word.length;
      } else if (word.length != wordLength) {
        //throw Exception("PPP");
      }
    }
  }

  void buildPuzzle() {
    parseFile("");
    checkIntegrity();
    var sortedKeys = wordsMap.keys.toList()..sort();
    for (var key in sortedKeys) {
      var word = wordsMap[key];
      var bw = word.split(":");
      print("wordsMap[$key] == $word ${bw.length}");
    }
  }

  void parseFile(String pathToFile) {
    List<String> ss = E.jjj();
//    var i = ss.length;
//    var s1 = ss[0];
//    var s2 = ss[1];
    var s3 = ss[2];
    var hintSection = ss[3];
    //  var comment = s[1].trim();
    List<String> words2 = s3.split(";");

    parseWords(words2);
    parseHints(hintSection);
    int i = 0;
    for (var square in NYCWSq.squares) {
      print("${i++}: ${square.rowId} - ${square.colId} '${square.char}'");
    }
    //buildPuzzle();
  }

  void parseHints(String hintsSection) {
    LineSplitter ls = LineSplitter();
    List<String> lines = ls.convert(hintsSection);
    //var hints = lines.split(":");
    print("lines.length= ${lines.length}");
    // var i = 0;
    for (var line in lines) {
      if (line.length == 2) {
        //var h = line.split(":");
        //   print("hint: ${h.length} - $h[0]");
        // print("hint2: ${++i} - ${h[0]} ${h[1]}");
      }
    }
  }

  void parseWords(List<String> words2) {
    NYCWSq.squares.clear();
    for (var lineInfo in words2) {
      var xx = lineInfo.split(":");
      // var acrossWords;
      if (xx.length > 1) {
        print("lineInfo=$lineInfo ${xx.length} xx[0]=${xx[0]} xx[1]=${xx[1]}");
        wordsMap[int.parse(xx[0])] = xx[1];

        for (int i = 0; i < xx[1].length; i++) {
          String c = xx[1][i];
          String ss = "";
          int rowId = NYCWSq.squares.length ~/ 4;
          //      int colId = rowId % 4;
          //int rowId = i ~/ 4;
          int colId = i % 4;
          ss += ("SQ:$i c=$c [$rowId, $colId]");
          print(ss);
          NYCWSq(rowId, colId, c == "-", c);
        }
      }
    }
    // print("wordsMap.toString() " + wordsMap.toString());
  }
}
