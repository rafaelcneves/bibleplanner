import 'package:flutter/material.dart';

class AlertComponent extends StatelessWidget {
  final Text title;
  final Text content;
  final Function confirm;
  final Function? cancel;

  const AlertComponent(
      {required this.title,
      required this.content,
      required this.confirm,
      this.cancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title,
      content: content,
      actions: [
        FlatButton(
          child: Text('Cancelar'),
          onPressed: () {
            if (cancel != null) cancel!();
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text('Confirmar'),
          onPressed: () {
            confirm();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
