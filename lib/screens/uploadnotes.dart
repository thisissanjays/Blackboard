import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:campus_connect/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

final _firestore =FirebaseFirestore.instance;
late User loggedinUser;
class UploadNotes extends StatefulWidget {
  static const id= 'uploadnotes';
  const UploadNotes({Key? key}) : super(key: key);

  @override
  State<UploadNotes> createState() => _UploadNotesState();
}

class _UploadNotesState extends State<UploadNotes> {
  late String dropdownBranch='Computer Science';
  late String dropdownSem= 'S1';
  PlatformFile? file;
  UploadTask? uploadTask;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Notes',
        style: kreusablecardtextstyle.copyWith( color: Colors.black),),
        elevation: 0,
        actions: [
          MaterialButton(
            onPressed: () async {
              final pickedfile= File(file!.path!);
              final path= 'notes/${dropdownBranch}/${dropdownSem}/${file!.name}';
              final ref= FirebaseStorage.instance.ref().child(path);
              ref.putFile(pickedfile);
              final snapshot= await uploadTask!.whenComplete(() => null);
              final urlDownload= await snapshot.ref.getDownloadURL();
              Navigator.pop(context);
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 2, horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                'Upload',
                style: kreusablecardtextstyle.copyWith(fontSize: 18),
              ),
            ),
          ),

        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              widthbox,
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Choose Branch',
                  style: kreusablecardtextstyle.copyWith(color: Colors.black),
                ),
              ),
              widthbox,
              Container(
                alignment: Alignment.center,
                child: DropdownButton<String>(
                  value: dropdownBranch,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 5,
                  style: kreusablecardtextstyle.copyWith(
                      color: Colors.black, fontSize: 17),
                  underline: Container(
                    height: 1,
                    color: Colors.red,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownBranch = newValue!;
                    });
                  },
                  items: <String>['Computer Science', 'Electronics', 'Electrical', 'Bio-Medical', 'Mechanical']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              widthbox,
              widthbox,
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Choose Semester',
                  style: kreusablecardtextstyle.copyWith(color: Colors.black),
                ),
              ),
              DropdownButton<String>(
                value: dropdownSem,
                icon: const Icon(Icons.arrow_downward),
                elevation: 5,
                style: kreusablecardtextstyle.copyWith(
                    color: Colors.black, fontSize: 17),
                underline: Container(
                  height: 1,
                  color: Colors.red,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownSem = newValue!;
                  });
                },
                items: <String>['S1', 'S2', 'S3', 'S4','S5','S6','S7','S8']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              widthbox,
              widthbox,
              TextButton(
                  onPressed: () async {
                    FilePickerResult? result = await FilePicker.platform.pickFiles();

                    if (result != null) {
                      setState(() {
                        file = result.files.first;
                      });

                    } else {return;
                      // User canceled the picker
                    }
                  },
                  child:Container(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      'Choose File',
                      style: kreusablecardtextstyle.copyWith(fontSize: 18),
                    ),
                  ),
              ),
              Container(
                child: (file!=null)?Text(file!.name): null,
              )

            ],
          ),
        ),

      ),
    );
  }
}
