
import 'package:education_web_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:education_web_admin_panel/common/widgets/layouts/templates/site_layout.dart';
import 'package:education_web_admin_panel/features/Test/Admin/AddWeekTest/screens/CreateWeekPage.dart';
import 'package:education_web_admin_panel/features/Test/Admin/addQuestion_to_sections/screens/chooseSection.dart';
import 'package:education_web_admin_panel/features/Test/Admin/models/Week.dart';
import 'package:education_web_admin_panel/features/Test/services/database.dart';
import 'package:flutter/material.dart';

class CreateWeekList_desktop extends StatefulWidget {
  String batchName;
   CreateWeekList_desktop({super.key,required this.batchName});


  @override
  _CreateWeekList_desktopState createState() => _CreateWeekList_desktopState();
}
class _CreateWeekList_desktopState extends State<CreateWeekList_desktop> {
  final DatabaseService _databaseService = DatabaseService();
  Future<List<Week>>? weeksFuture;

  @override
  void initState() {
    super.initState();
    weeksFuture = _databaseService.getWeeks(widget.batchName);
  }

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      appBar: AppBar(
        title: Text('List of Tests'),
      ),
      body: FutureBuilder<List<Week>>(
        key: Key('weeks_future_builder'),
        future: weeksFuture,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Text('Loading....');
            default:
              if (snapshot.data != null) {
                return Column(
                  children: [
                    SizedBox(height: 20,),
                    Text("Note: After Adding new test refresh for getting it on the Below list "),
                    SizedBox(height: 20,),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        Week week = snapshot.data![index];
                        
                        return Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: TRoundedContainer(
                             onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddsectionPage(
                                    batchName: widget.batchName,
                                    weekNumber: week.weekNumber,
                                  ),
                                ),
                              );
                            },
                            height: 50,
                            width: double.infinity,
                            showBorder: true,
                            borderColor: Colors.black,
                            child:Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text("Week:${week.weekNumber.toString()}"),
                                Text("Topic:${week.topic.toString()}"),
                                Text("duration:${week.duration.toString()}"),
                              ],
                            )
                          ),
                        );
                      },
                    ),
                  ],
                );
              } else {
                return Text('No weeks found');
              }
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateWeekPage(
                batchName: widget.batchName,
              ),
            ),
          );
        },
        tooltip: 'Create Week',
        child: Icon(Icons.add),
      ),
    
    );
  }
}