import 'package:flutter/material.dart';
import 'package:flutter_app/commons/reusable_text_field.dart';
import 'package:flutter_app/commons/reusable_button.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'login_screen.dart';
import 'package:flutter_app/controller/auth_controller.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    TextEditingController password = TextEditingController();
    TextEditingController email = TextEditingController();
     AuthController authController = AuthController();
   bool isLoading = false;
  registerUser() async {
    setState(() {
      isLoading = true;
    });
    bool result = await authController.register(email.text, password.text);
    setState(() {
      isLoading = false;
    });
    if (result) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("User registered succesfull")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("User registered not succesfull")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            color: Color(0xffC29E86),
          ),
        child: SingleChildScrollView(
        
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child: Text(
                    "Register",
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
                        validator: RequiredValidator(errorText: "Required*"),
                        label: "Username",
                      ),
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
                              min: 8,
                              max: 15,
                              errorText: "Password length should be 8-10"),
                        ]),
                        label: "Password",
                      ),
                      ReusableTextField(
                        obscure: true,
                        validator: (val) {
                          if (val != password.text) {
                            return ("password don't match");
                          } else {
                            return null;
                          }
                        },
                        label: "Confirm Password",
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 18, bottom: 18),
                        child: SizedBox(
                          width: 100,
                          height: 40,
                          child:  isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      :ReusableButton(
                            buttonText: 'Signup',
                            onPressed: () {
                              if (formKey.currentState!.validate() == true ){
                              registerUser();
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
                                      builder: (context) => LoginScreen()));
                            },
                            child: new Text("Login",
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
