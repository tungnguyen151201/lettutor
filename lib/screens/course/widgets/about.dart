import 'package:flutter/material.dart';
import 'package:lettutor/services/models/course.dart';

class AboutCourse extends StatelessWidget {
  AboutCourse({Key? key, required this.course}) : super(key: key);

  final Course course;
  final listLevels = {
    "0": "Any level",
    "1": "Beginner",
    "2": "High Beginner",
    "3": "Pre-Intermediate",
    "4": "Intermediate",
    "5": "Upper-Intermediate",
    "6": "Advanced",
    "7": "Proficiency"
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text(
              'Thông tin',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(
            course.description,
            style: const TextStyle(
              fontSize: 17,
              color: Colors.black54,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 0, top: 14),
            child: Text(
              'Tổng quan',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.help_outline,
                    color: Colors.red,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 70,
                    margin:
                        const EdgeInsets.only(left: 10, bottom: 10, top: 10),
                    child: const Text(
                      'Tại sao bạn nên học khóa học này?',
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.black,
                      ),
                    ),
                  )
                ],
              ),
              Text(
                course.reason,
                style: const TextStyle(
                  fontSize: 17,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.help_outline,
                    color: Colors.red,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 70,
                    margin:
                        const EdgeInsets.only(left: 10, bottom: 10, top: 10),
                    child: const Text(
                      'Bạn có thể làm gì?',
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.black,
                      ),
                    ),
                  )
                ],
              ),
              Text(
                course.purpose,
                style: const TextStyle(
                  fontSize: 17,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 8.0, top: 14),
            child: Text(
              'Trình độ',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(
            listLevels[course.level] ?? "Any level",
            style: const TextStyle(
              fontSize: 17,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
