import 'package:lettutor/services/models/language.dart';

class English extends Language {
  English() {
    name = "EN";
  }
  // Login Page
  @override
  get email => "Email";
  @override
  get password => "Password";
  @override
  get signUpQuestion => "Not a member yet?";
  @override
  get signUp => "Sign Up";
  @override
  get signIn => "Sign In";
  @override
  get forgotPassword => "Forgot password?";
  @override
  get continueWith => "Or continue with";
  @override
  get invalidEmail => "Invalid Email";
  @override
  get emptyField => "Please fill in all fields";
  @override
  get forgotPasswordFail => "Reset password failed";
  @override
  get forgotPasswordSuccess =>
      "Reset password success, please check your email";

  // Sign Up Page
  @override
  get passwordTooShort => "Password must be at least 6 characters";
  @override
  get confirmPassword => "Re-enter password";
  @override
  get loginQuestion => "Already have a account?";
  @override
  get errPasswordMismatch => "Passwords do not match";
  @override
  get registerSuccess =>
      "Register successfully, check your email to activate your account";

  // Reset Password Page
  @override
  get resetPassword => "Reset Password";
  @override
  get emptyEmail => "Please enter email.";
  @override
  get confirm => "Confirm";

  // Home Page
  @override
  get home => "Home";
  @override
  get totalLessonTime => "Total lesson time is ";
  @override
  get enterRoom => "Enter lesson room";
  @override
  get recommendTutor => "Recommend Tutors";
  @override
  get seeAll => "See all";
  @override
  get welcome => "Wellcome to LetTutor";
  @override
  get nextLesson => "Upcoming lesson";
  @override
  get bookAlesson => "Book a lesson";
  @override
  get menuTitles => [
        'Profile',
        'Schedule',
        'History',
        'Course',
        'Setting',
        'Sign out',
      ];
  @override
  get hour => "hour";
  @override
  get minute => "minute";

  // Profile page
  @override
  get profile => "Profile";
  @override
  get fullName => "Name";
  @override
  get birthday => "Birthday";
  @override
  get phone => "Phone";
  @override
  get country => "Country";
  @override
  get selectCountry => "Select country";
  @override
  get level => "Level";
  @override
  get selectLevel => "Select level";
  @override
  get wantToLearn => "Want to learn";
  @override
  get save => "Save";
  @override
  get errGetNewProfile => "Can't get new profile";
  @override
  get errUploadAvatar => "Upload avatar failed";
  @override
  get successUploadAvatar => "Upload avatar success";
  @override
  get errUpdateProfile => "Update profile failed";
  @override
  get successUpdateProfile => "Update profile success";
  @override
  get errPhoneNumber => "Invalid phone number";
  @override
  get errEnterName => "Please enter your name";
  @override
  get errCountry => "Please select country";
  @override
  get errLevel => "Please select level";
  @override
  get errBirthday => "Birthday is invalid";
  @override
  get verified => "Verified";
  @override
  get schedule => "Schedule";
  @override
  get studySchedule =>
      "Note the time of the week you want to study on LetTutor";
  @override
  get testPreparation => "Test preparation";

  // Course page
  @override
  get course => "Course";
  @override
  get searchCourse => "Search courses...";
  @override
  get lesson => " Lesson";
  @override
  get errNotAnyResult => "Not found any match result...";

  // Course Detail
  @override
  get aboutCourse => "About Course";
  @override
  get overview => "Overview";
  @override
  get why => "Why take this course?";
  @override
  get what => "What will you be able to do?";
  @override
  get topic => "Topic";
  @override
  get tutor => "Tutor";

  // Ebook tab
  @override
  get ebook => "Ebook";
  @override
  get searchEbook => "Search ebook...";

  // Upcoming Page
  @override
  get upcoming => "Upcoming";
  @override
  get cancel => "Cancel";
  @override
  get goToMeeting => "Go to meeting";
  @override
  get dontHaveUpcoming => "You don't have any upcomming...";
  @override
  get removeUpcomingSuccess => "Remove upcoming success";
  @override
  get removeUpcomingFail =>
      "You just can remove upcoming 2 hours before schedule";

  // Tutor search page and Tutor detail page
  @override
  get tutors => "Tutors";
  @override
  get searchTutor => "Search Tutors...";
  @override
  get booking => "Booking";
  @override
  get languages => "Languages";
  @override
  get interests => "Interests";
  @override
  get specialties => "Specialties";
  @override
  get selectSpecialties => "Select specialties";
  @override
  get rateAndComment => "Rate and comment";
  @override
  get selectSchedule => "Select available schedule";
  @override
  get selectScheduleDetail => "Select available schedule time";
  @override
  get bookingSuccess => "Booking success";

  // Setting page
  @override
  get setting => "Setting";
  @override
  get changePassword => "Change password";
  @override
  get sessionHistory => "Session history";
  @override
  get advancedSetting => "Advanced setting";
  @override
  get theme => "Theme";
  @override
  get light => "Light";
  @override
  get dark => "Dark";
  @override
  get logout => "Logout";

  // Change password page
  @override
  get newPassword => "New password";
  @override
  get confirmNewPassword => "Enter new password again";
  @override
  get passwordAtLeast => "Password must be at least 6 characters";
  @override
  get changePasswordSuccess => "Change password success";

  // Session history page
  @override
  get giveFeedback => "Give feedback";
  @override
  get watchRecord => "Watch record";
  @override
  get mark => "Mark: ";
  @override
  get tutorNotMark => "Tutor hasn't mark yet";
  @override
  get emptySession => "You don't have any session history";

  // Feedback page
  @override
  get feedback => "Feedback";
  @override
  get hintFeedback => "Enter your feedback here...";
  @override
  get errEnterFeedback => "Please enter your feedback";
  @override
  get errFeedbackLength => "Feedback must be at least 3 words";
  @override
  get successFeedback => "Feedback success";
}
