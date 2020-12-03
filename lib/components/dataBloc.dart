import 'dart:async';

import 'package:flutter_classom/model/data.dart';

class Bloc {
  final List<Menu> data = List<Menu>();

  final _dataController = StreamController<List<Menu>>.broadcast();

  get getDataStream => _dataController.stream;

  void addItem(Menu menu) {
    for (var a in data) {
      if (a.item == menu.item) {
        if (a.count != 9) a.count++;
        _dataController.sink.add(data);
        return;
      }
    }
    data.add(menu);
    _dataController.sink.add(data);
  }

  void clearItem() {
    data.clear();
    _dataController.sink.add(data);
  }

  void removeItem(index) {
    data.removeRange(index, index);
    _dataController.sink.add(data);
  }

  dispose() {
    _dataController.close();
  }
}

var bloc = Bloc();
