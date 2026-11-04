import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zero_to_hero/data/FavoriteModel.dart';

import '../data/constant.dart';
import '../instance/lessons.dart';
import '../view/pages/home_page.dart';

class ContainerWidget extends StatelessWidget {
  const ContainerWidget({super.key, required this.item});

  final Lesson item;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.title, style: KTextStyle.title),
                  Text(item.desc, style: KTextStyle.descriptionText),
                ],
              ),
              Consumer<FavoriteModel>(
                builder: (context, value, child) => IconButton(
                  onPressed: () {
                    value.toggle(item);
                  },
                  icon: Icon(value.isAdded(item) ? Icons.favorite : Icons.favorite_outline),
                  style: IconButton.styleFrom(foregroundColor: Colors.teal),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
