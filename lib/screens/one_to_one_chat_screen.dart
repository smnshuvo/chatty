import 'package:flutter/material.dart';
import 'list_item.dart';

part 'chat_list_item.dart';

class OneToOneChatScreen extends StatefulWidget {
  const OneToOneChatScreen({super.key});

  @override
  State<OneToOneChatScreen> createState() => _OneToOneChatScreenState();
}

class _OneToOneChatScreenState extends State<OneToOneChatScreen> {
  final TITLE = "Demo Chat Screen";
  final _listKey = GlobalKey<AnimatedListState>();
  late ListModel<int> _list;
  late int _nextItem;

  @override
  void initState() {
    _list =
        ListModel<int>(listKey: _listKey, removedItemBuilder: _buildRemoveItem);
    _nextItem = _list.length;
    super.initState();
  }

  void _addChatItem() {
    print("Inserted at $_nextItem");
    _list.insert(_nextItem, _nextItem++);
  }

  void _removeLastChatItem() async {
    _list.removeLastItem();
    _nextItem--;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(TITLE),
        actions: [
          IconButton(onPressed: _addChatItem, icon: Icon(Icons.add)),
          IconButton(onPressed: _removeLastChatItem, icon: Icon(Icons.remove))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: AnimatedList(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          key: _listKey,
          initialItemCount: _list.length,
          itemBuilder: _buildItem,
        ),
      ),
    );
  }

  Widget _buildItem(
    BuildContext context,
    int index,
    Animation<double> animation,
  ) {
    return ChatListItem(animation: animation, chatId: _list[index]);
  }

  Widget _buildRemoveItem(
    BuildContext context,
    int index,
    Animation<double> animation,
  ) {
    return ChatListItem(animation: animation, chatId: _list[index]);
  }
}
