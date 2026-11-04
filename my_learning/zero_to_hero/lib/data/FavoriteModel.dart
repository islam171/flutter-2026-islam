import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:zero_to_hero/instance/lessons.dart';

class FavoriteModel extends ChangeNotifier{
  final List<Lesson> _items= [];

  UnmodifiableListView<Lesson> get items => UnmodifiableListView(_items);

  int get totalFavorites => _items.length;

  void toggle(Lesson item){
    if(isAdded(item)){
      _items.remove(item);
    }else {
      _items.add(item);
    }
    notifyListeners();
  }

  void removeAll(){
    _items.clear();
    notifyListeners();
  }

  bool isAdded(Lesson lesson){
    return _items.contains(lesson);
  }
}