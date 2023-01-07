import 'package:flutter/material.dart';
import 'package:lettutor/providers/app_provider.dart';
import 'package:lettutor/services/functions/user_functions.dart';
import 'package:lettutor/services/models/learning_topic.dart';
import 'package:lettutor/services/models/test_preparation.dart';
import 'package:provider/provider.dart';

class WantToLearn extends StatefulWidget {
  const WantToLearn({
    Key? key,
    required this.editTopics,
    this.userTopics,
    required this.editTestPreparations,
    this.userTestPreparations,
  }) : super(key: key);

  final List<LearnTopic>? userTopics;
  final Function(List<LearnTopic>) editTopics;

  final List<TestPreparation>? userTestPreparations;
  final Function(List<TestPreparation>) editTestPreparations;

  @override
  State<WantToLearn> createState() => _WantToLearnState();
}

class _WantToLearnState extends State<WantToLearn> {
  bool isLoading = true;
  List<LearnTopic>? allLearnTopics = [];
  List<TestPreparation>? allTestPreparations = [];
  void getAllTopicsAndTestPreparations() async {
    final topics = await UserFunctions.getAllLearningTopic();
    final preparations = await UserFunctions.getAllTestPreparation();
    if (mounted) {
      setState(() {
        allLearnTopics = topics;
        allTestPreparations = preparations;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    final lang = appProvider.language;

    if (mounted && isLoading) {
      getAllTopicsAndTestPreparations();
    }

    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            margin: const EdgeInsets.only(top: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: const Text(
                    'Subjects',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Wrap(
                    children: allLearnTopics!.map((topic) {
                      final selected =
                          widget.userTopics!.any((t) => t.id == topic.id);
                      if (selected) {
                        return GestureDetector(
                          onTap: () {
                            widget.editTopics(widget.userTopics!
                                .where((t) => t.id != topic.id)
                                .toList());
                          },
                          child: Container(
                            margin: const EdgeInsets.all(5),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(1000),
                              color: Colors.blue[100],
                            ),
                            child: Wrap(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Text(
                                    topic.name,
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.blue[900]),
                                  ),
                                ),
                                Icon(Icons.done_rounded,
                                    color: Colors.blue[900], size: 19),
                              ],
                            ),
                          ),
                        );
                      }
                      return GestureDetector(
                        onTap: () {
                          List<LearnTopic> newTopics = widget.userTopics ?? [];
                          newTopics.add(topic);
                          widget.editTopics(newTopics);
                        },
                        child: Container(
                          margin: const EdgeInsets.all(5),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(1000),
                            color: Colors.grey[200],
                          ),
                          child: Text(topic.name,
                              style: const TextStyle(fontSize: 15)),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 8, top: 10),
                  child: Text(
                    lang.testPreparation,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Wrap(
                    children: allTestPreparations!.map((topic) {
                      final selected = widget.userTestPreparations!
                          .any((t) => t.id == topic.id);
                      if (selected) {
                        return GestureDetector(
                          onTap: () {
                            widget.editTestPreparations(widget
                                .userTestPreparations!
                                .where((t) => t.id != topic.id)
                                .toList());
                          },
                          child: Container(
                            margin: const EdgeInsets.all(5),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(1000),
                              color: Colors.blue[100],
                            ),
                            child: Wrap(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Text(topic.name,
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.blue[900])),
                                ),
                                Icon(Icons.done_rounded,
                                    color: Colors.blue[900], size: 19),
                              ],
                            ),
                          ),
                        );
                      }
                      return GestureDetector(
                        onTap: () {
                          List<TestPreparation> newTestPreparations =
                              widget.userTestPreparations ?? [];
                          newTestPreparations.add(topic);
                          widget.editTestPreparations(newTestPreparations);
                        },
                        child: Container(
                          margin: const EdgeInsets.all(5),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(1000),
                            color: Colors.grey[200],
                          ),
                          child: Text(topic.name,
                              style: const TextStyle(fontSize: 15)),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          );
  }
}
