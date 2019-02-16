import 'dart:async';
import 'package:flutter/material.dart';
import '../models/item_model.dart';

class Comment extends StatelessWidget {
  final int itemId;
  final Map<int, Future<ItemModel>> itemMap;

  Comment({this.itemId, this.itemMap});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: itemMap[itemId],
      builder: (context, AsyncSnapshot<ItemModel> snapshot) {
        if (!snapshot.hasData) {
          return Text('loading...');
        }

        final item = snapshot.data;

        return Column(
          children: <Widget>[
            ListTile(
              title: item.text == '' ? Text('Deleted') : Text(item.text),
              subtitle: item.by == '' ? Text('Deleted') : Text(item.by),
            ),
            Divider(),
          ]..addAll(item.kids.map((kidId) {
              return Comment(
                itemId: kidId,
                itemMap: itemMap,
              );
            })),
        );
      },
    );
  }
}
