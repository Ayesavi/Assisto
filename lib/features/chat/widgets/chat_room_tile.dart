import 'package:assisto/models/chat_room_model/chat_room_model.dart';
import 'package:assisto/widgets/task_tile/tile_status.dart';
import 'package:flutter/material.dart';

class ChatRoomTile extends StatelessWidget {
  final ChatRoomModel chatRoom;
  final VoidCallback? onPressed;
  const ChatRoomTile({super.key, required this.chatRoom, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(chatRoom.author.avatarUrl),
        radius: 30,
      ),
      title: Text(
        chatRoom.task.name,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16.0,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            chatRoom.author.name,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14.0,
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            chatRoom.message.text,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14.0,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
      trailing: TileStatusWidget(chatRoom.task.status),
      onTap: onPressed,
    );
  }
}
