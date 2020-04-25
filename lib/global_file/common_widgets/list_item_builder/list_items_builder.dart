
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tellthetruth/global_file/common_variables/app_functions.dart';
import 'empty_content.dart';
import 'empty_feed_content.dart';

typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T item);

class ListItemsBuilder<T> extends StatelessWidget {
  ListItemsBuilder(
      {Key key, @required this.snapshot, @required this.itemBuilder, @required this.emptyContent })
      : super(key: key);

  final AsyncSnapshot<List<T>> snapshot;
  final ItemWidgetBuilder<T> itemBuilder;
  final Widget emptyContent;

  @override
  Widget build(BuildContext context) {
    if (snapshot.hasData) {
      final List<T> items = snapshot.data;
      if (items.isNotEmpty) {
        return _buildList(items);
      } else {
        return emptyContent;
      }
    } else if (snapshot.hasError) {
      print('error => ${snapshot.error}');
      return EmptyContent(
        title: 'Something went wrong',
        message: 'Can\'t load items right now.',
      );
    }
    return Center(child:
        Lottie.network("https://assets2.lottiefiles.com/packages/lf20_2l2iQr.json",height: getDynamicHeight(300),width: SCREEN_SIZE.width),
    );
  }

  Widget _buildList(List<T> items) {
    return ListView.separated(
      separatorBuilder: (contain, index) => Divider(height: 1.5),
      itemCount: items.length + 2,
      itemBuilder: (context, index) {
        if (index == 0 || index == items.length + 1) {
          return Container();
        }
        return itemBuilder(context, items[index - 1]);
      },
    );
  }
}