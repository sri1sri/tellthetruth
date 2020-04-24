import 'package:flutter/material.dart';
import 'package:tellthetruth/widgets/Style.dart';



class CustomIconButton extends StatefulWidget {

  final IconData iconName;

  const CustomIconButton({Key key, this.iconName}) : super(key: key);


  @override
  _CustomIconButtonState createState() => _CustomIconButtonState();
}

class _CustomIconButtonState extends State<CustomIconButton> {
  bool _active = false;



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        setState(() {
          _active= !_active;
        });
      },
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey, //                   <--- border color
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(45),
          color: Color(0xFFEFF4F8),
          boxShadow: softUiShadow,
          gradient: _active ? activeGradient : null,
        ),
        child: Center(
          child: Icon(
            widget.iconName,
            size: 25,
            color: _active ? Colors.white : Colors.black54,
          ),
        ),
      ),
    );
  }
}