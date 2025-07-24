

import 'package:education_web_admin_panel/features/Test/Admin/Create_Week_Test_List/screens/CreateWeekList.dart';
import 'package:education_web_admin_panel/features/Test/Admin/categoryADmin/category_widgets.dart';

import 'package:flutter/material.dart';

// ignore: camel_case_types
class category_admin_desktop extends StatelessWidget {
  const category_admin_desktop({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title:const Text("Add questions to batch"),
      ),
     body: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      
      children: [
           Expanded(child: GestureDetector(child: category("JEE 11th"),onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=> WeekListPage(batchName: "JEE11"))),)),
          Expanded(child: GestureDetector(child: category("JEE 12th"),onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>  WeekListPage(batchName: "JEE12"))),)),
          Expanded(child: GestureDetector(child: category("NEET 11th"),onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>  WeekListPage(batchName: "NEET11"))),)),
          Expanded(child: GestureDetector(child: category("NEET 12th"),onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=> WeekListPage(batchName: "NEET12"))),)),
        
      ],
     )

    );
  }
}
