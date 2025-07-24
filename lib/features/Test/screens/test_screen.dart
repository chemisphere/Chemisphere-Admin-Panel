import 'package:education_web_admin_panel/features/Test/screens/responsive_screen/test_desktop.dart';
import 'package:flutter/material.dart';
import '../../../common/widgets/layouts/templates/site_layout.dart';
import 'responsive_screen/test_mobile.dart';


class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(
      desktop:TestDesktopScreen(),
      tablet: TestMobileScreen(),
      mobile:TestMobileScreen(),
    );
  }
}
