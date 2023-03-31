part of 'one_to_one_chat_screen.dart';

class ChatListItem extends StatefulWidget {
  const ChatListItem({
    super.key,
    required this.animation,
    required this.chatId,
  });
  final Animation<double> animation;
  final int chatId;

  @override
  State<ChatListItem> createState() => _ChatListItemState();
}

class _ChatListItemState extends State<ChatListItem>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 150), vsync: this);
    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.elasticOut,
    );
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.headlineMedium!;
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: ScaleTransition(
        alignment: Alignment.bottomRight,
        scale: widget.animation,
        child: SizeTransition(
          sizeFactor: animation,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: null,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Container(
                color: Colors.blue,
                child: Text("Hi, ki koro?"),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
