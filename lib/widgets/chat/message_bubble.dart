import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final String userName;
  final String userImage;
  final bool isMe;

  const MessageBubble({
    required this.userName,
    required this.message,
    required this.userImage,
    required this.isMe,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.start : MainAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: isMe
                      ? Theme.of(context).primaryColor.withOpacity(0.5)
                      : Colors.grey,
                  borderRadius: BorderRadius.only(
                    topRight: const Radius.circular(12),
                    topLeft: const Radius.circular(12),
                    bottomRight: !isMe
                        ? const Radius.circular(0)
                        : const Radius.circular(12),
                    bottomLeft: isMe
                        ? const Radius.circular(0)
                        : const Radius.circular(12),
                  )),
              width: 140,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              child: Column(
                children: [
                  Text(userName),
                  Text(
                    message,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          left: isMe ? 130 : null,
          right: isMe? null:130,
          top: 0,
          child: CircleAvatar(
            backgroundColor: Colors.grey,
            backgroundImage: NetworkImage(userImage),
          ),
        ),
      ],
    );
  }
}
