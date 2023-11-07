import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/global_constants.dart';
import '../../../main.dart';
import '../../../model/tasksModel.dart';
import '../controller/tasks_controller.dart';
import 'addNew.dart';
import 'editTasks.dart';

class TasksList extends ConsumerWidget {
  const TasksList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    width= MediaQuery.of(context).size.width;
    height= MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title:  Text("Tasks List",
          style: GoogleFonts.poppins(
            fontSize: width*.045,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: Padding(
        padding:  EdgeInsets.only(left: width*.03,right: width*.03),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Consumer(builder: (context, ref, child) {
                var data=ref.watch(getTasksStreamProvider);
                return data.when(data: (data){
                  return  data.isEmpty? Center(child:  Text('No Tasks Found',
                    style:  GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.black),),):ListView.builder(
                    shrinkWrap: true,

                    physics: const BouncingScrollPhysics(),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      TasksModel value=data[index];


                      return InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>EditTasks(data:value)));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                border: Border.all(color: Colors.grey,width: 1),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 3,
                                    blurRadius: 7,
                                    offset: Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              width: width,

                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width:width*.6,

                                          child: Text(value.title!,
                                            style:  GoogleFonts.poppins(
                                                fontWeight: FontWeight.bold,
                                                fontSize: width*.045,
                                                ),
                                          textAlign: TextAlign.left,),
                                        ),
                                        SizedBox(
                                          width:width*.6,
                                          child: Text(value.description!,
                                            style:  GoogleFonts.poppins(fontSize:width*.036,),
                                            textAlign: TextAlign.left,),

                                        ),
                                        SizedBox(
                                          width:width*.6,
                                          child: Text(DateFormat('dd-MM-yyyy hh:mm aaa').format(value.date!),
                                            style:  GoogleFonts.poppins(fontSize:width*.036,),
                                            textAlign: TextAlign.left,),

                                        ),

                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          onTap: (){
                                            showDialog(context: context, builder: (buildcontext) {
                                              return AlertDialog(
                                                title: Text('Delete',
                                                  style: GoogleFonts.outfit(color: primaryColor),
                                                    ),
                                                    content: Text('Do you want to delete this Task!',
                                                      style: GoogleFonts.outfit(),
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                          style: TextButton.styleFrom(elevation: 2, backgroundColor: primaryColor),
                                                          onPressed: () {
                                                            Navigator.pop(context);
                                                          },
                                                          child: Text('Cancel',
                                                            style: GoogleFonts.outfit(color: Colors.white),
                                                          )),
                                                      TextButton(
                                                          style: TextButton.styleFrom(
                                                              elevation: 2,
                                                              backgroundColor: primaryColor),
                                                          onPressed: () {
                                                            ref.read(tasksControllerProvider.notifier).deleteTasks(context: context, tasksModel: value);
                                                            Navigator.pop(context);
                                                          },
                                                          child: Text(
                                                            'Yes',
                                                            style: GoogleFonts.outfit(color: Colors.white),
                                                          )),
                                                    ],
                                                  );
                                                });
                                          },
                                            child: Icon(Icons.delete_outline,color: Colors.grey,size: width*.1,)),

                                        Text(value.status!,
                                          style:  GoogleFonts.poppins(fontSize:width*.036,
                                          color: value.status=='PENDING'?Colors.red.shade300:value.status=='IN PROGRESS'?Colors.orange.shade300:Colors.green.shade700),
                                          textAlign: TextAlign.right,),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                    },
                  );
                },
                    error: (Object error, StackTrace stackTrace) {

                return const Text('Something went wrong!');  },
                    loading: ()=>const Center(child: CircularProgressIndicator()));
              },),
            ),
            InkWell(
              onTap: (){

                Navigator.push(context, MaterialPageRoute(builder: (context)=>AddNew()));

              },
              child: Container(
                height: height*.075,
                width: width,
                decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(15)
                ),
                child:  Center(
                  child: Text("Add New Task",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: width*.045,
                      fontWeight: FontWeight.w500,
                    ),),
                ),

              ),
            ),

          ],
        ),
      ),
    );
  }
}

