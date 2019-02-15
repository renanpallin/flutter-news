import 'package:flutter/material.dart';

class NewsDetail extends StatelessWidget {
  final int itemId;

  NewsDetail({this.itemId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// Só de colocar o AppBar,
      /// temos a setinha de voltar já
      /// pois ele detecta que uma navegação
      /// foi feita.
      appBar: AppBar(
        title: Text('News Detail'),
      ),
      body: Text('$itemId'),
    );
  }
}
