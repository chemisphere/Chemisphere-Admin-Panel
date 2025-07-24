
import 'package:education_web_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:education_web_admin_panel/common/widgets/layouts/templates/site_layout.dart';
import 'package:education_web_admin_panel/features/Test/Admin/addQuestion_to_sections/screens/responsive_screens/chooseSection_desktop.dart';
import 'package:education_web_admin_panel/features/Test/Admin/addQuestions/screens/addNumerical.dart';
import 'package:education_web_admin_panel/features/Test/Admin/addQuestions/screens/addMCQs.dart';
import 'package:education_web_admin_panel/features/Test/services/database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddsectionPage extends StatefulWidget {
  final String batchName;
  final String weekNumber;

  AddsectionPage({required this.batchName, required this.weekNumber});

  @override
  _AddsectionPageState createState() => _AddsectionPageState();
}

class _AddsectionPageState extends State<AddsectionPage> {
  final DatabaseService _databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return TSiteTemplate(
      desktop: ChoosesectionDesktop(batchName: widget.batchName, weekNumber: widget.weekNumber),
      tablet: ChoosesectionDesktop(batchName: widget.batchName, weekNumber: widget.weekNumber),
      mobile:  ChoosesectionDesktop(batchName: widget.batchName, weekNumber: widget.weekNumber),
      
    );
  }
}