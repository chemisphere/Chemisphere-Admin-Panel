import 'package:flutter/material.dart';
import '../../../common/widgets/layouts/templates/site_layout.dart';
import 'responsive_screens/files_desktop.dart';
import 'responsive_screens/files_mobile.dart';


class FilesScreen extends StatelessWidget {
  const FilesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(
      desktop:FilesDesktopScreen(),
      tablet:FilesDesktopScreen(),
      mobile:FilesMobileScreen(),
    );
  }
}
