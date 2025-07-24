
import 'package:education_web_admin_panel/common/widgets/layouts/templates/site_layout.dart';
import 'package:education_web_admin_panel/features/Test/Admin/AddWeekTest/screens/responsive_screens/addWeektest_desktop.dart';

import 'package:flutter/material.dart';

class CreateWeekPage extends StatefulWidget {
  final String batchName;

  CreateWeekPage({required this.batchName});

  @override
  _CreateWeekPageState createState() => _CreateWeekPageState();
}

class _CreateWeekPageState extends State<CreateWeekPage> {
  

  @override
  Widget build(BuildContext context) {
    return TSiteTemplate(
      desktop: AddWeekTest_desktop(batchName: widget.batchName),
      tablet: AddWeekTest_desktop(batchName: widget.batchName),
      mobile: AddWeekTest_desktop(batchName: widget.batchName),
    );
  }

  
}
