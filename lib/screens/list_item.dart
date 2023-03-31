import 'package:flutter/material.dart';

typedef RemovedItemBuilder<T> = Widget Function(
    BuildContext context, T item, Animation<double> animation);

class ListModel<E> {
  ListModel({
    required this.listKey,
    required this.removedItemBuilder,
    Iterable<E>? initialItems,
  }) : _items = List<E>.from(initialItems ?? <E>[]);

  final GlobalKey<AnimatedListState> listKey;
  final RemovedItemBuilder<E> removedItemBuilder;
  final List<E> _items;

  AnimatedListState? get _animatedList => listKey.currentState;

  void insert(int index, E item) {
    _items.insert(index, item);
    _animatedList!.insertItem(index);
  }

  E removeAt(int index) {
    final E removedItem = _items.removeAt(index);
    if (removedItem != null) {
      _animatedList!.removeItem(
        index,
        (BuildContext context, Animation<double> animation) {
          return removedItemBuilder(context, removedItem, animation);
        },
      );
    }
    return removedItem;
  }

  void removeLastItem() {
    if (length < 1) return;
    final E removedItem = _items.last;
    print("Array size is $_items");
    _animatedList?.removeItem(
        length - 1,
        (context, animation) =>
            removedItemBuilder(context, removedItem, animation));

// TODO: Need to figure out why I am having to remove the item in an interval, currently focusing on something else
    Future.delayed(Duration(milliseconds: 400), () {
      _items.removeLast();
    });
  }

  int get length => _items.length;

  E operator [](int index) => _items[index];

  int indexOf(E item) => _items.indexOf(item);
}
