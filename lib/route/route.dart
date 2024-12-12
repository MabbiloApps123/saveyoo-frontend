import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saveyoo/Screen/Browser/bloc/browser_bloc.dart';
import 'package:saveyoo/Screen/Browser/browser_screen.dart';
import 'package:saveyoo/Screen/Dashboard/bloc/dashboard_bloc.dart';
import 'package:saveyoo/Screen/Dashboard/dashboard.dart';
import 'package:saveyoo/Screen/LandingPage/bloc/landingpage_bloc.dart';
import 'package:saveyoo/Screen/LandingPage/landingpage.dart';
import 'package:saveyoo/Screen/Login/loginsuccess.dart';
import 'package:saveyoo/Screen/OnboardingScreen/onboarding_screen.dart';
import 'package:saveyoo/Screen/ProductDetails/bloc/productdetails_bloc.dart';
import 'package:saveyoo/Screen/ProductDetails/productdetails.dart';
import 'package:saveyoo/Screen/Register/bloc/register_bloc.dart';
import 'package:saveyoo/Screen/Register/register.dart';
import 'package:saveyoo/Screen/SeeAll/bloc/seeall_bloc.dart';
import 'package:saveyoo/Screen/SeeAll/seeall_screen.dart';
import 'package:saveyoo/Screen/SetLocation/bloc/landingpage_bloc.dart';
import 'package:saveyoo/Screen/SetLocation/setlocation.dart';
import 'package:saveyoo/Screen/SupermarketSeeAll/bloc/supermarketseeall_bloc.dart';
import 'package:saveyoo/Screen/SupermarketSeeAll/supermarketseeall_screen.dart';

import '../Screen/Login/bloc/login_bloc.dart';
import '../Screen/Login/login.dart';
import '../Screen/OnboardingScreen/bloc/onboarding_bloc.dart';
import '../Utils/screens.dart';

class Routes {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case onboardingRoute:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider<OnboardingBloc>(
                create: (context) =>

                    // LoginBloc(mLoginRepo: LoginRepo(), mContext: context),
                    OnboardingBloc(mContext: context),
              )
            ],
            child: const OnboardingScreen(),
          ),
        );
      //
      case loginRoute:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider<LoginBloc>(
                create: (context) => LoginBloc(mContext: context),
              )
            ],
            child: const Login(),
          ),
        );
      case loginsuccessRoute:
        List<dynamic>? args = settings.arguments as List?;
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider<LoginBloc>(
                create: (context) => LoginBloc(mContext: context),
              )
            ],
            child: LoginSuccess(email: args![0]),
          ),
        );

      case setlocationRoute:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider<SetLocationBloc>(
                create: (context) => SetLocationBloc(mContext: context),
              )
            ],
            child: SetLocation(),
          ),
        );

      //
      case registerRoute:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider<RegisterBloc>(
                create: (context) => RegisterBloc(mContext: context),
              )
            ],
            child: const Register(),
          ),
        );
      //
      case dashboardRoute:
        // LatLng mLatLng = settings.arguments as LatLng;
        // bool mLogtype = settings.arguments as bool;
        List<dynamic>? args = settings.arguments as List?;

        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider<DashboardBloc>(
                create: (context) => DashboardBloc(mContext: context),
              )
            ],
            child: Dashboard(),
          ),
        );
      //
      case landingRoute:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider<LandingpageBloc>(
                create: (context) => LandingpageBloc(),
              )
            ],
            child: Landingpage(),
          ),
        );
      //
      case seeallRoute:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider<SeeallBloc>(
                create: (context) => SeeallBloc(mContext: context),
              )
            ],
            child: const SeeallScreen(),
          ),
        );

      case supermarketseeallRoute:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider<SupermarketSeeallBloc>(
                create: (context) => SupermarketSeeallBloc(mContext: context),
              )
            ],
            child: const SupermarketSeeallScreen(),
          ),
        );

      case productdetailsRoute:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider<ProductdetailsBloc>(
                create: (context) => ProductdetailsBloc(mContext: context),
              )
            ],
            child: const ProductdetailsScreen(),
          ),
        );
      case browserRoute:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider<BrowserBloc>(
                create: (context) => BrowserBloc(mContext: context),
              )
            ],
            child: const BrowserScreen(),
          ),
        );
      //
      // case purchaseOrderRoute:
      //   return MaterialPageRoute(
      //     builder: (context) => MultiBlocProvider(
      //       providers: [
      //         BlocProvider<PurchaseOrderBloc>(
      //           create: (context) => PurchaseOrderBloc(mContext: context)
      //             ..getPurchaseOrderList(),
      //         )
      //       ],
      //       child: const PurchaseOrderscreen(),
      //     ),
      //   );
      //
      // case salesOrderRoute:
      //   return MaterialPageRoute(
      //     builder: (context) => MultiBlocProvider(
      //       providers: [
      //         BlocProvider<SalesOrderBloc>(
      //           create: (context) =>
      //               SalesOrderBloc(mContext: context)..getSalesOrderList(),
      //         )
      //       ],
      //       child: const SalesOrderScreen(),
      //     ),
      //   );
      //
      // case paymentRoute:
      //   return MaterialPageRoute(
      //     builder: (context) => MultiBlocProvider(
      //       providers: [
      //         BlocProvider<PaymentBloc>(
      //           create: (context) =>
      //               PaymentBloc(mContext: context)..getPaymentEnteyList(),
      //         )
      //       ],
      //       child: const Payment(),
      //     ),
      //   );
      //
      // case addNewOutletRoute:
      //   return MaterialPageRoute(
      //     builder: (context) => MultiBlocProvider(
      //       providers: [
      //         BlocProvider<AddNewOutletBloc>(
      //           create: (context) => AddNewOutletBloc(mContext: context),
      //         )
      //       ],
      //       child: const AddNewOutlet(),
      //     ),
      //   );
      //
      // case addNewCallRoute:
      //   return MaterialPageRoute(
      //     builder: (context) => MultiBlocProvider(
      //       providers: [
      //         BlocProvider<AddNewCallBloc>(
      //           create: (context) => AddNewCallBloc(mContext: context),
      //         )
      //       ],
      //       child: const AddNewCall(),
      //     ),
      //   );
      //
      // case activites:
      //   return MaterialPageRoute(
      //     builder: (context) => MultiBlocProvider(
      //       providers: [
      //         BlocProvider<ActivitesBloc>(
      //           create: (context) =>
      //               ActivitesBloc(mContext: context)..getActivitesInfo(),
      //         )
      //       ],
      //       child: const MyActivites(),
      //     ),
      //   );
      //
      // case newsalesOrder:
      //   return MaterialPageRoute(
      //     builder: (context) => MultiBlocProvider(
      //       providers: [
      //         BlocProvider<NewSalesOrderBloc>(
      //           create: (context) => NewSalesOrderBloc(mContext: context),
      //         )
      //       ],
      //       child: const NewSalesOrder(),
      //     ),
      //   );
      //
      // case newCallListRoute:
      //   return MaterialPageRoute(
      //     builder: (context) => MultiBlocProvider(
      //       providers: [
      //         BlocProvider<CallListBloc>(
      //           create: (context) =>
      //               CallListBloc(mContext: context)..getCallList(),
      //         )
      //       ],
      //       child: const CallScreen(),
      //     ),
      //   );
      //
      // case newClaimlistRoute:
      //   return MaterialPageRoute(
      //     builder: (context) => MultiBlocProvider(
      //       providers: [
      //         BlocProvider<ClaimListBloc>(
      //           create: (context) =>
      //               ClaimListBloc(mContext: context)..getClaimList(),
      //         )
      //       ],
      //       child: const ClaimListscreen(),
      //     ),
      //   );
      //
      // case newClaimcreateRoute:
      //   return MaterialPageRoute(
      //     builder: (context) => MultiBlocProvider(
      //       providers: [
      //         BlocProvider<ClaimCreateBloc>(
      //           create: (context) => ClaimCreateBloc(mContext: context),
      //         )
      //       ],
      //       child: const ClaimCreate(),
      //     ),
      //   );
      //
      // case newCreatePurchaseOrderRoute:
      //   return MaterialPageRoute(
      //     builder: (context) => MultiBlocProvider(
      //       providers: [
      //         BlocProvider<CreatePurchaseOrderBloc>(
      //           create: (context) => CreatePurchaseOrderBloc(mContext: context),
      //         )
      //       ],
      //       child: const CreatePurchaseOrder(),
      //     ),
      //   );
      //
      // case newSupportRoute:
      //   List<dynamic>? args = settings.arguments as List?;
      //   return MaterialPageRoute(
      //     builder: (context) => MultiBlocProvider(
      //       providers: [
      //         BlocProvider<SupportPageBloc>(
      //           create: (context) => SupportPageBloc(mContext: context),
      //         )
      //       ],
      //       child: SupportPage(mFrom: args![0]),
      //     ),
      //   );
      //
      // case paymentEntryRoute:
      //   return MaterialPageRoute(
      //     builder: (context) => MultiBlocProvider(
      //       providers: [
      //         BlocProvider<PaymentEntryBloc>(
      //           create: (context) => PaymentEntryBloc(mContext: context),
      //         )
      //       ],
      //       child: const PaymentEntry(),
      //     ),
      //   );
      //
      // case forgetpwdRoute:
      //   return MaterialPageRoute(
      //     builder: (context) => MultiBlocProvider(
      //       providers: [
      //         BlocProvider<ForgetPwdBloc>(
      //           create: (context) => ForgetPwdBloc(mContext: context),
      //         )
      //       ],
      //       child: const ForgetPwd(),
      //     ),
      //   );

      default:
        return null;
    }
  }
}
