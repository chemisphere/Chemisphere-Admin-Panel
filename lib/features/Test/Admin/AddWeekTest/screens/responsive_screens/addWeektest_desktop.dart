

import 'package:education_web_admin_panel/features/Test/services/database.dart';
import 'package:flutter/material.dart';

class AddWeekTest_desktop extends StatefulWidget {
  final String batchName;

  AddWeekTest_desktop({required this.batchName});

  @override
  _AddWeekTest_desktopState createState() => _AddWeekTest_desktopState();
}

class _AddWeekTest_desktopState extends State<AddWeekTest_desktop> {
  final DatabaseService _databaseService = DatabaseService();
  final _formKey = GlobalKey<FormState>();

  String? weekNumber;
  String? topic;
  String? description;
  int? duration;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Create Week'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Week Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a week number';
                  }
                  return null;
                },
                onSaved: (value) => weekNumber = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Topic'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a topic';
                  }
                  return null;
                },
                onSaved: (value) => topic = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
                onSaved: (value) => description = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Duration'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a duration';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid integer duration';
                  }
                  return null;
                },
                onSaved: (value) => duration = int.parse(value!),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20,),
              SizedBox(
                width: 350,
                child: ElevatedButton(
                  onPressed: _createWeek,
                  
                  child: Text('Create Week'),
                ),
              ),
            ],
          ),
        ),
      ),
    
    );
  }

  void _createWeek() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      await _databaseService.createWeek(
          widget.batchName, weekNumber!, topic!, description!, duration!);
      Navigator.pop(context);
    }
  }
}
