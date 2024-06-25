import 'package:pamphlets_management/core/router/app_router.dart';
import 'package:pamphlets_management/features/accounts/config/accounts_getit.dart';
import 'package:pamphlets_management/features/activities/config/activities_getit.dart';
import 'package:pamphlets_management/features/activity/config/delete_activity_getit.dart';
import 'package:pamphlets_management/features/activity_categories/config/categories_config.dart';
import 'package:pamphlets_management/features/activity_categories/config/delete_category_config.dart';
import 'package:pamphlets_management/features/activity_categories/config/register_category_config.dart';
import 'package:pamphlets_management/features/activity_categories/config/update_category_config.dart';
import 'package:pamphlets_management/features/downloads/config/downloads_getit.dart';
import 'package:pamphlets_management/features/event_configuration/config/event_configuration_getit_config.dart';
import 'package:pamphlets_management/features/faq/config/faq_create_config.dart';
import 'package:pamphlets_management/features/faq/config/faq_delete_config.dart';
import 'package:pamphlets_management/features/faq/config/faq_delete_images_config.dart';
import 'package:pamphlets_management/features/faq/config/faq_image_config.dart';
import 'package:pamphlets_management/features/faq/config/faq_update_config.dart';
import 'package:pamphlets_management/features/faq/config/faqs_config.dart';
import 'package:pamphlets_management/features/forgot_password/config/validation_password_getit.dart';
import 'package:pamphlets_management/features/forgot_password/config/verify_code_password_getit.dart';
import 'package:pamphlets_management/features/gallery_create/config/gallery_create_getit.dart';
import 'package:pamphlets_management/features/home/config/token_checker_getit_config.dart';
import 'package:pamphlets_management/features/info_event/config/info_event_getit_config.dart';
import 'package:pamphlets_management/features/location/config/address_suggestions_getit.dart';
import 'package:pamphlets_management/features/log_out/config/log_out_getit_config.dart';
import 'package:pamphlets_management/features/login/config/login_google_config.dart';
import 'package:pamphlets_management/features/metrics/config/activity_metrics_getit.dart';
import 'package:pamphlets_management/features/metrics/config/get_logins_events_metrics_getit.dart';
import 'package:pamphlets_management/features/metrics/config/get_logins_hour_metrics_getit.dart';
import 'package:pamphlets_management/features/metrics/config/get_payment_events_getit.dart';
import 'package:pamphlets_management/features/metrics/config/get_payments_data_getit.dart';
import 'package:pamphlets_management/features/metrics/config/get_payments_networking_getit.dart';
import 'package:pamphlets_management/features/news_create/config/news_getit.dart';
import 'package:pamphlets_management/features/news_info/config/news_info_getit.dart';
import 'package:pamphlets_management/features/notifications/config/notifications_config.dart';
import 'package:pamphlets_management/features/settings/configs/settings_getit.dart';
import 'package:pamphlets_management/features/sign_up/sign_up_getit.dart';
import 'package:pamphlets_management/features/social_media/config/social_media_config.dart';
import 'package:pamphlets_management/features/speakers/config/speakers_getit.dart';
import 'package:pamphlets_management/features/speakers_delete/config/delete_speakers_getit_config.dart';
import 'package:pamphlets_management/features/speakers_info/config/speakers_info_getit.dart';
import 'package:pamphlets_management/features/sponsor_category/config/category_sponsors_create_getit.dart';
import 'package:pamphlets_management/features/sponsor_category/config/category_sponsors_delete_getit.dart';
import 'package:pamphlets_management/features/sponsor_category/config/category_sponsors_getit.dart';
import 'package:pamphlets_management/features/sponsor_category/config/sponsors_category_edit_getit.dart';
import 'package:pamphlets_management/features/sponsor_create/config/sponsor_create_getit.dart';
import 'package:pamphlets_management/features/sponsor_delete/config/delete_sponsors_getit_config.dart';
import 'package:pamphlets_management/features/sponsor_edit/config/edit_sponsors_getit_config.dart';
import 'package:pamphlets_management/features/sponsors_info/config/sponsors_info_getit.dart';
import 'package:pamphlets_management/features/stand_create/config/stands_getit.dart';
import 'package:pamphlets_management/features/stand_delete/config/delete_stand_getit_config.dart';
import 'package:pamphlets_management/features/stand_edit/config/edit_stand_getit.dart';
import 'package:pamphlets_management/features/stand_info/config/stands_info_getit.dart';

import '../features/delete_event/config/delete_event_getif_config.dart';
import '../features/event/config/edit_event_getit.dart';
import '../features/event/config/event_all_getit.dart';
import '../features/event/config/event_getit.dart';
import '../features/event/config/info_event_getit_config.dart';
import '../features/gallery_delete/config/gallery_delete_getit.dart';
import '../features/gallery_info.dart/config/gallery_info_getit.dart';
import '../features/login/config/login_getit.dart';
import '../features/news_delete/config/delete_news_getif_config.dart';
import '../features/speakers_edit/config/edit_speakers_getit.dart';
import '../features/validation/config/verify_code_getit.dart';

void configureGetItApp() {
  setupAppRouter();
  loginConfigure();
  signUpConfigure();
  verifyCodeConfigure();
  eventConfigure();
  eventAllConfigure();
  deleteActivityConfigure();
  editEventConfigure();
  infoEventConfigure();
  activitiesConfig();
  getItInfoEvent();
  deleteEventGetIt();
  speakerConfigure();
  speakerInfoConfigure();
  deleteSpeakersGetIt();
  accountsConfig();
  socialMediaConfigure();
  editSpeakersGetIt();
  tokenCheckerConfig();
  getLoginsEventsMetricsConfigure();
  getLoginsHourMetricsConfigure();
  getPaymentEventsConfigure();
  getPaymentsNetworkingConfigure();
  getPaymentsDataConfigure();
  getActivityMetricsConfigure();
  logOutConfigure();
  newsConfigure();
  newsInfoConfigure();
  deleteNewsGetIt();
  galleryCreateConfigure();
  galleryInfoConfigure();
  deleteGalleryGetIt();
  categoriesConfig();
  registerCategoryConfig();
  deleteCategoryConfig();
  updateCategoryConfig();
  downloadsConfig();
  eventConfigurationGetIt();
  getAddressSuggestionsConfigure();
  standConfigure();
  standsInfoConfigure();
  deleteStandGetIt();
  editStandGetItConfigure();
  loginGoogleConfig();
  sponsorsCreateConfigure();
  sponsorsInfoConfigure();
  deleteSponsorsGetIt();
  editSponsorsGetItConfigure();
  notifierConfig();
  faqCreateConfig();
  faqsConfig();
  faqDeleteConfig();
  faqUpdateConfig();
  faqImageConfig();
  faqDeleteImageConfig();
  categorySponsorsConfigure();
  categorySponsorsCreateConfigure();
  categorySponsorsDeleteGetIt();
  categorySponsorsEditConfigure();
  settingsConfigure();
  validationPasswordConfigure();
  verifyCodePasswordConfigure();
}
