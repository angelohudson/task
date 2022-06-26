import 'package:flutter/material.dart';
import 'package:task/app/shared/components/text_input_field.dart';

Future<List<dynamic>> imputJustificativa(BuildContext context) {
  GlobalKey<FormState> _keyValidationForm = GlobalKey<FormState>();
  TextEditingController _justificativaCon = TextEditingController();
  return showDialog<List<dynamic>>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 10.0,
        title: Text(
          'Justificativa',
          style: TextStyle(fontSize: 18.0, color: Colors.black),
        ),
        content: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: 350,
            child: Form(
              key: _keyValidationForm,
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(),
                  child: Column(
                    children: <Widget>[
                      TextInputFieldComponent(
                        _justificativaCon,
                        Icon(Icons.title),
                        'Justificativa',
                        _validateCamp,
                        TextInputType.text,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
            child: Row(
              children: [
                Text(
                  "Confirmar",
                ),
              ],
            ),
            onPressed: () {
              if (_keyValidationForm.currentState.validate()) {
                Navigator.of(context).pop([true, _justificativaCon.text]);
              }
            },
          ),
        ],
      );
    },
  );
}

String _validateCamp(String value) {
  return value.trim().isEmpty ? "Preencha o campo acima!" : null;
}
