import 'package:flutter/material.dart';

bool validarMatricula(String matricula) {
  final matriculaReg = RegExp(r'^\d{2}\-\d{2}\-\d{4}$');
  return matriculaReg.hasMatch(matricula);
}

void mostrarSnackBar(BuildContext context, String texto) {
  final snackBar = SnackBar(
    content: Text(texto),
    duration: const Duration(seconds: 2),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

validateEmail(String email) {
  final emailReg = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
  return emailReg.hasMatch(email);
}
