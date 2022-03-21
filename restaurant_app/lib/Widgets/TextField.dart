import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../sizeConfig/sizeConfig.dart';

class textField extends StatefulWidget {
  final Key? key;
  final String? txt;
  final bool obscure;
  final FocusNode? myFocusNode;
  final Function(dynamic)? function;
  final TextInputType? type;
  final int? length;
  final String? Function(String?)? validate;

  const textField({
    this.txt,
    required this.obscure,
    this.myFocusNode,
    this.function,
    this.type,
    this.length,
    this.validate,
    this.key,
  });

  @override
  _textFieldState createState() => _textFieldState();
}

class _textFieldState extends State<textField> {
  bool obscure_text = true;
  dynamic a;
  dynamic b = 0;

  @override
  void initState() {
    super.initState();
    obscure_text = widget.obscure;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: SizeConfig.height! * 2, horizontal: SizeConfig.width! * 7),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white),
      child: Form(
        key: widget.key,
        child: TextFormField(
            validator: widget.validate,
            inputFormatters: [LengthLimitingTextInputFormatter(widget.length)],
            keyboardType: widget.type,
            onChanged: widget.function,
            obscureText: this.obscure_text,
            style: Theme.of(context).textTheme.headline3,
            decoration: InputDecoration(
              suffixIcon: widget.obscure
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          obscure_text = !obscure_text;
                        });
                      },
                      icon: Icon(obscure_text
                          ? Icons.visibility
                          : Icons.visibility_off),
                      color: Colors.teal,
                    )
                  : null,
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
              border: InputBorder.none,
              labelText: widget.txt!,
            )),
      ),
    );
  }
}
