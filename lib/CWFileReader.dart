import 'dart:convert';
//import 'dart:ui';

import 'package:nytCW/puzzles.dart';

//import 'NYCWSq.dart';

class CWFileReader {
  Map wordsMap = Map();
  Map definitions = Map();

  void parseFile(String pathToFile) {
    List<String> ss = D.jjj();
//    var i = ss.length;
//    var s1 = ss[0];
//    var s2 = ss[1];
    var s3 = ss[2];
    var hintSection = ss[3];
    //  var comment = s[1].trim();
    List<String> words2 = s3.split(";");

    parseWords(words2);
    parseHints(hintSection);
  }

  void parseHints(String hintsSection) {
    LineSplitter ls = LineSplitter();
    List<String> lines = ls.convert(hintsSection);
    //var hints = lines.split(":");
    print("lines.length= ${lines.length}");
    var i = 0;
    for (var line in lines) {
      if (line.length == 2) {
        var h = line.split(":");
        print("hint: ${h.length} - $h[0]");
        print("hint2: ${++i} - ${h[0]} ${h[1]}");
      }
    }
  }

  void parseWords(List<String> words2) {
    for (var lineInfo in words2) {
      var xx = lineInfo.split(":");
      // var accrossWords;
      if (xx.length > 1) {
        print("lineInfo=$lineInfo ${xx.length} xx[0]=${xx[0]} xx[1]=${xx[1]}");
        // ignore: unnecessary_statements
        wordsMap[xx[0]] = xx[1];
      }
    }
    print("wordsMap.toString() " + wordsMap.toString());
  }
}
