
import 'package:education_web_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:education_web_admin_panel/common/widgets/layouts/templates/site_layout.dart';
import 'package:education_web_admin_panel/features/Test/Admin/Create_Week_Test_List/screens/responsive_screens/create_week_list_desktop.dart';
import 'package:education_web_admin_panel/features/Test/Admin/AddWeekTest/screens/CreateWeekPage.dart';
import 'package:education_web_admin_panel/features/Test/Admin/addQuestion_to_sections/screens/chooseSection.dart';
import 'package:education_web_admin_panel/features/Test/Admin/models/Week.dart';
import 'package:education_web_admin_panel/features/Test/services/database.dart';
import 'package:flutter/material.dart';

class WeekListPage extends StatefulWidget {
  String batchName;
   WeekListPage({super.key,required this.batchName});


  @override
  _WeekListPageState createState() => _WeekListPageState();
}
class _WeekListPageState extends State<WeekListPage> {
  final DatabaseService _databaseService = DatabaseService();
  Future<List<Week>>? weeksFuture;

  @override
  void initState() {
    super.initState();
    weeksFuture = _databaseService.getWeeks(widget.batchName);
  }

  @override
  Widget build(BuildContext context) {
    return TSiteTemplate(
      desktop:  CreateWeekList_desktop(batchName: widget.batchName),
      tablet: CreateWeekList_desktop(batchName: widget.batchName),
      mobile: CreateWeekList_desktop(batchName: widget.batchName),
      
      );
  }
}