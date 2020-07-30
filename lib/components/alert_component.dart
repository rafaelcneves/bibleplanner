import 'package:flutter/material.dart';

class AlertComponent extends StatelessWidget {
  final Text title;
  final Text content;
  final Function confirm;
  final Function cancel;

  const AlertComponent(
      {Key key, this.title, this.content, this.confirm, this.cancel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title,
      content: content,
      actions: [
        FlatButton(
          child: Text('Cancelar'),
          onPressed: () {
            if (cancel != null) cancel();
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text('Confirmar'),
          onPressed: () {
            if (confirm != null) confirm();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
