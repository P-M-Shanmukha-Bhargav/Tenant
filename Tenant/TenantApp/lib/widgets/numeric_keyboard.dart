import 'package:flutter/material.dart';

typedef KeyboardTapCallback = void Function(String text);

class NumericKeyboard extends StatefulWidget {
  final Color textColor;
  final Icon rightIcon;
  final Function() rightButtonFn;
  final Icon leftIcon;
  final Function() leftButtonFn;
  final KeyboardTapCallback onKeyboardTap;
  final MainAxisAlignment mainAxisAlignment;

  NumericKeyboard(
      {Key? key,
      required this.onKeyboardTap,
      this.textColor = Colors.black,
      required this.rightButtonFn,
      required this.rightIcon,
      required this.leftButtonFn,
      required this.leftIcon,
      this.mainAxisAlignment = MainAxisAlignment.spaceEvenly})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _NumericKeyboardState();
  }
}

class _NumericKeyboardState extends State<NumericKeyboard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 32, right: 32, top: 20),
        alignment: Alignment.center,
        child: GridView.count(
            shrinkWrap: true,
            crossAxisCount: 3,
            childAspectRatio: 1.6,
            mainAxisSpacing: 10,
            padding: EdgeInsets.all(8),
            children: <Widget>[
              _calcButton('1'),
              _calcButton('2'),
              _calcButton('3'),
              _calcButton('4'),
              _calcButton('5'),
              _calcButton('6'),
              _calcButton('7'),
              _calcButton('8'),
              _calcButton('9'),
              Container(
                alignment: Alignment.center,
                width: 50,
                height: 50,
                child: InkResponse(
                    borderRadius: BorderRadius.circular(45),
                    onTap: widget.leftButtonFn,
                    child: Visibility(
                      visible: widget.leftIcon != null,
                      child: Container(
                          alignment: Alignment.center,
                          width: 50,
                          height: 50,
                          child: widget.leftIcon),
                    )),
              ),
              _calcButton('0'),
              InkResponse(
                  borderRadius: BorderRadius.circular(45),
                  onTap: widget.rightButtonFn,
                  child: Container(
                      alignment: Alignment.center,
                      width: 50,
                      height: 50,
                      child: widget.rightIcon))
            ]));
  }

  Widget _calcButton(String value) {
    return InkResponse(
        borderRadius: BorderRadius.circular(100),
        onTap: () {
          widget.onKeyboardTap(value);
        },
        child: Container(
          alignment: Alignment.center,
          width: 50,
          height: 50,
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColorDark.withOpacity(0.6),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).primaryColorDark.withOpacity(0.6),
                  blurRadius: 10,
                  spreadRadius: 0,
                )
              ]),
          child: Text(
            value,
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
        ));
  }
}
