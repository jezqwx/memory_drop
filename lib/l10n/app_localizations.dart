import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ru'),
  ];

  /// No description provided for @appName.
  ///
  /// In ru, this message translates to:
  /// **'Memory Drop'**
  String get appName;

  /// No description provided for @settings.
  ///
  /// In ru, this message translates to:
  /// **'Настройки'**
  String get settings;

  /// No description provided for @theme.
  ///
  /// In ru, this message translates to:
  /// **'Тема'**
  String get theme;

  /// No description provided for @language.
  ///
  /// In ru, this message translates to:
  /// **'Язык'**
  String get language;

  /// No description provided for @systemTheme.
  ///
  /// In ru, this message translates to:
  /// **'Системная'**
  String get systemTheme;

  /// No description provided for @lightTheme.
  ///
  /// In ru, this message translates to:
  /// **'Светлая'**
  String get lightTheme;

  /// No description provided for @darkTheme.
  ///
  /// In ru, this message translates to:
  /// **'Тёмная'**
  String get darkTheme;

  /// No description provided for @homeTitle.
  ///
  /// In ru, this message translates to:
  /// **'Капсула воспоминаний'**
  String get homeTitle;

  /// No description provided for @home.
  ///
  /// In ru, this message translates to:
  /// **'Главная'**
  String get home;

  /// No description provided for @homeSubtitle.
  ///
  /// In ru, this message translates to:
  /// **'Оставь воспоминание где-нибудь в мире.'**
  String get homeSubtitle;

  /// No description provided for @createDrop.
  ///
  /// In ru, this message translates to:
  /// **'Создать воспоминание'**
  String get createDrop;

  /// No description provided for @create.
  ///
  /// In ru, this message translates to:
  /// **'Создать'**
  String get create;

  /// No description provided for @myMemories.
  ///
  /// In ru, this message translates to:
  /// **'Мои воспоминания'**
  String get myMemories;

  /// No description provided for @profile.
  ///
  /// In ru, this message translates to:
  /// **'Профиль'**
  String get profile;

  /// No description provided for @searchHint.
  ///
  /// In ru, this message translates to:
  /// **'Поиск по названию или месту'**
  String get searchHint;

  /// No description provided for @nothingFound.
  ///
  /// In ru, this message translates to:
  /// **'Ничего не найдено'**
  String get nothingFound;

  /// No description provided for @noMemories.
  ///
  /// In ru, this message translates to:
  /// **'Воспоминаний пока нет'**
  String get noMemories;

  /// No description provided for @retry.
  ///
  /// In ru, this message translates to:
  /// **'Повторить'**
  String get retry;

  /// No description provided for @loadError.
  ///
  /// In ru, this message translates to:
  /// **'Не удалось загрузить воспоминания'**
  String get loadError;

  /// No description provided for @dropNotFound.
  ///
  /// In ru, this message translates to:
  /// **'Воспоминание не найдено'**
  String get dropNotFound;

  /// No description provided for @locked.
  ///
  /// In ru, this message translates to:
  /// **'Закрыто'**
  String get locked;

  /// No description provided for @available.
  ///
  /// In ru, this message translates to:
  /// **'Доступно'**
  String get available;

  /// No description provided for @dropLockedTitle.
  ///
  /// In ru, this message translates to:
  /// **'Это воспоминание пока закрыто'**
  String get dropLockedTitle;

  /// No description provided for @dropLockedText.
  ///
  /// In ru, this message translates to:
  /// **'Чтобы открыть воспоминание, нужно находиться рядом с этим местом.'**
  String get dropLockedText;

  /// No description provided for @dropAvailableTitle.
  ///
  /// In ru, this message translates to:
  /// **'Воспоминание доступно'**
  String get dropAvailableTitle;

  /// No description provided for @dropAvailableText.
  ///
  /// In ru, this message translates to:
  /// **'Это воспоминание уже можно открыть.'**
  String get dropAvailableText;

  /// No description provided for @createTitle.
  ///
  /// In ru, this message translates to:
  /// **'Создать воспоминание'**
  String get createTitle;

  /// No description provided for @titleLabel.
  ///
  /// In ru, this message translates to:
  /// **'Название'**
  String get titleLabel;

  /// No description provided for @locationLabel.
  ///
  /// In ru, this message translates to:
  /// **'Место'**
  String get locationLabel;

  /// No description provided for @messageLabel.
  ///
  /// In ru, this message translates to:
  /// **'Сообщение'**
  String get messageLabel;

  /// No description provided for @save.
  ///
  /// In ru, this message translates to:
  /// **'Сохранить'**
  String get save;

  /// No description provided for @profileTitle.
  ///
  /// In ru, this message translates to:
  /// **'Профиль'**
  String get profileTitle;

  /// No description provided for @nameLabel.
  ///
  /// In ru, this message translates to:
  /// **'Имя'**
  String get nameLabel;

  /// No description provided for @themeSystemSubtitle.
  ///
  /// In ru, this message translates to:
  /// **'Использовать тему устройства'**
  String get themeSystemSubtitle;

  /// No description provided for @russian.
  ///
  /// In ru, this message translates to:
  /// **'Русский'**
  String get russian;

  /// No description provided for @english.
  ///
  /// In ru, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @homeHeroDescription.
  ///
  /// In ru, this message translates to:
  /// **'Создай скрытое послание и вернись к нему позже.'**
  String get homeHeroDescription;

  /// No description provided for @quickActions.
  ///
  /// In ru, this message translates to:
  /// **'Быстрые действия'**
  String get quickActions;

  /// No description provided for @createDropSubtitle.
  ///
  /// In ru, this message translates to:
  /// **'Оставить новое воспоминание'**
  String get createDropSubtitle;

  /// No description provided for @myMemoriesSubtitle.
  ///
  /// In ru, this message translates to:
  /// **'Просмотреть сохраненные воспоминания'**
  String get myMemoriesSubtitle;

  /// No description provided for @profileSubtitle.
  ///
  /// In ru, this message translates to:
  /// **'Активность и воспоминания'**
  String get profileSubtitle;

  /// No description provided for @createDescription.
  ///
  /// In ru, this message translates to:
  /// **'Напишите то, что хотите оставить на память.'**
  String get createDescription;

  /// No description provided for @locationComingSoon.
  ///
  /// In ru, this message translates to:
  /// **'Будет добавлено позже'**
  String get locationComingSoon;

  /// No description provided for @createMemoryButton.
  ///
  /// In ru, this message translates to:
  /// **'Создать воспоминание'**
  String get createMemoryButton;

  /// No description provided for @createMemoryComingSoon.
  ///
  /// In ru, this message translates to:
  /// **'Создание воспоминания будет добавлено позже'**
  String get createMemoryComingSoon;

  /// No description provided for @memoriesCount.
  ///
  /// In ru, this message translates to:
  /// **'Воспоминания'**
  String get memoriesCount;

  /// No description provided for @openedCount.
  ///
  /// In ru, this message translates to:
  /// **'Открыто'**
  String get openedCount;

  /// No description provided for @lockedCount.
  ///
  /// In ru, this message translates to:
  /// **'Заблокировано'**
  String get lockedCount;

  /// No description provided for @themeSubtitle.
  ///
  /// In ru, this message translates to:
  /// **'Системная, светлая или тёмная'**
  String get themeSubtitle;

  /// No description provided for @languageSubtitle.
  ///
  /// In ru, this message translates to:
  /// **'Русский / English'**
  String get languageSubtitle;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
