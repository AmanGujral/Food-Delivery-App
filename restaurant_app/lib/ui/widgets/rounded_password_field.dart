import 'package:flutter/material.dart';
import 'package:restaurant_app/colors.dart';
import 'package:restaurant_app/ui/screens/signup/components/text_field_container.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const RoundedPasswordField({
    Key key,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: true,
        onChanged: onChanged,
        cursorColor: CustomColors().primaryLight,
        decoration: InputDecoration(
          hintText: "Password",
          icon: Icon(
            Icons.lock,
            color: CustomColors().primary,
          ),
          suffixIcon: Icon(
            Icons.visibility,
            color: CustomColors().primary,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}