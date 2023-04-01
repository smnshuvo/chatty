part of 'one_to_one_chat_screen.dart';

class ChatListItem extends StatefulWidget {
  const ChatListItem({
    super.key,
    required this.msg,
    required this.chatId,
    required this.isSender,
  });
  final String msg;
  final int chatId;
  final bool isSender;

  @override
  State<ChatListItem> createState() => _ChatListItemState();
}

class _ChatListItemState extends State<ChatListItem>
    with TickerProviderStateMixin {
  late Animation<double> senderScaleAnimation;
  late Animation<double> receiverScaleAnimation;
  late Animation<double> sizeAnimation;
  late AnimationController controller;
  late AnimationController sizeAnimationController;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 450), vsync: this);

    sizeAnimationController = AnimationController(
        duration: const Duration(milliseconds: 350), vsync: this);

    senderScaleAnimation = CurvedAnimation(
      parent: controller,
      curve: Curves.elasticInOut,
    );

    receiverScaleAnimation = CurvedAnimation(
      parent: controller,
      curve: Curves.elasticInOut,
    );

    sizeAnimation = CurvedAnimation(
      parent: sizeAnimationController,
      curve: Curves.fastOutSlowIn,
    );
    controller.forward();
    sizeAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: ScaleTransition(
        alignment:
            widget.isSender ? Alignment.bottomRight : Alignment.bottomLeft,
        scale: widget.isSender ? senderScaleAnimation : receiverScaleAnimation,
        child: SizeTransition(
          sizeFactor: sizeAnimation,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: null,
            child: Align(
              alignment: widget.isSender
                  ? Alignment.bottomRight
                  : Alignment.bottomLeft,
              child: BubbleSpecialThree(
                text: widget.msg,
                color: widget.isSender
                    ? Color(0xFF1B97F3)
                    : Color.fromARGB(255, 1, 153, 54),
                tail: true,
                isSender: widget.isSender,
                textStyle: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
