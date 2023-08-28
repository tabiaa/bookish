import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter_app/commons/reusable_text_field.dart';
import 'package:flutter_app/commons/reusable_button.dart';
import 'books_screen.dart';
import 'register_screen.dart';
import 'package:flutter_app/controller/auth_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  AuthController authController = AuthController();
  bool isLoading = false;
  loginUser() async {
    setState(() {
      isLoading = true;
    });
    bool result = await authController.login(email.text, password.text);
    setState(() {
      isLoading = false;
    });
    if (result) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => BooksScreen()));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Invalid credentials")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffC29E86),
      body: Container(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child: Text(
                    "Login",
                    style: TextStyle(
                        letterSpacing: 8,
                        wordSpacing: 0,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Color(0xff795C4B)),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(60),
                  child: Column(
                    children: [
                      ReusableTextField(
                        controller: email,
                        validator: MultiValidator([
                          RequiredValidator(errorText: 'Required*'),
                          EmailValidator(errorText: "Enter a valid email*")
                        ]),
                        label: "Email",
                      ),
                      ReusableTextField(
                        controller: password,
                        obscure: true,
                        validator: MultiValidator([
                          RequiredValidator(errorText: 'Required*'),
                          LengthRangeValidator(
                              min: 5,
                              max: 15,
                              errorText: "Password length should be 8-10"),
                        ]),
                        label: "Password",
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 18, bottom: 18),
                        child: SizedBox(
                          child: isLoading
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : ReusableButton(
                                  buttonText: 'Login',
                                  onPressed: () {
                                    if (formKey.currentState!.validate() ==
                                        true) {
                                      loginUser();
                                    }
                                  },
                                  bgColor: Color(0xff795C4B),
                                  txtColor: Color(0xffC29E86),
                                ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              "Don't have an account?",
                              style: TextStyle(
                                  fontSize: 12,
                                  letterSpacing: 2,
                                  color: Color(0xff795C4B)),
                            ),
                          ),
                          new GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterScreen()));
                            },
                            child: new Text(" Register",
                                style: TextStyle(
                                    letterSpacing: 4,
                                    wordSpacing: 0,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Color(0xff795C4B))),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
