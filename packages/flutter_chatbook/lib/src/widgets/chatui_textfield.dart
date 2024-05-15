part of '../../flutter_chatbook.dart';

class ChatUITextField extends StatefulWidget {
  const ChatUITextField(
      {Key? key,
      this.sendMessageConfig,
      required this.focusNode,
      required this.textEditingController,
      required this.onPressed,
      required this.chatController,
      this.threaded,
      this.showToolBarButtons = false})
      : super(key: key);

  /// Provides configuration of default text field in chat.
  final SendMessageConfiguration? sendMessageConfig;

  /// Provides focusNode for focusing text field.
  final FocusNode focusNode;

  /// Provides functions which handles text field.
  final TextEditingController textEditingController;

  /// Provides callback when user tap on text field.
  final VoidCallBack onPressed;

  final ChatController chatController;

  /// Whether to show toolbarbuttons at the text field
  final bool showToolBarButtons;

  final Widget? threaded;

  @override
  State<ChatUITextField> createState() => _ChatUITextFieldState();
}

class _ChatUITextFieldState extends State<ChatUITextField> {
  final ValueNotifier<String> _inputText = ValueNotifier('');

  final ValueNotifier<bool> isUserTagging = ValueNotifier(false);

  ValueNotifier<bool> isRecording = ValueNotifier(false);

  SendMessageConfiguration? get sendMessageConfig => widget.sendMessageConfig;

  VoiceRecordingConfiguration? get voiceRecordingConfig =>
      widget.sendMessageConfig?.voiceRecordingConfiguration;

  ImagePickerIconsConfiguration? get imagePickerIconsConfig =>
      sendMessageConfig?.imagePickerIconsConfig;

  TextFieldConfiguration? get textFieldConfig =>
      sendMessageConfig?.textFieldConfig;

  OutlineInputBorder get _outLineBorder => OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.transparent),
        borderRadius: textFieldConfig?.borderRadius ??
            BorderRadius.circular(textFieldBorderRadius),
      );

  ValueNotifier<TypeWriterStatus> composingStatus =
      ValueNotifier(TypeWriterStatus.typed);

  late Debouncer debouncer;

  bool showButtons = true;

  String? currentUserId;

  @override
  void initState() {
    attachListeners();
    debouncer = Debouncer(
        sendMessageConfig?.textFieldConfig?.compositionThresholdTime ??
            const Duration(seconds: 1));
    super.initState();
  }

  @override
  void dispose() {
    debouncer.dispose();
    composingStatus.dispose();
    isRecording.dispose();
    _inputText.dispose();
    super.dispose();
  }

  void attachListeners() {
    composingStatus.addListener(() {
      widget.sendMessageConfig?.textFieldConfig?.onMessageTyping
          ?.call(composingStatus.value);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (provide != null) {
      currentUserId = provide!.currentUserId;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
      Expanded(
          child: Material(
              elevation: .5,
              child: Row(
                children: [
                  if (showButtons) ...[
                    FilledButton(
                        onPressed: () {
                          sendMessageConfig?.onRequest?.call();
                        },
                        child: Text('Request')),
                    SizedBox(
                      width: 5,
                    ),
                    FilledButton(
                        onPressed: () {
                          sendMessageConfig?.onPay?.call();
                        },
                        child: Text('Pay')),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                  Expanded(
                    child: Focus(
                      onFocusChange: (v) {
                        if (v) {
                          setState(() {
                            showButtons = false;
                          });
                        }
                      },
                      child: Container(
                        padding: textFieldConfig?.padding ??
                            const EdgeInsets.symmetric(horizontal: 6),
                        margin: textFieldConfig?.margin,
                        decoration: BoxDecoration(
                          borderRadius: textFieldConfig?.borderRadius ??
                              BorderRadius.circular(textFieldBorderRadius),
                          color: Theme.of(context).colorScheme.onInverseSurface,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Column(children: [
                                    if (widget.threaded != null) ...[
                                      widget.threaded!
                                    ],
                                    TextField(
                                      focusNode: widget.focusNode,
                                      controller: widget.textEditingController,
                                      // style: textFieldConfig?.textStyle ??
                                      //     const TextStyle(color: Colors.white),
                                      maxLines: textFieldConfig?.maxLines ?? 5,
                                      minLines: textFieldConfig?.minLines ?? 1,
                                      keyboardType:
                                          textFieldConfig?.textInputType,
                                      inputFormatters:
                                          textFieldConfig?.inputFormatters,
                                      onChanged: _onChanged,
                                      textCapitalization:
                                          textFieldConfig?.textCapitalization ??
                                              TextCapitalization.sentences,
                                      decoration: InputDecoration(
                                        hintText: textFieldConfig?.hintText ??
                                            PackageStrings.message,
                                        // fillColor: Theme.of(context)
                                        //     .colorScheme
                                        //     .surfaceContainerHighest,
                                        // filled: true,
                                        hintStyle: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: 0.25,
                                        ),
                                        prefixIcon: IconButton(
                                          constraints: const BoxConstraints(),
                                          onPressed: () {
                                            setState(() {
                                              showButtons = !showButtons;
                                            });
                                          },
                                          icon: Icon(
                                            showButtons
                                                ? Icons.chevron_left
                                                : Icons.chevron_right,
                                          ),
                                        ),
                                        contentPadding:
                                            textFieldConfig?.contentPadding ??
                                                const EdgeInsets.symmetric(
                                                    horizontal: 6),
                                        border: _outLineBorder,
                                        focusedBorder: _outLineBorder,
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.transparent),
                                          borderRadius:
                                              textFieldConfig?.borderRadius ??
                                                  BorderRadius.circular(
                                                      textFieldBorderRadius),
                                        ),
                                      ),
                                    )
                                  ]),
                                ),
                                IconButton(
                                  color: Theme.of(context).colorScheme.primary,
                                  onPressed: () {
                                    if (widget.textEditingController.text
                                        .trim()
                                        .isNotEmpty) {
                                      isUserTagging.value = false;
                                      widget.onPressed();
                                    }
                                    widget.textEditingController.clear();
                                    _inputText.value = '';
                                  },
                                  icon: CircleAvatar(
                                      radius: 16,
                                      backgroundColor:
                                          Theme.of(context).colorScheme.primary,
                                      child:
                                          sendMessageConfig?.sendButtonIcon ??
                                              const Icon(
                                                Icons.send_rounded,
                                                color: Colors.white,
                                                size: 18,
                                              )),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ))),
    ]);
  }

  void _onChanged(String inputText) {
    if (widget.textEditingController.text
            .split(' ')
            .indexWhere((element) => element.startsWith('@')) !=
        -1) {
      // isUserTagging.value = true;
    } else if (inputText.trim().isEmpty) {
      isUserTagging.value = false;
    }
    debouncer.run(() {
      composingStatus.value = TypeWriterStatus.typed;
    }, () {
      composingStatus.value = TypeWriterStatus.typing;
    });
    _inputText.value = inputText;
  }
}
