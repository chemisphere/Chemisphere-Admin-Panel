
import 'package:education_web_admin_panel/features/Test/Admin/addQuestions/screens/responsive_screens/addNumerical_desktop.dart';


import 'package:education_web_admin_panel/common/widgets/layouts/templates/site_layout.dart';

import 'package:flutter/material.dart';


class AddNumericalQuestionPage extends StatefulWidget {
  final String batchName;
  final String weekNumber;
  final String section;

  const AddNumericalQuestionPage(
      {super.key,
      required this.batchName,
      required this.weekNumber,
      required this.section});

  @override
  State<AddNumericalQuestionPage> createState() =>
      _AddNumericalQuestionPageState();
}

class _AddNumericalQuestionPageState extends State<AddNumericalQuestionPage> {
 

  @override
  Widget build(BuildContext context) {
    return TSiteTemplate(
      desktop: AddNumericalQuestionDesktop(batchName: widget.batchName, weekNumber: widget.weekNumber, section: widget.section),
      tablet: AddNumericalQuestionDesktop(batchName: widget.batchName, weekNumber: widget.weekNumber, section: widget.section),
    );
  }
}
