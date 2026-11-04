import 'package:flutter/foundation.dart';
import 'package:shop/models/book.dart';

class Cart extends ChangeNotifier {
  final Map<Book, int> _qty = {};

  List<Book> get items => _qty.keys.toList();

  int get count => _qty.length;

  int get total => _qty.entries.fold(0, (sum, entry){
    return sum + entry.value * entry.key.price;
  });

  int qtyOf(Book b){
    if (_qty.containsKey(b)) {
      return _qty[b]!;
    }
    return 0;
  }

  void increment(Book b){
    if (_qty.containsKey(b)) {
      _qty[b] = 1 + _qty[b]!;
      notifyListeners();
    }
  }

  bool add(Book b) {
    if (_qty.containsKey(b)) {
      return false;
    }
    _qty[b] = 1;
    notifyListeners();
    return true;
  }

  void remove(Book b){
    _qty.remove(b);
    notifyListeners();
  }

  void clear(){
    _qty.clear();
    notifyListeners();
  }
}
