/// # `flutter_chatbook` - Rapidly Create Flutter Chat Apps

/// flutter_chatbook is a powerful Flutter package designed to accelerate the development of chat applications. With flutter_chatbook, you can create feature-rich chat apps in minutes, enabling seamless communication and collaboration between users.

//test
/// ## Key Features

/// - **Plugin System**: flutter_chatbook provides a flexible plugin system that allows you to extend the functionality of your chat app. Easily integrate plugins for additional features such as file sharing, voice messaging, or chatbots.
/// - **Plugin Marketplace**: Discover and utilize a wide range of pre-built plugins from the flutter_chatbook Plugin Marketplace. Quickly enhance your chat app by integrating popular and customizable plugins from a centralized repository.
/// - **Real-Time UI Updates**: Ensure real-time updates in the user interface to deliver a dynamic chat experience. Users can see new messages, typing indicators, and other relevant updates in real-time without the need for manual refreshing.
/// - **User Authentication**: Implement user authentication functionality, allowing users to register, log in, and manage their profiles securely.
/// - **Group Chats**: Enable users to participate in group conversations, fostering collaboration and interaction among multiple participants.
/// - **Message Formatting**: Provide users with rich text formatting options, including text styling, emojis, attachments, and more, to enhance their messaging experience.
/// - **Customization**: Customize the look and feel of your chat app with ease. Modify themes, color schemes, fonts, and other visual elements to match your branding and design preferences.

library flutter_chatbook;

import 'dart:async';
import 'dart:io' if (kIsWeb) 'dart:html';
import 'dart:math';
import 'dart:ui';

import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_parsed_text/flutter_parsed_text.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:swipeable_tile/swipeable_tile.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';
import 'package:vibration/vibration.dart';

import 'flutter_chatbook.dart';
import 'src/extensions/extensions.dart';
import 'src/models/cupertino_widget_configuration.dart';
import 'src/utils/constants/constants.dart';
import 'src/utils/package_strings.dart';
import 'src/wrappers/material_conditional_wrapper.dart';

export 'package:message_models/message_models.dart';

export 'src/extensions/extension_apis/chat_book_extension.dart';
export 'src/extensions/extension_apis/service/service_export.dart';
export 'src/extensions/extension_apis/widgets extension/widget_extension.dart';
export 'src/extensions/extensions.dart' show MessageTypes;
export 'src/models/models.dart';
export 'src/models/on_tap_more_actions.dart';
export 'src/models/text_message_parser.dart';
export 'src/utils/debounce.dart';
export 'src/values/enumaration.dart';
export 'src/values/typedefs.dart';
export 'src/wrappers/condition_wrapper.dart';

part './src/controller/chat_controller.dart';
part './src/widgets/chat_bubble_widget.dart';
part './src/widgets/chat_group_header.dart';
part './src/widgets/chat_groupedlist_widget.dart';
part './src/widgets/chat_list_widget.dart';
part './src/widgets/reusables/message_actions_bottomsheet.dart';
part 'src/widgets/chat_book.dart';
part 'src/widgets/chat_book_inherited_widget.dart';
part 'src/widgets/chatbook_appbar.dart';
part 'src/widgets/chatbook_state_widget.dart';
part 'src/widgets/chatui_textfield.dart';
part 'src/widgets/default_reaction_popup_widget.dart';
part 'src/widgets/emoji_picker_widget.dart';
part 'src/widgets/emoji_row.dart';
part 'src/widgets/glassmorphism_reaction_popup.dart';
part 'src/widgets/link_preview.dart';
part 'src/widgets/message_view.dart';
part 'src/widgets/on_tap_more_action_sheet.dart';
part 'src/widgets/payment_message_view.dart';
part 'src/widgets/profile_circle.dart';
part 'src/widgets/reply_icon.dart';
part 'src/widgets/reply_message_widget.dart';
part 'src/widgets/reply_popup_widget.dart';
part 'src/widgets/reusables/action_icon.dart';
part 'src/widgets/reusables/gesture_detector_view.dart';
part 'src/widgets/reusables/message_time_widget.dart';
part 'src/widgets/send_message_widget.dart';
part 'src/widgets/share_icon.dart';
part 'src/widgets/swipe_to_reply.dart';
part 'src/widgets/text_message_view.dart';
part 'src/widgets/type_indicator_widget.dart';
part 'src/widgets/vertical_line.dart';

void replaceOrInsert(Message item, int idx, List<Message> msgList) {
  final index = msgList.indexWhere((element) => element.id == item.id);
  if (index != -1) {
    msgList[index] = item;
  } else {
    msgList.insert(idx, item);
  }
}

void replace(Message item, List<Message> msgList) {
  final index = msgList.indexWhere((element) => element.id == item.id);
  if (index != -1) {
    msgList[index] = item;
  }
}

String getMsgId() {
  return Uuid().v4();
}
