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
      // var accrossWords;
      if (xx.length > 1) {
        print("lineInfo=$lineInfo ${xx.length} xx[0]=${xx[0]} xx[1]=${xx[1]}");
        wordsMap[int.parse(xx[0])] = xx[1];

        for (int i = 0; i < xx[1].length; i++) {
          String c = xx[1][i];

          // ignore: unnecessary_statements
          int rowId = NYCWSq.squares.length ~/ 4;
          int colId = rowId % 4;
          NYCWSq(rowId, colId, c == "-", c);
        }
      }
    }
    // print("wordsMap.toString() " + wordsMap.toString());
  }
}

class LLE {
  LL parent;
  int _data;
  LLE _nxt;

  LLE(this.parent);
}

class LL {
  LLE head;
  LL() {
    // head = LLE(this);
  }

  LLE tail() {
    var h = this.head;
    if (h == null) return null;
    if (h._nxt == null) {
      return h;
    }
    while (h._nxt != null) {
      h = h._nxt;
    }
    return h;
  }

  add(int d) {
    var t = tail();
    if (this.head == null) {
      head = LLE(this);
      head._data = d;
    } else {
      t._nxt = LLE(t.parent);
      t._nxt._data = d;
    }
  }

  LL bild() {
    LL h = LL();
    h.toString2("AA");
    h.add(1);
    h.toString2("A1");
    h.add(2);
    h.toString2("A2");
    h.add(3);
    h.toString2("A3");
    h.add(44);
    h.toString2("A4");
    h.add(55);
    h.toString2("A5");
    return h;
  }

  List<LLE> toList() {
    var l = List<LLE>();
    var h = this.head;
    while (h != null) {
      l.add(h);
      h = h._nxt;
    }
    return l;
  }

  void listToString(String s, List<LLE> l) {
    int i = 0;
    for (var n in l) {
      print("listToString($s, ${i++}): ${n._data}");
    }
  }

  reverse() {
    var l = toList();
    var h = head;
    //listToString("before", l);
    for (int i = l.length - 1; i >= l.length / 2; i--) {
      //var s = "i=$i, h.data = ${h._data},  l[i]._data = ${l[i]._data}";
      //print(s);
      var temp = h._data;
      h._data = l[i]._data;
      l[i]._data = temp;
      h = h._nxt;
      this.toString2("ppp");
    }
    //listToString("after", l);
  }

  doIt() {
    LL ll = LL();
    ll.toString2("empty");
    //  ll.reverse();
    ll.toString2("reversed");
    ll.add(1);
    ll.toString2("1");
    //  ll.reverse();
    ll.toString2("R1");
    ll.add(2);
    ll.toString2("2");
    //  ll.reverse();
    ll.toString2("R2");
    ll.add(3);
    ll.toString2("3");
    //  ll.reverse();
    ll.toString2("R3");
    ll.add(4);
    ll.toString2("4");
    // ll.reverse();
    ll.toString2("R4");
    ll.add(5);
    ll.toString2("5");
    ll.reverse();
    ll.toString2("R5");
    ll.reverse();
    ll.toString2("RR5");
  }

  doIt2() {
    LL ll = bild();
    ll.toString2("bild");
    ll.reverse();
    ll.toString2("reversed");
    ll.reverse();
    ll.toString2("unreversed");
  }

  void toString2(String note, {bool oneLine = true}) {
    var h = this.head;
    String s = "$note: ";
    int i = 0;
    while (h != null) {
      if (oneLine) {
        s += "(${i++}) ${h._data};  ";
      } else {
        print("toString2 $note (${i++}) ${h._data}");
      }
      h = h._nxt;
    }
    if (oneLine) {
      print("toString2 " + s);
    }
  }
}
