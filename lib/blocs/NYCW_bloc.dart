// import 'package:flutter/material.dart';

// String _hint;

// class NYCWBloc extends ChangeNotifier {
//   String get hint => _hint;

//   void setHint(int number, bool doingRows) {
//     _hint = "hint: $number $doingRows";
//     notifyListeners();
//   }
// }
import 'package:flutter/material.dart';

class Xxx extends InheritedWidget {
  const Xxx(
    this.hint,
    Widget child,
  ) : super(child: child);

  final String hint;

  @override
  bool updateShouldNotify(Xxx oldWidget) {
    return true;
  }

  static Xxx of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<Xxx>();
}
