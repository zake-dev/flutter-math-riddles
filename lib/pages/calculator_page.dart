import 'package:flutter/material.dart';
import 'package:math_riddles/utils/size_config.dart';

final keyHeight = SizeConfig.safeBlockVertical * 10;
final keyWidth = SizeConfig.safeBlockHorizontal * 13;

class CalculatorPage extends StatefulWidget {
  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final Map<String, Function(int, int)> operations = {
    '+': (x, y) => (x + y).toString(),
    '\u2212': (x, y) => (x - y).toString(),
    '\u00D7': (x, y) => (x * y).toString(),
    '\u00F7': (x, y) {
      if (y == 0) return 'Divided by 0';
      double rawResult = (x / y);
      String result = (rawResult.toInt() == rawResult)
          ? rawResult.round().toString()
          : rawResult.toString();
      return result.substring(0, (result.length < 12) ? result.length : 12);
    },
  };
  TextEditingController _controller;
  String _operator;
  bool _operatorSelected = false;
  bool _rightOperandEntered = false;
  int _leftOperand = 0;

  @override
  void initState() {
    super.initState();
    this._controller = new TextEditingController(text: '0');
  }

  @override
  Widget build(BuildContext context) {
    final keypad = _buildKeypad();

    return Container(
      height: SizeConfig.safeBlockVertical * 60,
      width: SizeConfig.safeBlockHorizontal * 60,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildInputBox(),
          keypad[0],
          keypad[1],
          keypad[2],
          keypad[3],
        ],
      ),
    );
  }

  Widget _buildInputBox() {
    return Container(
      width: SizeConfig.safeBlockHorizontal * 60,
      height: SizeConfig.safeBlockVertical * 8,
      decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.circular(5)),
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(
              left: SizeConfig.safeBlockHorizontal * 3,
              right: SizeConfig.safeBlockHorizontal * 3),
        ),
        readOnly: true,
        textAlign: TextAlign.end,
        textAlignVertical: TextAlignVertical.center,
        style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: SizeConfig.safeBlockVertical * 5,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).primaryColor,
            height: 1),
      ),
    );
  }

  List<Widget> _buildKeypad() {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildNumberKey('7'),
          _buildNumberKey('8'),
          _buildNumberKey('9'),
          _buildOperatorKey('\u00F7'),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildNumberKey('4'),
          _buildNumberKey('5'),
          _buildNumberKey('6'),
          _buildOperatorKey('\u00D7'),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildNumberKey('1'),
          _buildNumberKey('2'),
          _buildNumberKey('3'),
          _buildOperatorKey('\u2212'),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildNumberKey('0'),
          _buildClearKey(),
          _buildCalculateKey(),
          _buildOperatorKey('+'),
        ],
      ),
    ];
  }

  Widget _buildNumberKey(String buttonText) {
    return Container(
      width: keyWidth,
      height: keyHeight,
      child: RawMaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        elevation: 0.0,
        fillColor: Colors.grey,
        child: Text(
          buttonText,
          style: TextStyle(
            color: Theme.of(context).accentColor,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w700,
            fontSize: SizeConfig.safeBlockHorizontal * 6,
          ),
        ),
        onPressed: () {
          if (_controller.text.length == 11) return;
          if (_controller.text == '0') {
            _controller.clear();
          }
          if (_operatorSelected) {
            _controller.clear();
            _operatorSelected = false;
            _rightOperandEntered = true;
          }
          _controller.text += buttonText;
        },
      ),
    );
  }

  Widget _buildOperatorKey(String buttonText) {
    return Container(
      width: keyWidth,
      height: keyHeight,
      child: RawMaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        elevation: 0.0,
        fillColor: Colors.indigo.shade300,
        child: Text(
          buttonText,
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w700,
            fontSize: SizeConfig.safeBlockHorizontal * 7.5,
          ),
        ),
        onPressed: () {
          if (_rightOperandEntered) {
            final operations = {
              '+': (x, y) => (x + y).toString(),
              '\u2212': (x, y) => (x - y).toString(),
              '\u00D7': (x, y) => (x * y).toString(),
              '\u00F7': (x, y) {
                return y != 0 ? (x / y).toString() : 'Divided by 0';
              },
            };

            final int rightOperand = int.parse(_controller.text);

            if (_operator == null) return;
            final String result =
                operations[_operator](_leftOperand, rightOperand);
            clear();
            _controller.text = result;
          }

          this._operator = buttonText;
          this._leftOperand = int.parse(this._controller.text);
          this._operatorSelected = true;
        },
      ),
    );
  }

  Widget _buildClearKey() {
    return Container(
      width: keyWidth,
      height: keyHeight,
      child: RawMaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        elevation: 0.0,
        fillColor: Colors.amber.shade700,
        child: Text(
          'C',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w700,
            fontSize: SizeConfig.safeBlockHorizontal * 6,
          ),
        ),
        onPressed: () {
          clear();
        },
      ),
    );
  }

  Widget _buildCalculateKey() {
    return Container(
      width: keyWidth,
      height: keyHeight,
      child: RawMaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        elevation: 0.0,
        fillColor: Colors.red.shade600,
        child: Text(
          '=',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w700,
            fontSize: SizeConfig.safeBlockHorizontal * 6,
          ),
        ),
        onPressed: () {
          final int rightOperand = int.parse(_controller.text);

          if (_operator == null) return;
          final String result =
              operations[_operator](_leftOperand, rightOperand);

          clear();
          _controller.text = result;
        },
      ),
    );
  }

  void clear() {
    this._controller.clear();
    this._controller.text += '0';
    this._leftOperand = 0;
    this._operatorSelected = false;
    this._rightOperandEntered = false;
    this._operator = null;
  }
}
