import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../model/tasksModel.dart';
import '../repository/tasks_repository.dart';

final tasksControllerProvider=StateNotifierProvider((ref) {
  return TasksController(tasksRepository:ref.watch(tasksRepositoryProvider),ref:ref);
});

final getTasksStreamProvider=StreamProvider((ref) {
  final getRepoTasks=ref.watch(tasksControllerProvider.notifier);
  return getRepoTasks.getTasks();
});
class TasksController extends StateNotifier<bool>{
  final TasksRepository _tasksRepository;
  final Ref _ref;
  TasksController({required TasksRepository tasksRepository,required Ref ref, }):_tasksRepository=tasksRepository,_ref=ref,super (false);
  Stream<List<TasksModel>>getTasks(){
    return _tasksRepository.getTasks();
  }
  addTasks({required BuildContext  context,required TasksModel tasksModel}){
    _tasksRepository.addTasks(tasksModel: tasksModel);
  }
  updateTasks({required BuildContext  context,required TasksModel tasksModel}){
    _tasksRepository.updateTasks(tasksModel: tasksModel);
  }
  deleteTasks({required BuildContext  context,required TasksModel tasksModel}){
    _tasksRepository.deleteTasks(tasksModel: tasksModel);
  }
}