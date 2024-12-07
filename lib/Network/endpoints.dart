//Live
//const String mToken = 'token 06824ca15bfc573:052757a99eff455';
// const String mToken = 'token 06824ca15bfc573:9f0fda27cbf2fe8';
// const String baseUrl = 'https://core.startinsights.io';

const String mToken = 'token bd3a4e16641c457:f2dc94392c13bfc';
const String baseUrl = 'https://core.startinsights.io';

//staging
// const String mToken = 'token bd3a4e16641c457:9e57cb58d440c08';
// const String baseUrl = 'https://stage.startinsights.io';

//const String baseUrl = 'https://startinsights.ai/api';
const String masterAPI =
    '$baseUrl/api/method/startinsights.website_api.masters.get_masters';

const String quotesMasterAPI =
    '$baseUrl/api/method/startinsights.website_api.pitch_room.get_pitch_room_quotes';

const String registerAPI =
    '$baseUrl/api/method/startinsights.website_api.register.create_user';

const String loginAPI =
    '$baseUrl/api/method/startinsights.website_api.login.user_login';

const String courseslistAPI =
    '$baseUrl/api/method/startinsights.website_api.lms_course.courses_list_api';

const String savedcoursesAPI =
    '$baseUrl/api/method/startinsights.website_api.lms_course.get_saved_list_course';

const String coursesdetailsAPI =
    '$baseUrl/api/method/startinsights.website_api.lms_course.lms_course_details';

const String bookanexpertlistAPI =
    '$baseUrl/api/method/startinsights.website_api.fundraising_experts.get_fundraising_experts';

const String expertbookingAPI =
    '$baseUrl/api/method/startinsights.website_api.book_an_expert.book_an_expert';

const String pitchcraftlistAPI =
    '$baseUrl/api/method/startinsights.website_api.pitch_craft.pitch_craft_list';

const String pitchcraftservicedetailsAPI =
    '$baseUrl/api/method/startinsights.website_api.pitch_craft.pitch_craft_service_details';

const String investmentdealsdetailsAPI =
    '$baseUrl/api/method/startinsights.website_api.investment_deals.investment_deals_details';

const String createservicelistAPI =
    '$baseUrl/api/method/startinsights.website_api.service_list.create_service_list';

const String makepitchcraftpaymentAPI =
    '$baseUrl/api/method/startinsights.website_api.pitch_craft.make_pitch_craft_payment';

const String lmsprogresAPI =
    '$baseUrl/api/method/startinsights.website_api.lms_course.create_lms_progress';

const String lmscertificateAPI =
    '$baseUrl/api/method/startinsights.website_api.lms_certificate.lms_certificate';

const String getstartupdealAPI =
    '$baseUrl/api/method/startinsights.website_api.startup_deals.get_deal_list';

const String getdealsredeemcodeAPI =
    '$baseUrl/api/method/startinsights.website_api.startup_deals.redeem_code';

const String getpitchroomlistAPI =
    '$baseUrl/api/method/startinsights.website_api.pitch_room.get_room_details';

const String getuserswithroleAPI =
    '$baseUrl/api/method/startinsights.website_api.pitch_room.get_users_with_role';

const String createpitchroomAPI =
    '$baseUrl/api/method/startinsights.website_api.pitch_room.create_pitch_room';

const String getinvestorroundwisegraphAPI =
    '$baseUrl/api/method/startinsights.website_api.captable_management.captable_management_list';

const String getredeemstatusupdateAPI =
    '$baseUrl/api/method/startinsights.website_api.startup_deals.startup_redeem_status_update';

const String updateprofileAPI =
    '$baseUrl/api/method/startinsights.website_api.profile.update_profile';

const String searchinvestorslistAPI =
    '$baseUrl/api/method/startinsights.website_api.search_investors.get_search_investors_list';

//New API

const String createUserAPI =
    '$baseUrl/api/method/startinsights.website_api.register.create_lead';

const String createUserFinishAPI =
    '$baseUrl/api/method/startinsights.website_api.register.create_account';

const String createInvestorsAccountAPI =
    '$baseUrl/api/method/startinsights.website_api.register.create_investors_account';

const String FundingCRMAPI =
    '$baseUrl/api/method/startinsights.website_api.funding_crm.get_funding_crm';

const String FavouriteAPI =
    '$baseUrl/api/method/startinsights.website_api.search_investors.get_favourite_investors';

const String RemoveFavouriteAPI =
    '$baseUrl/api/method/startinsights.website_api.search_investors.remove_favourites_investors';

const String AddFavouriteAPI =
    '$baseUrl/api/method/startinsights.website_api.search_investors.set_investors_favourites';

const String UpdatefundingcrmAPI =
    '$baseUrl/api/method/startinsights.website_api.funding_crm.update_funding_crm';

const String DashboardAPI =
    '$baseUrl/api/method/startinsights.website_api.search_investors.get_recommended_search_investors';

const String ForgetPwdAPI =
    '$baseUrl/api/method/startinsights.website_api.forget_api.auth_code_with_mail';

const String ResetPwdAPI =
    '$baseUrl/api/method/startinsights.website_api.forget_api.change_password';

const String servicelistAPI =
    '$baseUrl/api/method/startinsights.website_api.services.service_list';

const String makeservicepaymentAPI =
    '$baseUrl/api/method/startinsights.website_api.services.create_service_payment';

const String servicedetailsAPI =
    '$baseUrl/api/method/startinsights.website_api.services.get_my_service_details';

const String updateRoomAPI =
    '$baseUrl/api/method/startinsights.website_api.pitch_room.pitch_room_update';

const String shareduserAPI =
    '$baseUrl/api/method/startinsights.website_api.pitch_room.shared_user';

const String LearnListAPI =
    '$baseUrl/api/method/startinsights.website_api.lms_course.learn_list';

const String AddFavouritecourseAPI =
    '$baseUrl/api/method/startinsights.website_api.lms_course.mark_favourite_course';

const String RemoveFavouritecourseAPI =
    '$baseUrl/api/method/startinsights.website_api.lms_course.unmarked_favourite_course';

const String FavouritecourseListAPI =
    '$baseUrl/api/method/startinsights.website_api.lms_course.get_favourite_courses';

const String CourseDetailsAPI =
    '$baseUrl/api/method/startinsights.website_api.lms_course.learn_details';

const String EventListAPI =
    '$baseUrl/api/method/startinsights.website_api.event.get_events';

const String mAddEventRegister =
    '$baseUrl/api/method/startinsights.website_api.event.create_registered_event';

const String mRemovedocument =
    '$baseUrl/api/method/startinsights.website_api.pitch_room.remove_document';

const String mProfileList =
    '$baseUrl/api/method/startinsights.website_api.profile.get_profile_details';

const String mCreateinvestor =
    '$baseUrl/api/method/startinsights.website_api.user_creation_investor.create_investor';

const String servicesdocupload =
    '$baseUrl/api/method/startinsights.website_api.services.my_services_doc_upload';

const String startchatconversation =
    '$baseUrl/api/method/startinsights.website_api.my_services.set_chat_conversation';

const String createcaptablemanagmentAPI =
    '$baseUrl/api/method/startinsights.website_api.captable_management.create_captable_managment';

const String deletefundingcrmAPI =
    '$baseUrl/api/method/startinsights.website_api.funding_crm.delete_funding_crm_investor';

const String getshareRoomAPI =
    '$baseUrl/api/method/startinsights.website_api.pitch_room.get_share_link_list';

const String getQuizDetailsAPI =
    '$baseUrl/api/method/startinsights.website_api.fundability_quiz.get_fundability_quiz';

const String getiFrameQuizDetailsAPI =
    '$baseUrl/api/method/startinsights.website_api.i_frame_quiz.create_i_frame_quiz';

const String getCapatableMasterAPI =
    '$baseUrl/api/method/startinsights.website_api.masters.get_captable_masters';

const String createQuizUserAPI =
    '$baseUrl/api/method/startinsights.website_api.i_frame_quiz.get_quiz_score';

const String loginQuizUserAPI =
    '$baseUrl/api/method/startinsights.website_api.i_frame_quiz.get_score_as_login';

const String TicketTypeAPI =
    '$baseUrl/api/method/startinsights.website_api.support.get_ticket_type_masters';

const String CreateTicketAPI =
    '$baseUrl/api/method/startinsights.website_api.support.create_support_ticket';

const String CreateTicketListAPI =
    '$baseUrl/api/method/startinsights.website_api.support.get_support_ticket_list';

const String getFAQAPI =
    '$baseUrl/api/method/startinsights.website_api.faq_question_api.get_faq_questions_and_answers';

const String deletepitchroom =
    '$baseUrl/api/method/startinsights.website_api.pitch_room.delete_pitch_room';

const String deckuserplan =
    '$baseUrl/api/method/startinsights.website_api.deck_review.get_deck_user_and_plan_details';

const String deckreview =
    '$baseUrl/api/method/startinsights.website_api.deck_review.get_and_update_deck_review_user';

const String planupgrade =
    '$baseUrl/api/method/startinsights.website_api.deck_review.deck_plan_upgrade';

const String AddbillingAddress =
    '$baseUrl/api/method/startinsights.website_api.billing_api.create_or_update_billing_details';

const String GetbillingAddress =
    '$baseUrl/api/method/startinsights.website_api.billing_api.fetch_customer_address';
