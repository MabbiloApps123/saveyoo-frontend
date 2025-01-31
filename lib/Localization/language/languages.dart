import 'package:flutter/material.dart';

abstract class Languages {
  static Languages? of(BuildContext context) {
    return Localizations.of<Languages>(context, Languages);
  }

  String get appName;
  String get rupess;
  String get login;
  String get loginwelcome;
  String get email;
  String get enteremail;
  String get password;
  String get enterpassword;
  String get forgotpassword;
  String get forgotpasswordtxt;
  String get submit;
  String get notregister;
  String get contactadmin;
  String get vaildemail;
  String get vaildpassword;
  String get mnoaccount;
  String get mCreateanAccount;
  String get mAlreadyuser;
  String get mRegister;
  String get mName;
  String get menterName;
  String get maillogin;
  String get gmaillogin;
  String get applelogin;
  String get Continue;
  String get started;
  String get checkmail;
  String get sentmailto;
  String get checkbelowmail;
  String get code;
  String get entercode;
  String get notgetcode;
  String get clickhere;
  String get mycurrentlocation;
  String get selectlocation;
  String get findbag;
  String get Discover;
  String get Browse;
  String get Delivery;
  String get Favourites;
  String get Profile;
  String get Scan;

  String get settings;
  String get Accountdetails;
  String get Paymentcards;
  String get Vouchers;
  String get Notifications;
  String get community;
  String get Inviteyourfriends;
  String get Recommendastore;
  String get Signupyourstore;
  String get support;
  String get Helpwithanorder;
  String get HowTooGoodToGoworks;
  String get JoinTooGoodToGo;
  String get others;
  String get HiddenStores;
  String get Legal;
  String get logout;
  String get latechange;
  String get SurpriseBags;
  String get Supermarkets;
  String get availablenow;
  String get seeall;
  String get sortby;
  String get list;
  String get map;
  String get seeallmsg;
  String get JustforYou;
  String get supermarkets;
  String get DinnertimeDeals;
  String get update;
  String get logoutmsg;
  String get cancel;
  String get alerttitle;
  String get alertmsg;
  String get gotit;
}
