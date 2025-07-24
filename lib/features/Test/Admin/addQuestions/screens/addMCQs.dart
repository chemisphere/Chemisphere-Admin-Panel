import 'dart:io';
import 'dart:typed_data';
import 'package:education_web_admin_panel/features/Test/Admin/addQuestions/screens/responsive_screens/addMCQs_desktop.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:education_web_admin_panel/common/widgets/layouts/templates/site_layout.dart';
import 'package:education_web_admin_panel/features/Test/Admin/addQuestions/Models/addQwidgets.dart';
import 'package:education_web_admin_panel/features/Test/services/database.dart';
import 'package:education_web_admin_panel/features/Test/utils/Utils.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class AddmcqQuestionPage extends StatefulWidget {
  final String batchName;
  final String weekNumber;
  final String section;

  const AddmcqQuestionPage({super.key, required this.batchName, required this.weekNumber,required this.section});

  @override
  State<AddmcqQuestionPage> createState() => _AddmcqQuestionPageState();
}

class _AddmcqQuestionPageState extends State<AddmcqQuestionPage> {
  

  @override
  Widget build(BuildContext context) {
    return TSiteTemplate(
      desktop: AddmcqQuestionDesktop(batchName: widget.batchName, weekNumber: widget.weekNumber, section: widget.section),
      tablet:AddmcqQuestionDesktop(batchName: widget.batchName, weekNumber: widget.weekNumber, section: widget.section),
    );
  }
}