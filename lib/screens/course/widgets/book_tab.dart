import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lettutor/services/functions/course_functions.dart';
import 'package:lettutor/services/functions/ebook_functions.dart';
import 'package:lettutor/services/models/course_category.dart';
import 'package:lettutor/services/models/ebook.dart';
import 'package:url_launcher/url_launcher.dart';

class BookTab extends StatefulWidget {
  const BookTab({Key? key}) : super(key: key);

  @override
  State<BookTab> createState() => _BookTabState();
}

class _BookTabState extends State<BookTab> {
  List<Ebook> _results = [];
  final TextEditingController _controller = TextEditingController();
  final listLevels = {
    '0': 'Any level',
    '1': 'Beginner',
    '2': 'High Beginner',
    '3': 'Pre-Intermediate',
    '4': 'Intermediate',
    '5': 'Upper-Intermediate',
    '6': 'Advanced',
    '7': 'Proficiency'
  };
  Timer? _debounce;
  String category = '';
  String search = '';
  bool isLoading = true;
  bool isLoadingCategories = true;
  bool isLoadMore = false;
  int page = 1;
  int perPage = 10;
  late ScrollController _scrollController;
  List<CourseCategory> categories = [];

  void getCategories() async {
    final response = await CourseFunctions.getAllCourseCategories();
    if (mounted) {
      setState(() {
        categories = response!;
        isLoadingCategories = false;
      });
    }
  }

  List<Widget> _generateChips(List<CourseCategory> categories) {
    return categories
        .map(
          (chip) => GestureDetector(
            onTap: () {
              if (category == chip.id) {
                setState(() {
                  category = '';
                  _results = [];
                  page = 1;
                  isLoading = true;
                });
              } else {
                setState(() {
                  category = chip.id;
                  _results = [];
                  page = 1;
                  isLoading = true;
                });
              }
            },
            child: Container(
              margin: const EdgeInsets.only(top: 5, right: 8),
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              decoration: BoxDecoration(
                color: chip.id == category ? Colors.blue[50] : Colors.grey[200],
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                border: Border.all(
                    color: chip.id == category
                        ? Colors.blue[100] as Color
                        : Colors.grey[400] as Color),
              ),
              child: Text(
                chip.title,
                style: TextStyle(
                  fontSize: 12,
                  color:
                      chip.id == category ? Colors.blue[400] : Colors.grey[600],
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        )
        .toList();
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(loadMore);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _scrollController.removeListener(loadMore);
    super.dispose();
  }

  void getListEbook(int page, int size) async {
    final response = await EbookFunctions.getListEbookWithPagination(page, size,
        categoryId: category, q: search);
    if (mounted) {
      setState(() {
        _results.addAll(response!);
        isLoading = false;
      });
    }
  }

  void loadMore() async {
    if (_scrollController.position.extentAfter < page * perPage) {
      setState(() {
        isLoadMore = true;
        page++;
      });

      try {
        List<Ebook>? response = await EbookFunctions.getListEbookWithPagination(
            page, perPage,
            categoryId: category, q: search);
        if (mounted) {
          setState(() {
            _results.addAll(response!);
            isLoadMore = false;
          });
        }
      } catch (e) {
        const snackBar = SnackBar(
          content: Text('Không thể tải thêm nữa'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      getListEbook(1, 10);
    }
    if (isLoadingCategories) {
      getCategories();
    }

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 10, top: 10),
          child: TextField(
            style: TextStyle(fontSize: 12, color: Colors.grey[900]),
            controller: _controller,
            onChanged: (value) {
              if (_debounce?.isActive ?? false) _debounce?.cancel();
              _debounce = Timer(const Duration(milliseconds: 500), () {
                setState(() {
                  search = value;
                  _results = [];
                  page = 1;
                  isLoading = true;
                });
              });
            },
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade200,
                prefixIcon: Container(
                  padding: const EdgeInsets.all(13),
                  child: SvgPicture.asset(
                    'asset/svg/ic_search.svg',
                    color: Colors.grey[600],
                  ),
                ),
                contentPadding: const EdgeInsets.only(left: 5, right: 5),
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                hintText: 'Tìm kiếm giáo trình'),
          ),
        ),
        isLoadingCategories
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                height: 33,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _generateChips(categories).length,
                  itemBuilder: (context, index) {
                    return _generateChips(categories)[index];
                  },
                  shrinkWrap: true,
                ),
              ),
        isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Expanded(
                child: _results.isEmpty
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'asset/svg/ic_notfound.svg',
                                width: 200,
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 20),
                                child: Text(
                                  'Không tìm thấy giáo trình',
                                  style: TextStyle(color: Colors.grey[700]),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: _results.length,
                        controller: _scrollController,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: GestureDetector(
                              onTap: () async {
                                if (await canLaunchUrl(
                                    Uri.parse(_results[index].fileUrl))) {
                                  await launchUrl(
                                      Uri.parse(_results[index].fileUrl));
                                }
                              },
                              child: Card(
                                elevation: 8,
                                child: SizedBox(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl: _results[index].imageUrl,
                                        fit: BoxFit.cover,
                                        progressIndicatorBuilder: (context, url,
                                                downloadProgress) =>
                                            CircularProgressIndicator(
                                                value:
                                                    downloadProgress.progress),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 10, 10, 15),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              _results[index].name,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  top: 8, bottom: 15),
                                              child: Text(
                                                _results[index].description,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey[800]),
                                              ),
                                            ),
                                            Text(
                                              listLevels[
                                                      _results[index].level] ??
                                                  'Any level',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.grey[800]),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
        if (isLoadMore)
          const SizedBox(
            height: 50,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ],
    );
  }
}
