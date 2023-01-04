import 'package:flutter/material.dart';
import 'package:lettutor/screens/course/widgets/about.dart';
import 'package:lettutor/screens/course/widgets/banner.dart';
import 'package:lettutor/screens/course/widgets/topic.dart';
import 'package:lettutor/services/functions/course_functions.dart';
import 'package:lettutor/services/models/course.dart';

class CourseDetailScreen extends StatefulWidget {
  const CourseDetailScreen({super.key, required this.courseId});
  final String courseId;
  @override
  State<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {
  Course? course;
  bool isLoading = true;

  void getCourse() async {
    final course = await CourseFunctions.getCourseById(widget.courseId);
    setState(() {
      this.course = course;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      getCourse();
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  BannerCourse(course: course as Course),
                  AboutCourse(course: course as Course),
                  TopicCourse(course: course as Course),
                ],
              ),
            ),
    );
  }
}
