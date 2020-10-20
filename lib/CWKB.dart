import 'package:flutter/material.dart';

class CWKB extends StatelessWidget {
  int ind;
  Widget keyRow(String s) {
    List<Widget> l = List();
    s = s.toUpperCase();
    List.generate(
      s.length,
      (index) => l.add(
        InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            print(s[index]);
          },
          child: Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(
                  width: 1.0,
                ), // color: Color(0xFFFFFFFFFF)),
                left: BorderSide(
                  width: 1.0,
                ), // color: Color(0xFFFFFFFFFF)),
                right: BorderSide(
                  width: 1.0,
                ), // color: Color(0xFFFF000000)),
                bottom: BorderSide(
                  width: 1.0,
                ), // color: Color(0xFFFF000000)),
              ),
            ),
            child: SizedBox(
              height: 30,
              width: 30,
              child: Center(child: Text(s[index])),
            ),
          ),
        ),
      ),
    );
    return Container(
      width: 400,
      height: 50,
      //color: Colors.pink,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: l),
    );
  }

  @override
  Widget build(BuildContext context) {
//    return Text("oo");
    return Container(
        //color: Colors.blue,
        child: Column(children: [
      keyRow("qwertyuiop"),
      keyRow("asdfghjkl"),
      keyRow(".zxcvbnm<"),
    ]));
  }
}
