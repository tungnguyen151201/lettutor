abstract class Language {
  late String name;
  // Login Page
  get email;
  get password;
  get signUpQuestion;
  get signUp;
  get signIn;
  get forgotPassword;
  get continueWith;
  get invalidEmail;
  get emptyField;
  get forgotPasswordFail;
  get forgotPasswordSuccess;

  // Sign Up Page
  get passwordTooShort;
  get confirmPassword;
  get loginQuestion;
  get errPasswordMismatch;
  get registerSuccess;

  // Reset Password Page
  get resetPassword;
  get emptyEmail;
  get confirm;

  // Home Page
  get home;
  get totalLessonTime;
  get enterRoom;
  get recommendTutor;
  get seeAll;
  get welcome;
  get nextLesson;
  get bookAlesson;
  get menuTitles;
  get hour;
  get minute;

  // Profile page
  get profile;
  get fullName;
  get birthday;
  get phone;
  get country;
  get selectCountry;
  get level;
  get selectLevel;
  get wantToLearn;
  get save;
  get errGetNewProfile;
  get errUploadAvatar;
  get successUploadAvatar;
  get errUpdateProfile;
  get successUpdateProfile;
  get errPhoneNumber;
  get errEnterName;
  get errCountry;
  get errLevel;
  get errBirthday;
  get verified;
  get schedule;
  get studySchedule;
  get testPreparation;

  // Course page
  get course;
  get searchCourse;
  get lesson;
  get errNotAnyResult;
  // Course Detail
  get aboutCourse;
  get overview;
  get why;
  get what;
  get topic;
  get tutor;

  // Ebook tab
  get ebook;
  get searchEbook;

  // Upcoming Page
  get upcoming;
  get cancel;
  get goToMeeting;
  get dontHaveUpcoming;
  get removeUpcomingSuccess;
  get removeUpcomingFail;

  // Tutor search page and Tutor detail page
  get tutors;
  get searchTutor;
  get booking;
  get languages;
  get interests;
  get specialties;
  get selectSpecialties;
  get rateAndComment;
  get selectSchedule;
  get selectScheduleDetail;
  get bookingSuccess;

  // Setting page
  get setting;
  get changePassword;
  get sessionHistory;
  get advancedSetting;
  get theme;
  get light;
  get dark;
  get logout;

  // Change password page
  get newPassword;
  get confirmNewPassword;
  get passwordAtLeast;
  get changePasswordSuccess;

  // Session history page
  get giveFeedback;
  get watchRecord;
  get mark;
  get tutorNotMark;
  get emptySession;

  // Feedback page
  get feedback;
  get hintFeedback;
  get errEnterFeedback;
  get errFeedbackLength;
  get successFeedback;
}
