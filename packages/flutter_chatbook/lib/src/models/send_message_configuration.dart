import 'package:flutter_chatbook/src/values/enumaration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SendMessageConfiguration {
  /// Used to give background color to text field.
  final Color? textFieldBackgroundColor;

  /// Used to give color to send button.
  final Color? defaultSendButtonColor;

  /// Provides ability to give custom send button.
  final Widget? sendButtonIcon;

  final Widget? emojiPickerIcon;

  /// Used to give reply dialog color.
  final Color? replyDialogColor;

  final Color? emojiPickerColor;

  /// Used to give color to title of reply pop-up.
  final Color? replyTitleColor;

  /// Used to give color to reply message.
  final Color? replyMessageColor;

  /// Used to give color to close icon in reply pop-up.
  final Color? closeIconColor;

  /// Provides configuration of image picker functionality.
  final ImagePickerIconsConfiguration? imagePickerIconsConfig;

  /// Provides configuration of text field.
  final TextFieldConfiguration? textFieldConfig;

  /// Enable/disable voice recording. Enabled by default.
  final bool allowRecordingVoice;

  /// Color of mic icon when replying to some voice message.
  final Color? micIconColor;

  /// Styling configuration for recorder widget.
  final VoiceRecordingConfiguration? voiceRecordingConfiguration;

  /// Allow user to pick emojis or not
  final bool enableEmojiPicker;

  const SendMessageConfiguration(
      {this.textFieldConfig,
      this.textFieldBackgroundColor,
      this.imagePickerIconsConfig,
      this.defaultSendButtonColor,
      this.sendButtonIcon,
      this.replyDialogColor,
      this.replyTitleColor,
      this.replyMessageColor,
      this.closeIconColor,
      this.allowRecordingVoice = true,
      this.voiceRecordingConfiguration,
      this.micIconColor,
      this.emojiPickerIcon,
      this.emojiPickerColor,
      this.enableEmojiPicker = true});
}

class ImagePickerIconsConfiguration {
  /// Provides ability to pass custom gallery image picker icon.
  final Widget? galleryImagePickerIcon;

  /// Provides ability to pass custom camera image picker icon.
  final Widget? cameraImagePickerIcon;

  /// Used to give color to camera icon.
  final Color? cameraIconColor;

  /// Used to give color to gallery icon.
  final Color? galleryIconColor;

  final Widget? attachMentPickerIcon;

  final Color? attachMentIconColor;

  const ImagePickerIconsConfiguration(
      {this.cameraIconColor,
      this.galleryIconColor,
      this.galleryImagePickerIcon,
      this.cameraImagePickerIcon,
      this.attachMentIconColor,
      this.attachMentPickerIcon});
}

class TextFieldConfiguration {
  /// Used to give max lines in text field.
  final int? maxLines;

  /// Used to give min lines in text field.
  final int? minLines;

  /// Used to give padding in text field.
  final EdgeInsetsGeometry? padding;

  /// Used to give margin in text field.
  final EdgeInsetsGeometry? margin;

  /// Used to give hint text in text field.
  final String? hintText;

  /// Used to give text style of hint text in text field.
  final TextStyle? hintStyle;

  /// Used to give text style of actual text in text field.
  final TextStyle? textStyle;

  /// Used to give border radius in text field.
  final BorderRadius? borderRadius;

  /// Used to give content padding in text field.
  final EdgeInsetsGeometry? contentPadding;

  /// Used to give text input type of text field.
  final TextInputType? textInputType;

  /// Used to give list of input formatters for text field.
  final List<TextInputFormatter>? inputFormatters;

  /// Used to give textCapitalization enums to text field.
  final TextCapitalization? textCapitalization;

  /// Callback when a user starts/stops typing a message by [TypeWriterStatus]
  final void Function(TypeWriterStatus status)? onMessageTyping;

  /// After typing stopped, the threshold time after which the composing
  /// status to be changed to [TypeWriterStatus.composed].
  /// Default is 1 second.
  final Duration compositionThresholdTime;

  const TextFieldConfiguration({
    this.contentPadding,
    this.maxLines,
    this.borderRadius,
    this.hintText,
    this.hintStyle,
    this.textStyle,
    this.padding,
    this.margin,
    this.minLines,
    this.textInputType,
    this.onMessageTyping,
    this.compositionThresholdTime = const Duration(seconds: 1),
    this.inputFormatters,
    this.textCapitalization,
  });
}

/// Styling configuration for recorder widget.
class VoiceRecordingConfiguration {
  const VoiceRecordingConfiguration({
  
    this.padding,
    this.margin,
    this.decoration,
    this.backgroundColor,
    this.micIcon,
    this.recorderIconColor,
    this.stopIcon,
  });


  /// Applies padding around waveform widget.
  final EdgeInsets? padding;

  /// Applies margin around waveform widget.
  final EdgeInsets? margin;

  /// Box decoration containing waveforms
  final BoxDecoration? decoration;

  /// If only background color needs to be changed then use this instead of
  /// decoration.
  final Color? backgroundColor;

  /// An icon for recording voice.
  final Widget? micIcon;

  /// An icon for stopping voice recording.
  final Widget? stopIcon;

  /// Applies color to mic and stop icon.
  final Color? recorderIconColor;
}
