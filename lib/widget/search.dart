import 'package:flutter/material.dart';

class SearchWidget extends StatefulWidget {
  final String text;
  final ValueChanged<String> onChanged;
  final String hintText;

  const SearchWidget({
    Key? key,
    required this.text,
    required this.onChanged,
    required this.hintText,
  }) : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final styleActive = TextStyle(color: Colors.white.withOpacity(0.3));
    final styleHint = TextStyle(color: Colors.white.withOpacity(0.3));
    final style = widget.text.isEmpty ? styleHint : styleActive;

    return Container(alignment: Alignment.center
      ,width: 340,height: 45,decoration:BoxDecoration(color: Color.fromRGBO(255, 255, 255, 0.1),border: Border.all(color: Colors.grey),borderRadius: BorderRadius.only(topRight: Radius.circular(6),topLeft: Radius.circular(15),bottomLeft: Radius.circular(6),bottomRight: Radius.circular(15))),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(

          suffixIcon: widget.text.isNotEmpty
              ? GestureDetector(
            child: Icon(Icons.close, color: style.color),
            onTap: () {
              controller.clear();
              widget.onChanged('');
              FocusScope.of(context).requestFocus(FocusNode());
            },
          )
              : null,
          hintText: widget.hintText,
          hintStyle: style,
          border: InputBorder.none,
          icon: Icon(Icons.search, color: style.color),
        ),
        style: style,
        onChanged: widget.onChanged,
      ),
    );
  }
}