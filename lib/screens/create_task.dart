import 'package:flutter/material.dart';
import 'package:interview_test/models/task_model.dart';
import 'package:interview_test/screens/tasks_list.dart';
import 'package:interview_test/services/task_db_service.dart';
import 'package:interview_test/widgets/primary_button.dart';

class CreateTask extends StatefulWidget {
  const CreateTask({super.key});

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  DateTime _today_date = DateTime.now();
  DateTime? _current_date = DateTime.now();
  TextEditingController dateController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    dateController.text = formatDate(_current_date!);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8.0),

            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: showDatePickerFunction,
                child: SizedBox(
                  width: 200,
                  child: TextField(
                    controller: dateController,
                    readOnly: true,
                    enabled: false,
                    decoration: InputDecoration(
                      labelText: 'Date',
                      hintText: formatDate(_current_date!),
                      hintStyle: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 12.0),

            Form(
              key: _formKey,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Title',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.0),

                  TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFF3F4F6),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Please enter a title'
                        : null,
                  ),

                  SizedBox(height: 16.0),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.0),

                  TextFormField(
                    maxLines: 4,
                    controller: descriptionController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFF3F4F6),
                      prefixIcon: const Icon(
                        Icons.subject_outlined,
                        color: Colors.grey,
                      ),

                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value == '') {
                        return 'Please enter description';
                      } else if (value.trim().length > 150) {
                        return 'Character exceeds by ${value.trim().length - 150}';
                      }
                    },
                  ),

                  SizedBox(height: 48.0),

                  PrimaryButton(buttonText: 'Create Task', onPressed: _addTask),
                  SizedBox(height: 14.0),

                  isLoading
                      ? Center(
                          child: CircularProgressIndicator(color: Colors.grey),
                        )
                      : SizedBox.shrink(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  Future<void> showDatePickerFunction() async {
    _current_date = await showDatePicker(
      context: context,
      initialDate: _current_date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (_current_date != null) {
      dateController.text =
          "${_current_date?.day}/${_current_date?.month}/${_current_date?.year}";
    }
  }

  Future<void> _addTask() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      try {
        var date = _current_date ?? _today_date;
        final result = await TaskDbService().createTask(
          title: titleController.text,
          description: descriptionController.text,
          status: TaskStatus.pending.name,
          date: date,
          onSuccess: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Task created successfully'),
                backgroundColor: Colors.green,
              ),
            );
          },
        );

        getTaskById(result);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error creating task: $e'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<TaskModel?> getTaskById(String docId) async {
    setState(() {
      isLoading = true;
    });

    try {
      final taskObj = await TaskDbService().getTaskById(docId);
      if (taskObj != null) {
        Navigator.pop(context, taskObj);
      } else {
        Navigator.pop(context, null);
      }
    } catch (e) {
      print('something went wrong');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
