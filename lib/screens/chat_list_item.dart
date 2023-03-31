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
  late Animation<double> scaleAnimation;
  late Animation<double> sizeAnimation;
  late AnimationController controller;
  late AnimationController sizeANimationController;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 450), vsync: this);

    sizeANimationController = AnimationController(
        duration: const Duration(milliseconds: 350), vsync: this);

    scaleAnimation = CurvedAnimation(
      parent: controller,
      curve: Curves.elasticInOut,
    );
    sizeAnimation = CurvedAnimation(
      parent: sizeANimationController,
      curve: Curves.fastOutSlowIn,
    );
    controller.forward();
    sizeANimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.headlineMedium!;
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: ScaleTransition(
        alignment: Alignment.bottomRight,
        scale: scaleAnimation,
        child: SizeTransition(
          sizeFactor: sizeAnimation,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: null,
            child: Align(
              alignment: Alignment.bottomRight,
              child: BubbleSpecialThree(
                text: 'Hey, ki koro?',
                color: Color(0xFF1B97F3),
                tail: true,
                textStyle: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
