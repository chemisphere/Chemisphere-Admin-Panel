import 'package:education_web_admin_panel/features/shop/screens/UserDashboard/responsive_screen/dashboard_mobile.dart';
import 'package:flutter/material.dart';
import '../../../../common/widgets/layouts/templates/site_layout.dart';
import 'responsive_screen/dashboard_desktop.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(
      desktop: DashboardDesktopScreen(),
      mobile: DashboardMobileScreen(),
      tablet: DashboardDesktopScreen(),
    );
  }
}
