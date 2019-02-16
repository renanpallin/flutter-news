import 'dart:async';
import 'package:flutter/material.dart';
import '../models/item_model.dart';
/// Existe uma versão basic dessa lib
import 'package:html_unescape/html_unescape.dart';
import 'loading_container.dart';

class Comment extends StatelessWidget {
  final int itemId;
  final Map<int, Future<ItemModel>> itemMap;
  final int depth;

  Comment({this.itemId, this.itemMap, this.depth = 0});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: itemMap[itemId],
      builder: (context, AsyncSnapshot<ItemModel> snapshot) {
        if (!snapshot.hasData) {
          return LoadingContainer();
        }

        final item = snapshot.data;

        return Column(
          children: <Widget>[
            ListTile(
              title: buildText(item),
              subtitle: item.by == '' ? Text('Deleted') : Text(item.by),
              contentPadding: EdgeInsets.only(
                right: 16.0,
                left: (depth + 1) * 16.0,
              ),
            ),
            Divider(),
          ]..addAll(item.kids.map((kidId) {
              return Comment(
                itemId: kidId,
                itemMap: itemMap,
                depth: depth + 1,
              );
            })),
        );
      },
    );
  }

  buildText(ItemModel item) {
    final text = HtmlUnescape().convert(item.text);
    return Text(text);
  }
}
