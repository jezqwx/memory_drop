// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Memory Drop';

  @override
  String get settings => 'Settings';

  @override
  String get theme => 'Theme';

  @override
  String get language => 'Language';

  @override
  String get systemTheme => 'System';

  @override
  String get lightTheme => 'Light';

  @override
  String get darkTheme => 'Dark';

  @override
  String get homeTitle => 'Memory Capsule';

  @override
  String get home => 'Home';

  @override
  String get homeSubtitle => 'Leave a memory somewhere in the world.';

  @override
  String get createDrop => 'Create memory';

  @override
  String get create => 'Create';

  @override
  String get myMemories => 'My memories';

  @override
  String get profile => 'Profile';

  @override
  String get searchHint => 'Search by title or location';

  @override
  String get nothingFound => 'Nothing found';

  @override
  String get noMemories => 'No memories yet';

  @override
  String get retry => 'Retry';

  @override
  String get loadError => 'Failed to load memories';

  @override
  String get dropNotFound => 'Memory not found';

  @override
  String get locked => 'Locked';

  @override
  String get available => 'Available';

  @override
  String get dropLockedTitle => 'This memory is still locked';

  @override
  String get dropLockedText =>
      'To unlock this memory, you need to be near this place.';

  @override
  String get dropAvailableTitle => 'Memory available';

  @override
  String get dropAvailableText => 'This memory can already be opened.';

  @override
  String get createTitle => 'Create memory';

  @override
  String get titleLabel => 'Title';

  @override
  String get locationLabel => 'Location';

  @override
  String get messageLabel => 'Message';

  @override
  String get save => 'Save';

  @override
  String get profileTitle => 'Profile';

  @override
  String get nameLabel => 'Name';

  @override
  String get themeSystemSubtitle => 'Use device theme';

  @override
  String get russian => 'Русский';

  @override
  String get english => 'English';

  @override
  String get homeHeroDescription =>
      'Create a hidden message and return to it later.';

  @override
  String get quickActions => 'Quick actions';

  @override
  String get createDropSubtitle => 'Leave a new memory';

  @override
  String get myMemoriesSubtitle => 'View saved memories';

  @override
  String get profileSubtitle => 'Activity and memories';

  @override
  String get createDescription => 'Write what you want to leave as a memory.';

  @override
  String get locationComingSoon => 'Will be added later';

  @override
  String get createMemoryButton => 'Create memory';

  @override
  String get createMemoryComingSoon => 'Memory creation will be added later';

  @override
  String get memoriesCount => 'Memories';

  @override
  String get openedCount => 'Opened';

  @override
  String get lockedCount => 'Locked';

  @override
  String get themeSubtitle => 'System, light or dark';

  @override
  String get languageSubtitle => 'Russian / English';
}
