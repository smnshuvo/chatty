import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';
import 'color_constants.dart';
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
  late ListModel<ChatListItem> _list;
  late int _nextItem;
  final randomMsgs = [
    "hi, ki koro?",
    "ki obostha?",
    "kon deshe te jabi uira re..."
  ];
  final textController = TextEditingController();
  bool restrictSending = true;

  @override
  void initState() {
    _list = ListModel<ChatListItem>(
        listKey: _listKey, removedItemBuilder: _buildRemoveItem);
    _nextItem = _list.length;
    textController.addListener(_onTextChange);
    super.initState();
  }

  void _addChatItem(String msg) {
    print("Inserted at $_nextItem");
    _list.insert(
      _nextItem++,
      ChatListItem(msg: msg, chatId: _nextItem, isSender: _nextItem % 2 == 0),
    );
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
          IconButton(onPressed: _removeLastChatItem, icon: Icon(Icons.remove))
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: Align(
                  alignment: AlignmentDirectional.bottomEnd,
                  child: _createChatHistoryView())),
          _createChatInputView(),
        ],
      ),
    );
  }

  Widget _buildItem(
    BuildContext context,
    int index,
    Animation<double> animation,
  ) {
    return ChatListItem(
      chatId: _list[index].chatId,
      msg: _list[index].msg,
      isSender: index % 2 == 0,
    );
  }

  Widget _buildRemoveItem(
    BuildContext context,
    ChatListItem chatListItem,
    Animation<double> animation,
  ) {
    return chatListItem;
  }

  Widget _createChatHistoryView() => Padding(
        padding: const EdgeInsets.all(16.0),
        child: AnimatedList(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          key: _listKey,
          initialItemCount: _list.length,
          itemBuilder: _buildItem,
        ),
      );

  Widget _createChatInputView() => Row(
        children: [
          Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: textController,
                ),
              )),
          Expanded(
            flex: 1,
            child: IconButton(
                onPressed: _sendMessage,
                icon: Icon(
                  Icons.send,
                  color: restrictSending
                      ? ColorConstants.disabledColor
                      : ColorConstants.senderBubbleColor,
                )),
          )
        ],
      );

  void _sendMessage() async {
    _addChatItem(textController.value.text);
    textController.text = '';
  }

  void _onTextChange() {
    if (textController.value.text.isEmpty) {
      setState(() {
        restrictSending = true;
      });
    } else {
      // may  be I am saving some setState  call here with a costly if -_-r
      if (restrictSending != false) {
        setState(() {
          restrictSending = false;
        });
      }
    }
  }
}
