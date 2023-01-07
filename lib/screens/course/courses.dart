import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lettutor/providers/app_provider.dart';
import 'package:lettutor/screens/course/widgets/book_tab.dart';
import 'package:lettutor/screens/course/widgets/course_tab.dart';
import 'package:provider/provider.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({super.key});

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    final lang = appProvider.language;

    return Scaffold(
      appBar: AppBar(title: Text(lang.course)),
      body: DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Container(
          margin: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            children: <Widget>[
              TabBar(
                tabs: <Widget>[
                  Tab(
                    icon: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 5),
                          child: SvgPicture.asset(
                            "asset/svg/ic_course.svg",
                            width: 20,
                            color: Colors.grey[700],
                          ),
                        ),
                        Text(
                          lang.course,
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ],
                    ),
                  ),
                  Tab(
                    icon: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 5),
                          child: SvgPicture.asset(
                            "asset/svg/ic_books.svg",
                            width: 20,
                            color: Colors.grey[700],
                          ),
                        ),
                        Text(
                          lang.ebook,
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Expanded(
                child: TabBarView(
                  children: [
                    CourseTab(),
                    BookTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
