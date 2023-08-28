import 'package:flutter/material.dart';

class ReusableTextField extends StatelessWidget {
  final String label;
  final String? Function(String?)? validator;
  final bool obscure;
  final TextEditingController? controller;
  const ReusableTextField(
      {super.key,
      required this.label,
      required this.validator,
      this.obscure = false,
      this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("${label}",
              style: TextStyle(
                  letterSpacing: 8,
                  wordSpacing: 0,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: Color(0xff795C4B))),
          TextFormField(
            validator: validator,
            decoration: InputDecoration(),
            obscureText: obscure,
            controller: controller,
          ),
          SizedBox(height: 24),
          
        ],
      ),
    );
  }
}
