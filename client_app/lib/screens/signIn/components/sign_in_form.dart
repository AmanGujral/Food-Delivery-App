import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:client_app/components/bottom_nav_bar.dart';
import 'package:client_app/screens/findRestaurants/find_restaurants_screen.dart';

import '../../../auth.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import '../../../components/buttons/primary_button.dart';
import '../../../screens/forgotPassword/forgot_password_screen.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({
    Key key,
  }) : super(key: key);

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  TextEditingController _controllerEmail =
      TextEditingController(text: "lppapineau@gmail.com");
  TextEditingController _controllerPassword =
      TextEditingController(text: "112233");

  Future<void> signInWithEmailAndPassword() async {
    try {
      print(_controllerEmail.text);
      await Auth()
          .signInWithEmailAndPassword(
              email: _controllerEmail.text, password: _controllerPassword.text)
          .then((value) => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BottomNavBar(),
              )))
          .catchError((Object error) => print(error.toString()));
    } on FirebaseAuthException catch (e) {
      setState(() {
        //errorMessage = e.message;
      });
    }
  }

  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  bool _obscureText = true;

  FocusNode _passwordNode;

  @override
  void initState() {
    super.initState();
    _passwordNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    _passwordNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String _email, _password;
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Email Field
          TextFormField(
            controller: _controllerEmail,
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

          // Forget Password
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ForgotPasswordScreen(),
              ),
            ),
            child: Text(
              "Forget Password?",
              style: Theme.of(context)
                  .textTheme
                  .caption
                  .copyWith(fontWeight: FontWeight.w500),
            ),
          ),
          VerticalSpacing(),

          // Sign In Button
          PrimaryButton(text: "Sign In", press: signInWithEmailAndPassword
//                () {
//              if (_formKey.currentState.validate()) {
//                // If all data are correct then save data to out variables
//                _formKey.currentState.save();
//
//                // just for demo
//                Navigator.push(
//                    context,
//                    MaterialPageRoute(
//                      builder: (context) => BottomNavBar(),
//                    ));
//              } else {
//                // If all data are not valid then start auto validation.
//                setState(() {
//                  _autoValidate = true;
//                });
//              }
//            },
              )
        ],
      ),
    );
  }
}
