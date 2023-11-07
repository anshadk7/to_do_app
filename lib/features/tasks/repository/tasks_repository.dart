

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../../../core/constants/firebase_constants.dart';
import '../../../core/failure.dart';
import '../../../core/providers/firebase_providers.dart';
import '../../../model/tasksModel.dart';
final tasksRepositoryProvider=Provider((ref) => TasksRepository(firestore:ref.watch(fireStoreProvider)));
class TasksRepository{
late final FirebaseFirestore _firestore;
TasksRepository({required FirebaseFirestore firestore}):
      _firestore=firestore;
CollectionReference get _tasks=>_firestore.collection(FirebaseConstants.tasks);

Stream<List<TasksModel>>getTasks(){
  return _tasks.orderBy('date',descending: true).snapshots().map((snapshot) => snapshot.docs.map((doc) => TasksModel.fromJson(doc.data() as Map<String, dynamic>)).toList());
}
addTasks({required TasksModel tasksModel}){
  try{
    return right(
        _tasks.add(tasksModel.toJson()).then((value) {
          value.update({
            'id':value.id
          });
        })
    );

  }on FirebaseException catch(e){
    throw e.message!;
  }catch(e){
    return left(Failure(e.toString()));
  }

}

updateTasks({required TasksModel tasksModel}){
  try{
    return right(
        _tasks.doc(tasksModel.id).update(tasksModel.toJson())

    );

  }on FirebaseException catch(e){
    throw e.message!;
  }catch(e){
    return left(Failure(e.toString()));
  }

}
deleteTasks({required TasksModel tasksModel}){
  try{
    return right(
        _tasks.doc(tasksModel.id).delete()

    );

  }on FirebaseException catch(e){
    throw e.message!;
  }catch(e){
    return left(Failure(e.toString()));
  }

}
}