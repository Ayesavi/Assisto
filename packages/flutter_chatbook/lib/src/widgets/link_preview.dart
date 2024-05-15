part of '../../flutter_chatbook.dart';

class LinkPreview extends StatelessWidget {
  const LinkPreview({
    Key? key,
    required this.url,
    this.linkPreviewConfig,
  }) : super(key: key);

  /// Provides url which is passed in message.
  final String url;

  /// Provides configuration of chat bubble appearance when link/URL is passed
  /// in message.
  final LinkPreviewConfiguration? linkPreviewConfig;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: linkPreviewConfig?.padding ??
          const EdgeInsets.symmetric(horizontal: 6, vertical: verticalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: verticalPadding),
            child: url.isImageUrl
                ? Material(
                    child: InkWell(
                      onTap: _onLinkTap,
                      child: Image.network(
                        url,
                        height: 120,
                        width: double.infinity,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  )
                : Material(
                    child: AnyLinkPreview(
                      link: url,
                      removeElevation: true,
                      proxyUrl: linkPreviewConfig?.proxyUrl,
                      onTap: _onLinkTap,
                      placeholderWidget: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.25,
                        width: double.infinity,
                        child: Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 1,
                            color: linkPreviewConfig?.loadingColor,
                          ),
                        ),
                      ),
                      backgroundColor: linkPreviewConfig?.backgroundColor ??
                          Colors.grey.shade200,
                      borderRadius: linkPreviewConfig?.borderRadius,
                      bodyStyle: linkPreviewConfig?.bodyStyle ??
                          const TextStyle(color: Colors.black),
                      titleStyle: linkPreviewConfig?.titleStyle,
                    ),
                  ),
          ),
          const SizedBox(height: verticalPadding),
          InkWell(
            onTap: _onLinkTap,
            child: Text(
              url,
              style: linkPreviewConfig?.linkStyle ??
                  const TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.underline,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  void _onLinkTap() {
    if (linkPreviewConfig?.onUrlDetect != null) {
      linkPreviewConfig?.onUrlDetect!(url);
    } else {
      _launchURL();
    }
  }

  void _launchURL() async {
    final parsedUrl = Uri.parse(url);
    await canLaunchUrl(parsedUrl)
        ? await launchUrl(parsedUrl)
        : throw couldNotLunch;
  }
}
