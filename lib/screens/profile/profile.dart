import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lettutor/screens/profile/widgets/avatar.dart';
import 'package:lettutor/screens/profile/widgets/birthday.dart';
import 'package:lettutor/screens/profile/widgets/button.dart';
import 'package:lettutor/screens/profile/widgets/textfield.dart';
import 'package:lettutor/screens/profile/widgets/want_to_learn.dart';
import 'package:lettutor/services/functions/user_functions.dart';
import 'package:lettutor/services/models/learning_topic.dart';
import 'package:lettutor/services/models/test_preparation.dart';
import 'package:lettutor/services/models/user_info.dart';
import 'package:lettutor/services/settings/countries_list.dart';
import 'package:lettutor/services/settings/level_list.dart';
import 'package:lettutor/utils/get_key.dart';
import 'package:lettutor/widgets/drop_down_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? avatar;
  String? name;
  String? email;
  String? phone;
  String? country;
  String? level;
  DateTime? birthday;
  String? studySchedule;
  bool isPhoneActivated = false;
  List<LearnTopic>? topics;
  List<TestPreparation>? preparations;
  bool isLoading = true;

  final ImagePicker picker = ImagePicker();

  void getUserProfile() async {
    UserInfo? user = await UserFunctions.getUserInformation();
    if (mounted) {
      setState(() {
        isLoading = false;
        avatar = user?.avatar;
        name = user?.name;
        email = user?.email;
        phone = user?.phone;
        isPhoneActivated = user?.isPhoneActivated ?? false;
        country = countryList[user?.country];
        level = levelList[user?.level];
        birthday = DateFormat("yyyy-MM-dd")
            .parse(user?.birthday ?? DateTime.now().toString());
        studySchedule = user?.studySchedule;
        topics = user?.learnTopics;
        preparations = user?.testPreparations;
      });
    }
  }

  editTopics(List<LearnTopic> topics) {
    setState(() {
      this.topics = topics;
    });
  }

  editTests(List<TestPreparation> preparations) {
    setState(() {
      this.preparations = preparations;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (mounted && isLoading) {
      getUserProfile();
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Thông tin cá nhân')),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              physics: const BouncingScrollPhysics(),
              children: [
                AvatarProfile(
                  imagePath: avatar ?? '',
                  isEdit: true,
                  onClicked: () async {
                    var pickedFile = await picker.pickImage(
                        source: ImageSource.gallery, imageQuality: 50);

                    if (pickedFile != null) {
                      final bool res =
                          await UserFunctions.uploadAvatar(pickedFile.path);
                      if (res) {
                        final newUserInfo =
                            await UserFunctions.getUserInformation();
                        setState(() {
                          avatar = newUserInfo!.avatar;
                        });
                      } else if (mounted) {
                        const snackBar = SnackBar(
                          content: Text('Cập nhật avatar thất bại'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    }
                  },
                ),
                const SizedBox(height: 24),
                TextFieldWidget(
                  label: 'Tên',
                  text: name,
                  onChanged: (value) {
                    setState(() {
                      name = value;
                    });
                  },
                ),
                const SizedBox(height: 24),
                TextFieldWidget(
                  label: 'Địa chỉ email',
                  text: email,
                  enabled: false,
                ),
                const SizedBox(height: 24),
                const Text(
                  'Quốc gia',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                CustomDropdownButton2(
                  hint: 'Chọn quốc gia',
                  value: country,
                  dropdownItems: countryList.values.toList(),
                  onChanged: (value) {
                    setState(() {
                      country = value;
                    });
                  },
                ),
                const SizedBox(height: 24),
                TextFieldWidget(
                  label: 'Số điện thoại',
                  text: phone,
                  enabled: false,
                ),
                !isPhoneActivated
                    ? Container()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(3),
                            margin: const EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.green, width: 1),
                                color: Colors.green[50],
                                borderRadius: BorderRadius.circular(4)),
                            child: const Text(
                              'Đã xác thực',
                              style:
                                  TextStyle(fontSize: 13, color: Colors.green),
                            ),
                          ),
                        ],
                      ),
                const SizedBox(height: 24),
                const Text(
                  'Ngày sinh',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                BirthdayEdition(
                    setBirthday: (({DateTime? birthday}) => setState(
                          () => this.birthday = birthday,
                        )),
                    birthday: birthday),
                const SizedBox(height: 24),
                const Text(
                  'Trình độ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                CustomDropdownButton2(
                  hint: 'Chọn trình độ',
                  value: level,
                  dropdownItems: levelList.values.toList(),
                  onChanged: (value) {
                    setState(() {
                      level = value;
                    });
                  },
                ),
                WantToLearn(
                    userTopics: topics,
                    editTopics: editTopics,
                    userTestPreparations: preparations,
                    editTestPreparations: editTests),
                const SizedBox(height: 24),
                TextFieldWidget(
                  label: 'Lịch học',
                  hintText:
                      'Ghi chú thời gian trong tuần mà bạn muốn học trên LetTutor',
                  maxLines: 5,
                  text: studySchedule,
                  onChanged: (value) {
                    setState(() {
                      studySchedule = value;
                    });
                  },
                ),
                const SizedBox(height: 24),
                ButtonWidget(
                  text: 'Lưu thay đổi',
                  onClicked: () async {
                    if (name == null || name == '') {
                      const snackBar = SnackBar(
                        content: Text('Tên không hợp lệ'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else if (country == null || country == '') {
                      const snackBar = SnackBar(
                        content: Text('Quốc gia không hợp lệ'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else if (birthday == null ||
                        birthday!.millisecondsSinceEpoch >
                            DateTime.now().millisecondsSinceEpoch) {
                      const snackBar = SnackBar(
                        content: Text('Ngày sinh không hợp lệ'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else if (level == null || level == '') {
                      const snackBar = SnackBar(
                        content: Text('Trình độ không hợp lệ'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      String bdArg =
                          "${birthday!.year.toString()}-${birthday!.month.toString().padLeft(2, "0")}-${birthday!.day..toString().padLeft(2, "0")}";

                      final res = await UserFunctions.updateUserInformation(
                        name!,
                        getKey(countryList, country),
                        bdArg,
                        getKey(levelList, level),
                        studySchedule ?? '',
                        topics?.map((e) => e.id.toString()).toList(),
                        preparations?.map((e) => e.id.toString()).toList(),
                      );
                      if (res != null && mounted) {
                        const snackBar =
                            SnackBar(content: Text('Cập nhật thành công'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else {
                        const snackBar =
                            SnackBar(content: Text('Cập nhật thất bại'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    }
                  },
                ),
              ],
            ),
    );
  }
}
