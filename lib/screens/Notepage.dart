import 'dart:io';
import 'package:campus_connect/main.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:campus_connect/constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart';

class Notes extends StatefulWidget {
  static const id='notes';
  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  bool showspinner=true;

  late String branch;
  late String sem;
  late Future<ListResult> futureFiles= FirebaseStorage.instance.ref('/notes/${branch}/${sem}').listAll();

  // void sharedpref() async{
  //
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     setState(() {
  //       sem = prefs.getString('sem')!;
  //       branch = prefs.getString('branch')!;
  //       print(branch);
  //       print(sem);
  //
  //     });
  //     showspinner=false;
  // }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    branch= branchpref.getDisplayName()!;
    sem= sempref.getDisplayName()!;
  }
  @override
  Widget build(BuildContext context) {
    Future downloadFile(Reference ref) async{
      // await ref.writeToFile(file);
      // final dir = await getApplicationDocumentsDirectory();
      // final file = File('${dir.path}/${ref.name}');
      // await ref.writeToFile(file);
      final url= await ref.getDownloadURL();
      final tempDir= await getTemporaryDirectory();
      final path= '${tempDir.path}/${ref.name}';
      final file= await Dio().download(url,path);
      final dir= await getApplicationDocumentsDirectory();
      final ffile= File('${dir.path}/${ref.name}');
      await ref.writeToFile(ffile);
      OpenFile.open(ffile.path);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Downloaded ${ref.name}'),)
      );

    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Resources',
        style: kreusablecardtextstyle.copyWith( color: Colors.black),),
        elevation: 0,
      ),
      body: SafeArea(
        child: FutureBuilder(
            future: futureFiles,
            builder: (context, AsyncSnapshot snapshot) {
          if(snapshot.hasData){
            final files =snapshot.data!.items;
            return ListView.builder(
                itemCount: files.length,
                itemBuilder: (context, index) {
              final file=files[index];
              return ListTile(
                title: Text(file.name),
                trailing: IconButton(
                  icon: const Icon(Icons.download, color: Colors.black,),
                  onPressed: () { downloadFile(file); },
                ),
              );
            });

          }else if(snapshot.hasError){
            return const Center(child: Text('Error Occurred'));
          }else{
            return const Center(child: CircularProgressIndicator(),);
          }
        }),
        ),
    );


  }
}
