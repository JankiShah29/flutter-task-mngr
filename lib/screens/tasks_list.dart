import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:interview_test/models/task_model.dart';
import 'package:interview_test/screens/create_task.dart';
import 'package:interview_test/services/task_db_service.dart';

enum TaskStatus { pending, completed }

class TasksList extends StatefulWidget {
  const TasksList({super.key});

  @override
  State<TasksList> createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  List<TaskModel> tasks = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    setState(() {
      isLoading = true;
    });

    try {
      final tasksList = await TaskDbService().fetchTasks();
      setState(() {
        tasks = tasksList;
      });
    } catch (e) {
      print('Error loading tasks: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          tasks.isEmpty
              ? Center(
                  child: Text(
                    isLoading ? '' : 'No tasks found.',
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                  ),
                )
              : ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 6,
                      ),

                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),

                      decoration: BoxDecoration(
                        color: tasks[index].status == TaskStatus.completed.name
                            ? Colors.green.shade50
                            : Colors.yellow.shade50,

                        borderRadius: BorderRadius.circular(18),

                        border: Border.all(
                          color:
                              tasks[index].status == TaskStatus.completed.name
                              ? Colors.green.shade200
                              : Colors.yellow.shade300,
                        ),
                      ),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  tasks[index].title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.15,
                                    color: Colors.black87,
                                    height: 1.25,
                                  ),
                                ),
                              ),

                              const SizedBox(width: 12),

                              Text(
                                DateFormat(
                                  'dd-MM-yyyy',
                                ).format(tasks[index].date),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade700,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 5),

                          Text(
                            tasks[index].desc,
                            style: TextStyle(
                              fontSize: 14,
                              height: 1.6,
                              color: Colors.grey.shade800,
                            ),
                          ),

                          const SizedBox(height: 5),

                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 7,
                                ),

                                decoration: BoxDecoration(
                                  color:
                                      tasks[index].status ==
                                          TaskStatus.completed.name
                                      ? Colors.green.shade100
                                      : Colors.orange.shade100,
                                  borderRadius: BorderRadius.circular(30),
                                ),

                                child: Text(
                                  tasks[index].status ==
                                          TaskStatus.completed.name
                                      ? 'Completed'
                                      : 'Pending',

                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color:
                                        tasks[index].status ==
                                            TaskStatus.completed.name
                                        ? Colors.green.shade800
                                        : Colors.orange.shade800,
                                  ),
                                ),
                              ),

                              const Spacer(),

                              PopupMenuButton(
                                icon: const Icon(Icons.more_vert),
                                itemBuilder: (context) => [
                                  const PopupMenuItem(
                                    value: 'edit',
                                    child: Text('Edit'),
                                  ),

                                  PopupMenuItem(
                                    value: 'done',
                                    child: Text(
                                      tasks[index].status ==
                                              TaskStatus.completed.name
                                          ? 'Mark as Pending'
                                          : 'Mark as Done',
                                    ),
                                  ),

                                  const PopupMenuItem(
                                    value: 'delete',
                                    child: Text('Delete'),
                                  ),
                                ],

                                onSelected: (value) {
                                  if (value == 'edit') {}
                                  if (value == 'done') {
                                    var status = tasks[index].status;
                                    if (status == TaskStatus.completed.name) {
                                      status = TaskStatus.pending.name;
                                    } else {
                                      status = TaskStatus.completed.name;
                                    }
                                    updateStatus(tasks[index].docId, status);
                                  }
                                  if (value == 'delete') {
                                    removeTask(tasks[index].docId);
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),

          if (isLoading)
            Positioned.fill(
              child: Container(
                color: Colors.grey.shade300.withOpacity(0.4),
                child: Center(child: CircularProgressIndicator()),
              ),
            ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          TaskModel taskObj = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateTask()),
          );

          setState(() {
            tasks.insert(0, taskObj);
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> updateStatus(String docId, String status) async {
    setState(() {
      isLoading = true;
    });

    try {
      final resultFlag = await TaskDbService().updateStatus(docId, status);

      if (resultFlag) {
        final index = tasks.indexWhere((task) => task.docId == docId);
        setState(() {
          tasks[index].status = status.toString();
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Status updated successfully'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error occurred while updating ..'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      print('error $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> removeTask(String docId) async {
    setState(() {
      isLoading = true;
    });

    try {
      final resultFlag = await TaskDbService().deleteTask(docId);

      if (resultFlag) {
        final index = tasks.indexWhere((task) => task.docId == docId);
        setState(() {
          tasks.removeAt(index);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Task deleted successfully'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error occurred while deletion'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      print('error $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
