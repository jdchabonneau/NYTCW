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
    List<String> fileSections = DNums.jjj();
//    var i = ss.length;
//    var s1 = ss[0];
//    var s2 = ss[1];
    var s3 = fileSections[2];
    var hintSection = fileSections[3];
    //  var comment = s[1].trim();
    List<String> wordsAcrossWithNums = s3.split(";");

    parseWords(wordsAcrossWithNums);
    parseHints(hintSection);
    // int i = 0;
    // for (var square in NYCWSq.squares) {
    //   print("${i++}: ${square.rowId} - ${square.colId} '${square.char}'");
    // }
    //buildPuzzle();
  }

  void parseHints(String hintsSection) {
    LineSplitter ls = LineSplitter();
    List<String> lines = ls.convert(hintsSection);
    //var hints = lines.split(":");
    print("lines.length= ${lines.length}");
    var i = 0;
    for (var line in lines) {
      var h = line.split(":");
      if (h.length == 2) {
        //   print("hint: ${h.length} - $h[0]");
        print("hint2: ${++i} - ${h[0]} ${h[1]}");
        definitions[h[0]] = h[1];
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
        print(
            "lineInfo=$lineInfo ${num_word.length} xx[0]=${num_word[0]} xx[1]=${num_word[1]}");
        wordsMap[int.parse(num_word[0])] = num_word[1];

        for (int i = 0; i < num_word[1].length; i++) {
          String c = num_word[1][i];

          int rowId = NYCWSq.squares.length ~/ boardSize;
          //      int colId = rowId % 4;
          //int rowId = i ~/ 4;
          int colId = i % 7;
          print("SQ:$i c=$c [$rowId, $colId]");
          NYCWSq(rowId, colId, c == "-",
              'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.contains(c), c);
        }
      }
    }
    // print("wordsMap.toString() " + wordsMap.toString());
  }
}
