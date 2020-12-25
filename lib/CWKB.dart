import 'package:flutter/material.dart';

import 'NYCWSq.dart';

class CWHintBar extends StatefulWidget {
  String hint = "ppp";
  @override
  _CWHintBarState createState() => _CWHintBarState();
}

class _CWHintBarState extends State<CWHintBar> {
  @override
  Widget build(BuildContext context) {
//    return Text("oo");
    return Container(
        height: 68,
        width: MediaQuery.of(context).size.width * .8,
        margin: EdgeInsets.all(12.0),
        color: Colors.purple,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: IconButton(
                      onPressed: () {
                        print("Lefty!");
                      },
                      icon: Icon(Icons.arrow_left),
                      tooltip: 'left',
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * .55,
                    child: (Text(
//                      "aBobby stutters stutters stutters stutters stutters A aBobby stutters stutters stutters stutters stutters A aBobby stutters stutters stutters stutters stutters A stutters B stutters C stutters D stutters ",
                      widget.hint, //"aBubby A aBoutters stutters stutters",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: TextStyle(
                          //fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 15),
                    )),
                  ),
                  Center(
                    child: IconButton(
                      onPressed: () {
                        print("Righty!");
                      },
                      icon: Icon(Icons.arrow_right),
                      tooltip: 'right',
                    ),
                  )
                ],
              )
            ]));
  }
}

class CWKB extends StatelessWidget {
  int ind;
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

  Widget keyRow(String s) {
    List<Widget> l = List<Widget>();
    s = s.toUpperCase();
    List.generate(
      s.length,
      (index) => l.add(
        InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            print(s[index]);
            NYCWSq.changeDispChar(s[index]);
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
}
