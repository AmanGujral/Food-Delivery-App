import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:client_app/screens/phoneLogin/phone_login_screen.dart';

import '../../../auth.dart';
import '../../../components/bottom_nav_bar.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import '../../../components/buttons/primary_button.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  TextEditingController _controllerEmail =
      TextEditingController(text: "lppapineau@gmail.com");
  TextEditingController _controllerPassword =
      TextEditingController(text: "112233");

  Future<void> createUserWithEmailAndPassword() async {
    try {
      print(_controllerEmail.text);
      await Auth()
          .createUserWithEmailAndPassword(
              email: _controllerEmail.text, password: _controllerPassword.text)
          .then((value) => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BottomNavBar(),
          )))
          .catchError((Object error) => print(error.toString()));
    } on FirebaseAuthException catch (e) {
      setState(() {
        // errorMessage = e.message;
      });
    } catch (e) {
      print(e);
    }
  }

  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  bool _obscureText = true;

  FocusNode _emaildNode;
  FocusNode _passwordNode;
  FocusNode _conformPasswordNode;

  String _fullName, _email, _password, _conformPassword;

  @override
  void initState() {
    super.initState();
    _passwordNode = FocusNode();
    _emaildNode = FocusNode();
    _conformPasswordNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    _passwordNode.dispose();
    _emaildNode.dispose();
    _conformPasswordNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Full Name Field
//          TextFormField(
//            autovalidate: _autoValidate,
//            validator: requiredValidator,
//            onSaved: (value) => _fullName = value,
//            textInputAction: TextInputAction.next,
//            onEditingComplete: () {
//              // Once user click on Next then it go to email field
//              _emaildNode.requestFocus();
//            },
//            style: kSecondaryBodyTextStyle,
//            cursorColor: kActiveColor,
//            decoration: InputDecoration(
//              hintText: "Full Name",
//              contentPadding: kTextFieldPadding,
//            ),
//          ),
          //VerticalSpacing(),

          // Email Field
          TextFormField(
            controller: _controllerEmail,
            focusNode: _emaildNode,
            autovalidate: _autoValidate,
            validator: emailValidator,
            onSaved: (value) => _email = value,
            textInputAction: TextInputAction.next,
            onEditingComplete: () {
              // Once user click on Next then it go to password field
              _passwordNode.requestFocus();
            },
            style: kSecondaryBodyTextStyle,
            cursorColor: kActiveColor,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: "Email Address",
              contentPadding: kTextFieldPadding,
            ),
          ),
          VerticalSpacing(),

          // Password Field
          TextFormField(
            controller: _controllerPassword,
            focusNode: _passwordNode,
            obscureText: _obscureText,
            autovalidate: _autoValidate,
            validator: passwordValidator,
            textInputAction: TextInputAction.next,
            onEditingComplete: () => _conformPasswordNode.requestFocus(),
            // We need to validate our password
            onChanged: (value) => _password = value,
            onSaved: (value) => _password = value,
            style: kSecondaryBodyTextStyle,
            cursorColor: kActiveColor,
            decoration: InputDecoration(
              hintText: "Password",
              contentPadding: kTextFieldPadding,
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                child: _obscureText
                    ? const Icon(Icons.visibility_off, color: kBodyTextColor)
                    : const Icon(Icons.visibility, color: kBodyTextColor),
              ),
            ),
          ),
          VerticalSpacing(),

          // Confirm Password Field
//          TextFormField(
//            focusNode: _conformPasswordNode,
//            obscureText: _obscureText,
//            autovalidate: _autoValidate,
//            validator: (value) =>
//                matchValidator.validateMatch(value, _password),
//            onSaved: (value) => _conformPassword = value,
//            style: kSecondaryBodyTextStyle,
//            cursorColor: kActiveColor,
//            decoration: InputDecoration(
//              hintText: "Confirm Password",
//              contentPadding: kTextFieldPadding,
//              suffixIcon: GestureDetector(
//                onTap: () {
//                  setState(() {
//                    _obscureText = !_obscureText;
//                  });
//                },
//                child: _obscureText
//                    ? const Icon(Icons.visibility_off, color: kBodyTextColor)
//                    : const Icon(Icons.visibility, color: kBodyTextColor),
//              ),
//            ),
//          ),
//          VerticalSpacing(),
          // Sign Up Button
          PrimaryButton(text: "Sign Up", press: createUserWithEmailAndPassword
//                () {
//              if (_formKey.currentState.validate()) {
//                // If all data are correct then save data to out variables
//                _formKey.currentState.save();
//                Navigator.push(
//                  context,
//                  MaterialPageRoute(
//                    builder: (context) => PghoneLoginScreen(),
//                  ),
//                );
//              } else {
//                // If all data are not valid then start auto validation.
//                setState(() {
//                  _autoValidate = true;
//                });
//              }
//            },
              ),
        ],
      ),
    );
  }
}
