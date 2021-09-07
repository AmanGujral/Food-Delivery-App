import 'package:flutter/material.dart';
import 'package:restaurant_app/colors.dart';
import 'package:restaurant_app/ui/screens/signup/components/text_field_container.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const RoundedInputField({
    Key key,
    this.hintText,
    this.icon = Icons.person,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onChanged: onChanged,
        cursorColor: CustomColors().primary,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: CustomColors().primary,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}