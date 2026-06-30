import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/app_screen.dart';
import '../state/app_state.dart';
import 'onboarding/onboarding_screens.dart';
import 'home/home_screen.dart';
import 'bills/bills_screens.dart';
import 'complaints/complaints_screens.dart';
import 'notices/notices_screens.dart';
import 'events/events_screens.dart';
import 'media/media_screen.dart';
import 'directory/directory_screens.dart';
import 'visitors/visitors_screens.dart';
import 'community/community_screens.dart';
import 'polls/polls_screens.dart';
import 'sos/sos_screen.dart';
import 'profile/profile_screens.dart';
import 'mc/mc_dashboard_screen.dart';
import 'employee/employee_dashboard_screen.dart';

/// Switches on [AppState.screen] to build the active screen's content.
/// Each branch returns its own [AppScaffold]-wrapped widget.
class ScreenRouter extends StatelessWidget {
  const ScreenRouter({super.key});

  @override
  Widget build(BuildContext context) {
    final screen = context.watch<AppState>().screen;
    switch (screen) {
      case AppScreen.splash:
        return const SplashScreen();
      case AppScreen.welcome:
        return const WelcomeScreen();
      case AppScreen.rolePicker:
        return const RolePickerScreen();
      case AppScreen.regProperty:
        return const RegPropertyScreen();
      case AppScreen.regOtp:
        return const RegOtpScreen();
      case AppScreen.regProfile:
        return const RegProfileScreen();
      case AppScreen.regPending:
        return const RegPendingScreen();
      case AppScreen.login:
        return const LoginScreen();
      case AppScreen.home:
        return const HomeScreen();
      case AppScreen.bills:
        return const BillsScreen();
      case AppScreen.billDetail:
        return const BillDetailScreen();
      case AppScreen.payMethod:
        return const PaymentMethodScreen();
      case AppScreen.paySuccess:
        return const PaymentSuccessScreen();
      case AppScreen.complaints:
        return const ComplaintsScreen();
      case AppScreen.fileComplaint:
        return const FileComplaintScreen();
      case AppScreen.complaintDetail:
        return const ComplaintDetailScreen();
      case AppScreen.notices:
        return const NoticesScreen();
      case AppScreen.noticeDetail:
        return const NoticeDetailScreen();
      case AppScreen.directory:
        return const DirectoryScreen();
      case AppScreen.dirAddSelf:
        return const DirAddSelfScreen();
      case AppScreen.dirAddWorker:
        return const DirAddWorkerScreen();
      case AppScreen.providerDetail:
        return const ProviderDetailScreen();
      case AppScreen.chat:
        return const ChatScreen();
      case AppScreen.visitors:
        return const VisitorsScreen();
      case AppScreen.inviteGuest:
        return const InviteGuestScreen();
      case AppScreen.visitorPass:
        return const VisitorPassScreen();
      case AppScreen.events:
        return const EventsScreen();
      case AppScreen.eventDetail:
        return const EventDetailScreen();
      case AppScreen.media:
        return const MediaScreen();
      case AppScreen.community:
        return const CommunityScreen();
      case AppScreen.composePost:
        return const ComposePostScreen();
      case AppScreen.listingDetail:
        return const ListingDetailScreen();
      case AppScreen.listProduct:
        return const ListProductScreen();
      case AppScreen.myAds:
        return const MyAdsScreen();
      case AppScreen.polls:
        return const PollsScreen();
      case AppScreen.pollResults:
        return const PollResultsScreen();
      case AppScreen.sos:
        return const SosScreen();
      case AppScreen.profile:
        return const ProfileScreen();
      case AppScreen.settings:
        return const SettingsScreen();
      case AppScreen.switchRole:
        return const SwitchRoleScreen();
      case AppScreen.notifications:
        return const NotificationsScreen();
      case AppScreen.mcDashboard:
        return const McDashboardScreen();
      case AppScreen.empDashboard:
        return const EmpDashboardScreen();
    }
  }
}
