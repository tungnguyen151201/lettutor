import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lettutor/widgets/drop_down_button.dart';
import 'package:lettutor/widgets/future_builder.dart';
import 'package:lettutor/widgets/tutor_list_item.dart';
import 'package:lettutor/widgets/tutor_search_delegate.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _drawerSlideController;

  @override
  void initState() {
    super.initState();

    _drawerSlideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
  }

  @override
  void dispose() {
    _drawerSlideController.dispose();
    super.dispose();
  }

  bool _isDrawerOpen() {
    return _drawerSlideController.value == 1.0;
  }

  bool _isDrawerOpening() {
    return _drawerSlideController.status == AnimationStatus.forward;
  }

  bool _isDrawerClosed() {
    return _drawerSlideController.value == 0.0;
  }

  void _toggleDrawer() {
    if (_isDrawerOpen() || _isDrawerOpening()) {
      _drawerSlideController.reverse();
    } else {
      _drawerSlideController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          _buildContent(),
          _buildDrawer(),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text(
        'LetTutor',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      elevation: 0.0,
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
          onPressed: () {
            // method to show the search bar
            showSearch(
                context: context,
                // delegate to customize the search bar
                delegate: TutorSearchDelegate());
          },
          icon: const Icon(Icons.search),
        ),
        AnimatedBuilder(
          animation: _drawerSlideController,
          builder: (context, child) {
            return IconButton(
              onPressed: _toggleDrawer,
              icon: _isDrawerOpen() || _isDrawerOpening()
                  ? const Icon(
                      Icons.clear,
                      color: Colors.white,
                    )
                  : const Icon(
                      Icons.menu,
                      color: Colors.white,
                    ),
            );
          },
        ),
      ],
    );
  }

  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
    'Item5',
    'Item6',
    'Item7',
    'Item8',
  ];
  String? selectedValue;

  Widget _buildContent() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: CustomDropdownButton2(
                    hint: 'Select specialties',
                    dropdownItems: items,
                    value: selectedValue,
                    onChanged: (value) {
                      setState(() {
                        selectedValue = value;
                      });
                    }),
              ),
            ),
          ],
        ),
        Expanded(
          child: futureBuilder,
          // child: ListView(
          //   padding: const EdgeInsets.all(10.0),
          //   children: <Widget>[
          //     TutorListItem(
          //       avatar: Container(
          //         decoration: const BoxDecoration(color: Colors.pink),
          //       ),
          //       name: 'Keegan',
          //       bio:
          //           'I am passionate about running and fitness, I often compete in trail/mountain running events and I love pushing myself. I am training to one day take part in ultra-endurance events. I also enjoy watching rugby on the weekends, reading and watching podcasts on Youtube. My most memorable life experience would be living in and traveling around Southeast Asia.',
          //       specialties:
          //           'business-english,conversational-english,english-for-kids,ielts,toeic',
          //       rating: 4,
          //     ),
          //     TutorListItem(
          //       avatar: Container(
          //         decoration: const BoxDecoration(color: Colors.blue),
          //       ),
          //       name: 'Flutter 1.0 Launch',
          //       bio: 'Flutter continues to improve and expand its horizons. '
          //           'This text should max out at two lines and clip',
          //       specialties: 'Dash',
          //       rating: 5,
          //     ),
          //   ],
          // ),
        ),
      ],
    );
  }

  Widget _buildDrawer() {
    return AnimatedBuilder(
      animation: _drawerSlideController,
      builder: (context, child) {
        return FractionalTranslation(
          translation: Offset(1.0 - _drawerSlideController.value, 0.0),
          child: _isDrawerClosed() ? const SizedBox() : const Menu(),
        );
      },
    );
  }
}

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> with SingleTickerProviderStateMixin {
  static const _menuTitles = [
    'My Profile',
    'Mua buổi học',
    'Đổi mật khẩu',
    'Lịch học',
    'Lịch sử',
    'Khóa học',
    'Đăng ký làm gia sư',
    'Đăng xuất',
  ];

  static const _initialDelayTime = Duration(milliseconds: 50);
  static const _itemSlideTime = Duration(milliseconds: 250);
  static const _staggerTime = Duration(milliseconds: 50);
  static const _buttonDelayTime = Duration(milliseconds: 150);
  static const _buttonTime = Duration(milliseconds: 500);
  final _animationDuration = _initialDelayTime +
      (_staggerTime * _menuTitles.length) +
      _buttonDelayTime +
      _buttonTime;

  late AnimationController _staggeredController;
  final List<Interval> _itemSlideIntervals = [];
  late Interval _buttonInterval;

  @override
  void initState() {
    super.initState();

    _createAnimationIntervals();

    _staggeredController = AnimationController(
      vsync: this,
      duration: _animationDuration,
    )..forward();
  }

  void _createAnimationIntervals() {
    for (var i = 0; i < _menuTitles.length; ++i) {
      final startTime = _initialDelayTime + (_staggerTime * i);
      final endTime = startTime + _itemSlideTime;
      _itemSlideIntervals.add(
        Interval(
          startTime.inMilliseconds / _animationDuration.inMilliseconds,
          endTime.inMilliseconds / _animationDuration.inMilliseconds,
        ),
      );
    }

    final buttonStartTime =
        Duration(milliseconds: (_menuTitles.length * 50)) + _buttonDelayTime;
    final buttonEndTime = buttonStartTime + _buttonTime;
    _buttonInterval = Interval(
      buttonStartTime.inMilliseconds / _animationDuration.inMilliseconds,
      buttonEndTime.inMilliseconds / _animationDuration.inMilliseconds,
    );
  }

  @override
  void dispose() {
    _staggeredController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        fit: StackFit.expand,
        children: [
          _buildContent(),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 0),
        ..._buildListItems(),
      ],
    );
  }

  List<Widget> _buildListItems() {
    final listItems = <Widget>[];
    for (var i = 0; i < _menuTitles.length; ++i) {
      listItems.add(AnimatedBuilder(
        animation: _staggeredController,
        builder: (context, child) {
          final animationPercent = Curves.easeOut.transform(
            _itemSlideIntervals[i].transform(_staggeredController.value),
          );
          final opacity = animationPercent;
          final slideDistance = (1.0 - animationPercent) * 150;

          return Opacity(
            opacity: opacity,
            child: Transform.translate(
              offset: Offset(slideDistance, 0),
              child: child,
            ),
          );
        },
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('This is a snackbar')));
              },
              child: Text(
                _menuTitles[i],
                textAlign: TextAlign.left,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
            )),
      ));
    }
    return listItems;
  }
}
