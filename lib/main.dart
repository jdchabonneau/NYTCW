import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

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
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: List.generate(numRows, (index) {
          return makeRow(index);
        }));
  }

  Row makeRow(int rowID) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(numCols, (index) {
        return NYCWSq(rowID, index);
      }),
    );
  }

  Widget aa2() {
    return Container(
      child: Card(
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            print('Card tapped.');
          },
          child: Row(
            children: [
              Container(
                width: 25,
                height: 15,
                color: Colors.cyan,
              ),
              Container(
                width: 25,
                height: 15,
                color: Colors.pink,
              ),
              Container(
                width: 25,
                height: 15,
                color: Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget aa1(int numCols, int rowID) {
    return GridView.count(
        crossAxisCount: numCols,
        children: List.generate(numCols * numRows, (index) {
          print("index: " + index.toString());
          //eturn Text("index: " + index.toString());
          return InkWell(
            child: Container(
              width: 15,
              height: 15,
              child: Card(
                color: Colors.pink,
              ),
            ),
          );
        }));
  }
}

class NYCWSq extends StatefulWidget {
  static final squares = List<NYCWSq>();
  static Color normalColor = Colors.yellow;
  static Color unusedColor = Colors.black;
  static Color selectedColor = Colors.deepOrange;
  static Color selectedRowColor = Colors.deepOrangeAccent;
  int rowID, colId;
  bool isSelected = false;

  String displayChar = "P";

  NYCWSq(this.rowID, this.colId) {
    squares.add(this);
  }

  @override
  _NYCWSqState createState() => _NYCWSqState();
}

class _NYCWSqState extends State<NYCWSq> {
  Color c = NYCWSq.normalColor;

  final _chars = 'ABCDEGFHIJKLMNO';

  Random _rnd = Random();

  String getRandomString(int length) => _rnd.nextBool()
      ? ""
      : String.fromCharCodes(Iterable.generate(
          length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  @override
  Widget build(BuildContext context) {
    //Color c;
    //c = computeColor(c);
    return InkWell(
      splashColor: Colors.blue.withAlpha(30),
      onTap: () {
        print('Card tapped.');
        for (var s in NYCWSq.squares) {
          s.isSelected = (s == widget);
          c = (s.isSelected == true)
              ? NYCWSq.selectedColor
              : NYCWSq.normalColor;
        }
      },
      child: Container(
          color: c,
          height: 40.0,
          width: 60.0,
          child: Center(child: Text(widget.displayChar))),
    );
  }

  //Color computeColor(Color c) {}

  Color computeColor2(Color c) {
    int r = _rnd.nextInt(100);
    r < 10
        ? c = NYCWSq.unusedColor
        : r < 15
            ? c = NYCWSq.selectedColor
            : r < 30
                ? c = NYCWSq.selectedRowColor
                : c = NYCWSq.normalColor;
    return c;
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            NYCWGrid(7, 5),
            Text(
              'You have rushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
