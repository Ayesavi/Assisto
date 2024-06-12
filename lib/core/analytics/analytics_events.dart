class AnalyticsEvent {
  /// Auth Events
  static const auth = _AuthEvents();

  /// Task Creation Page Events
  static const createTask = _TaskCreationEvents();

  /// Legal Events
  static const legal = _Legal();

  /// Address Management Events
  static const manageAddresses = _AddressManagement();

  /// Task Profile Events
  static const taskProfile = _TaskProfile();

  /// Task Chat Events
  static const taskChat = _TaskChat();

  /// Profile Page Events
  static const profile = _Profile();

  static const home = _HomeEvents();

  /// Edit Profile Page Events
  static const editProfile = _EditProfile();

  /// Fill Profile Page Events when a user registers
  static const fillProfile = _FillProfileEvents();
}

class _AuthEvents {
  const _AuthEvents();

  /// event for logging out user
  final logoutEvent = "logout_event";

  /// event for logging in user
  final loginEvent = "login_event";

  /// event for signing in with google
  final googleSignInEvent = "google_sign_in_event";

  /// event for signing in with phone number
  final phoneNumberSignInEvent = "phone_number_sign_in_event";

  /// event for registering user
  final userRegisterEvent = "user_register_event";
}

class _HomeEvents {
  const _HomeEvents();

  /// Event when [TaskFilterType] is selected
  /// params must be passed with this event
  /// * name : Name of the task filter
  final taskFilterTypeEvent = "task_filter_type_event";

  /// # Search Events
  /// When a user presses on search tasks
  final searchTasksEvent = "search_tasks_event";

  /// When a user presses on FAB to create a new task
  final createTaskFABEvent = "create_task_fab_event";
}

class _TaskCreationEvents {
  const _TaskCreationEvents();

  /// When a task is created
  final createTaskEvent = "create_task_event";

  /// When user presses menu button for advanced configurations
  /// during task creation
  final configureAdavancedTaskConfigurationsEvent =
      "advanced_task_configuration_event";

  /// Configure gender at task creation
  final configureGenderTaskCreationEvent =
      "configure_gender_task_creation_event";

  /// Configure deadline for task creation
  final configureDeadlineTaskCreationEvent =
      "configure_deadline_task_creation_event";

  /// Configure location for task creation
  final configureLocationTaskCreationEvent =
      "configure_location_task_creation_event";

  /// Configure age group for task creation
  final configureAgeGroupTaskCreationEvent =
      "configure_age_group_task_creation_event";

  /// Configure budget for task creation
  final configureBudgetTaskCreationEvent =
      "configure_budget_task_creation_event";

  /// When a user pressed on help button at
  /// task creation page
  final helpButtonTaskCreationEvent = "help_button_task_creation_event";
}

class _Legal {
  const _Legal();

  /// # Legal Events
  /// When a user presses on privacy policy link
  final privacyPolicyPressEvent = "privacy_policy_press_event";

  /// When a user presses on terms of service link
  final termsOfServicePressEvent = "terms_of_service_press_event";
}

class _AddressManagement {
  const _AddressManagement();

  /// When a user searches for address
  /// Parameters must be passed in this event
  /// * [search] - The string to search
  final searchAddressPressEvent = "search_address_event";

  /// # Manage Addresses
  /// When a user presses edit address button
  final editAddressPressEvent = "edit_address_press_event";

  /// When a user presses delete address button
  final deleteAddressPressEvent = "delete_address_press_event";

  /// When a user presses add address button
  final addAddressPressEvent = "add_address_press_event";
}

class _TaskProfile {
  const _TaskProfile();

  /// # Task Profile Page
  /// When a user presses on block task button
  final blockTaskPressEvent = "block_task_press_event";

  /// When a user presses on place bid button
  final placeBidPressEvent = "place_bid_press_event";

  /// When a user presses on complete task button
  final completeTaskPressEvent = "complete_task_press_event";

  /// When a user presses on accept bid button
  final acceptBidPressEvent = "accept_bid_press_event";

  /// When a user presses on location button on task profile
  final locationTaskProfilePressEvent = "location_task_profile_press_event";

  /// When a user presses on chat button on task profile
  final chatTaskProfilePressEvent = "chat_task_profile_press_event";
}

class _TaskChat {
  const _TaskChat();

  /// # Task Chat
  /// When a user presses on chat app bar
  final chatAppBarPressEvent = "chat_app_bar_press_event";

  /// When a user presses on chat bubble edit button
  final chatBubbleEditButtonPressEvent = "chat_bubble_edit_button_press_event";

  /// When a user swipes a chat bubble for reply
  final chatBubbleReplySwipeEvent = "chat_bubble_reply_swipe_event";

  /// When a user presses on reply button for reply
  final chatBubbleReplyButtonPressEvent =
      "chat_bubble_reply_button_press_event";
}

class _Profile {
  const _Profile();

  /// # Profile Page
  /// When a user presses on delete account button
  final deleteAccountPressEvent = "delete_account_press_event";

  /// When a user presses on help button
  final helpProfilePressEvent = "help_profile_press_event";

  /// When a user presses on about application tile
  final aboutApplicationEvent = "about_application_event";
}

class _EditProfile {
  const _EditProfile();

  /// # Edit Profile Page
  /// When a user presses on save profile button
  final saveProfilePressEvent = "save_profile_press_event";

  /// When a user changes email
  final changeEmailEvent = "change_email_event";

  /// When a user changes phone number
  final changePhoneNumberPressEvent = "change_phone_number_event";

  /// When a user changes name
  final changeNameEvent = "change_name_event";

  /// When a user changes gender
  final changeGenderEvent = "change_gender_event";

  /// When a user changes dob
  final changeDobEvent = "change_dob_event";

  /// When a user updates tags
  final updateTagsEvent = "update_tags_event";

  /// When a user updates bio
  final updateBioEvent = "update_bio_event";

  
}

class _FillProfileEvents {
  const _FillProfileEvents();

  /// When a generates tags for profile from assisto ai
  final generateTagsEvent = "generate_user_tags_from_ai_event";
}
