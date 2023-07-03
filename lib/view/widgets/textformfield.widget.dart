import 'package:flutter/material.dart';
import 'package:lista_asistencia_actualizado/view/common/com_helper.dart';

class TextFormFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String hintName;
  final IconData icon;
  final bool isObscureText;
  final TextInputType inputType;
  final TextInputAction action;
  final bool soloLeer;

  const TextFormFieldWidget(
      {required this.controller,
      required this.hintName,
      required this.icon,
      required this.action,
      this.inputType = TextInputType.text,
      this.isObscureText = false,
      this.soloLeer = false,
      super.key});

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  String? _activeField = '';
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        readOnly: widget.soloLeer,
        textInputAction: widget.action,
        focusNode: _focusNode,
        controller: widget.controller,
        obscureText: widget.isObscureText,
        keyboardType: widget.inputType,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'No deje el campo vacio';
          } else if (widget.hintName == 'Matricula' &&
              !validarMatricula(value)) {
            return 'Ingrese Matricula correctamente (00-00-0000)';
          } else if (widget.hintName == 'Correo' && !validateEmail(value)) {
            return 'Ingrese un email valido';
          }
          return null;
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(15.0)),
            borderSide: BorderSide(
              color: _activeField == widget.hintName && _isFocused
                  ? const Color(0Xff4caf50)
                  : const Color(0xffF69100),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(15.0)),
            borderSide: BorderSide(
              color: _activeField == widget.hintName && _isFocused
                  ? const Color(0Xff4caf50)
                  : const Color(0xffF69100),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            borderSide: BorderSide(
              color: Color(0Xff4caf50),
            ),
          ),
          prefixIcon: Icon(widget.icon,
              color: _activeField == widget.hintName && _isFocused
                  ? const Color(0Xff4caf50)
                  : Colors.grey),
          hintStyle: const TextStyle(color: Color(0xff757575)),
          labelText: widget.hintName,
          floatingLabelStyle: const TextStyle(
            color: Color(0xff4caf50),
          ),
          fillColor: Colors.white,
          filled: true,
        ),
        onTap: () {
          _focusNode.requestFocus();
          setState(() {
            _activeField = widget.hintName;
          });
        },
        onFieldSubmitted: (value) {
          FocusScope.of(context).nextFocus();
          setState(() {
            _activeField = widget.hintName;
            _isFocused = false;
          });
        },
        onEditingComplete: () {
          FocusScope.of(context).requestFocus(_focusNode);
          setState(() {
            _isFocused = false;
          });
        },
        onTapOutside: (value) {
          FocusScope.of(context).unfocus();
          setState(() {
            _isFocused = false;
            _activeField = null;
          });
        },
      ),
    );
  }
}
