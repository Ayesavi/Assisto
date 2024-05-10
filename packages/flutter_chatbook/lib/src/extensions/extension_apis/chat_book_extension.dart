// import '../../../flutter_chatbook.dart';

// /// `ChatBookExtension` API is used for extending services and using this package with custom plugins.
// /// `ChatBookExtension` can be used for extending support for custom messages and custom services.
// /// [ChatBookController] and [ChatBook] can utilize only one `ChatBookExtension` at a time.
// /// `ChatBookExtension` holds [ServiceExtension] and [WidgetsExtension] for extending services and support for new messages, respectively. See [ServiceExtension] and [WidgetsExtension] for more information.
// class ChatBookExtension {
//   /// Used for extending services. See [ServiceExtension].
//   final ServiceExtension? serviceExtension;

//   /// Used for adding support for new messages and widgets. See [WidgetsExtension].
//   final WidgetsExtension? widgetsExtension;

//   /// Creates a new instance of [ChatBookExtension] with the specified service and widgets extensions.
//   const ChatBookExtension({this.serviceExtension, this.widgetsExtension});
// }

// /// `ServiceExtension` is used to allocate services such as [DatabaseManager] and [BackendManager].
// class ServiceExtension<T extends DatabaseManager> {
//   /// The data manager used for custom database support.
//   final T? dataManager;

//   /// The backend service used for handling transmission and receiving of messages.
//   final BackendManager? backendService;

//   /// Creates a new instance of [ServiceExtension] with the specified data manager and backend service.
//   const ServiceExtension({this.dataManager, this.backendService});
// }
