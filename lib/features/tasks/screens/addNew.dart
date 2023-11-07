import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app/main.dart';
import '../../../core/constants/global_constants.dart';
import '../../../model/tasksModel.dart';
import '../controller/tasks_controller.dart';

class AddNew extends ConsumerStatefulWidget {
  const AddNew({Key? key}) : super(key: key);

  @override
  ConsumerState<AddNew> createState() => _AddNewState();
}

class _AddNewState extends ConsumerState<AddNew> {
  TextEditingController title=TextEditingController();
  TextEditingController description=TextEditingController();

  var status;
  var statusList = ['PENDING', 'IN PROGRESS', 'COMPLETED',];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("Add New",
          style: GoogleFonts.poppins(
            fontSize: width*.045,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),


      body: Padding(
        padding:  EdgeInsets.only(left: width*.04,right: width*.04),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            SizedBox(height: height*.25,),
            Container(
                height: height*.075,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  controller: title ,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.sentences,
                  style: GoogleFonts.outfit(color: Colors.grey,fontSize: 14),
                  decoration:  InputDecoration(
                      hintText: 'Title',
                      //labelText: 'Vehicle Number',
                      contentPadding:  const EdgeInsets.only(left: 10,bottom: 10),
                      hintStyle: GoogleFonts.outfit(
                          color: Colors.grey,fontSize: 14,fontWeight: FontWeight.w500),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none
                  ),)

            ),
            SizedBox(height: height*.02,),

            Container(
                height: height*.15,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(10),

                ),
                child: TextFormField(
                  controller: description ,
                  minLines: 5,
                  maxLines: 10,
                  keyboardType: TextInputType.multiline,
                  textCapitalization: TextCapitalization.sentences,
                  style: GoogleFonts.outfit(color: Colors.grey,fontSize: 14),
                  decoration:  InputDecoration(
                      hintText: 'Description',
                      contentPadding:  const EdgeInsets.only(bottom: 5,left: 10),
                      hintStyle: GoogleFonts.outfit(
                          color: Colors.grey,fontSize: 14,fontWeight: FontWeight.w500),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none
                  ),)

            ),
            SizedBox(height: height*.02,),

            Container(
                height: height*.075,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(10),

                ),
                child:Padding(
                  padding:  EdgeInsets.only(left:  height*.02, right:  height*.02),
                  child: DropdownButton(
                    style: GoogleFonts.outfit(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    underline: Container(),
                    hint: Text('Choose Status',
                        style: GoogleFonts.outfit(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color:  Colors.grey,
                        )),
                    value: status,
                    dropdownColor: Colors.white,
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.black,
                      size: 20,
                    ),
                    iconDisabledColor:  Colors.grey,
                    items: statusList.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(
                          items,
                          style: GoogleFonts.outfit(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color:  Colors.grey,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (var newValue) {
                      setState(() {
                        status = newValue;
                      });
                    },
                    isExpanded: true,
                  ),
                )

            ),

            SizedBox(height:  height*.05,),

            InkWell(
              onTap: (){
                if(title.text.trim()!=''&&description.text.trim()!=''&&status!=null){
                  final tasks=TasksModel(
                    title:title.text.trim(),
                    status:status,
                    description:description.text.trim(),
                    date:DateTime.now(),
                  );

                  addTasks(context,tasks);
                }
                else{
                  title.text.trim()==''?showUploadMessage(context,'Please enter the title'):
                  description.text.trim()==''?showUploadMessage(context,'Please enter the description'):
                  showUploadMessage(context,'Please choose the status');
                }


              },
              child: Container(
                height:  height*.075,
                width: width*.3,
                decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(15)
                ),
                child:  Center(
                  child: Text("Add",
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
  addTasks(BuildContext context,TasksModel tasksData) {

   ref.read(tasksControllerProvider.notifier).addTasks(context: context, tasksModel: tasksData);
   Navigator.pop(context);

  }
}
