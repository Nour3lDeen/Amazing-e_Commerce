import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/view_model/cubits/home/bottom_nav_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

import '../../../model/auth/user.dart';
import '../../../translation/locale_keys.g.dart';
import '../../data/local/shared_helper.dart';
import '../../data/local/shared_keys.dart';
import '../../data/network/dio_helper.dart';
import '../../data/network/endpoints.dart';
import '../../utils/app_colors/app_colors.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of<AuthCubit>(context);

  User? user;
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();

  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  GlobalKey<FormState> createNewPasswordFormKey = GlobalKey<FormState>();

  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();

  TextEditingController forgetPasswordEmailController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  TextEditingController createNewPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  TextEditingController registerPasswordController = TextEditingController();
  TextEditingController registerEmailController = TextEditingController();
  TextEditingController registerNumberController = TextEditingController();
  TextEditingController registerFirstNameController = TextEditingController();
  TextEditingController registerSecondNameController = TextEditingController();
  TextEditingController registerGenderController = TextEditingController();
  TextEditingController registerDateController = TextEditingController();

  bool rememberMe = false;
  bool showPassword = true;
  final emailRegExp = RegExp(
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    caseSensitive: false,
  );

  bool validateEmail(String email) {
    return emailRegExp.hasMatch(email);
  }

  void changePasswordVisibility() {
    showPassword = !showPassword;
    emit(ChangePasswordVisibilityState());
  }

  void changeRememberMe() {
    rememberMe = !rememberMe;
    emit(ChangeRememberMeState());
  }

  String? selectedGender;

  // List of gender options in Arabic
  final List<String> genders = [LocaleKeys.male.tr(), LocaleKeys.female.tr()];


  // Method to change selected gender
  void changeGender(String? gender) {
    selectedGender = gender;
    emit(AuthGenderChanged()); // Emit a state for UI updates
  }

  void updateBirthDate(DateTime date) {
    // Format the date as YYYY-MM-DD
    final formattedDate =
        "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day
        .toString().padLeft(2, '0')}";
    registerDateController.text = formattedDate;
    emit(AuthDateChanged(formattedDate)); // Emit a state for UI updates
  }

  void clearData() {
    loginEmailController.clear();
    loginPasswordController.clear();
    registerEmailController.clear();
    registerPasswordController.clear();
    registerNumberController.clear();
    registerFirstNameController.clear();
    registerSecondNameController.clear();
    registerGenderController.clear();
    registerDateController.clear();
    forgetPasswordEmailController.clear();
    otpController.clear();
    createNewPasswordController.clear();
    confirmPasswordController.clear();
    if (!showPassword) {
      changePasswordVisibility();
    }
    selectedGender = null;
  }

  void viewToast(String message, BuildContext context, Color color) {
    showToast(message,
        context: context,
        backgroundColor: color,
        position: StyledToastPosition.bottom,
        animation: StyledToastAnimation.scale,
        reverseAnimation: StyledToastAnimation.fade,
        animDuration: const Duration(seconds: 1),
        duration: const Duration(seconds: 2),
        curve: Curves.elasticOut,
        reverseCurve: Curves.linear,
        borderRadius: BorderRadius.circular(25.r),
        isHideKeyboard: true,
        textStyle: TextStyle(
          color: AppColors.white,
          fontSize: 12.sp,
          fontFamily: 'Lamar',
        ));
  }

  void login() async {
    debugPrint('Attempting login...');
    emit(LoginLoadingState());

    await DioHelper.post(
      path: EndPoints.login,
      queryParameters: {
        'email': loginEmailController.text,
        'password': loginPasswordController.text,
      },
    ).then((value) {
      debugPrint('Response: ${value.data}');


      if (value.data != null && value.data['statusCode'] == 200) {
        final token = value.data['data']['access_token'];

        if (value.data['data'] != null &&
            value.data['data']['user_data'] != null) {
          user = User.fromJson(value.data['data']['user_data']);
          SharedHelper.saveData(SharedKeys.firstName, user!.firstName);
          SharedHelper.saveData(SharedKeys.secondName, user!.lastName);
          SharedHelper.saveData(SharedKeys.avatar, user!.avatar);
          SharedHelper.saveData(SharedKeys.token, token);
          debugPrint('Token: $token');
          debugPrint('User: ${user.toString()}');
        } else {
          debugPrint('Error: User data is missing or null');
        }
        if (rememberMe) {
          SharedHelper.saveData(SharedKeys.isLogged, true);
          debugPrint('isLogged: ${SharedHelper.getData(SharedKeys.isLogged)}');
        } else {
          SharedHelper.saveData(SharedKeys.isLogged, false);
          debugPrint('isLogged: ${SharedHelper.getData(SharedKeys.isLogged)}');
        }
        clearData();
        emit(LoginSuccessState());
      } else if (value.data['statusCode'] != 200) {
        // Handle specific error cases
        final errorMessage = value.data['message'] ?? 'فشل تسجيل الدخول';
        emit(LoginErrorState(errorMessage));
        debugPrint('Error: $errorMessage');
      } else {
        // Handle unexpected response structure
        emit(LoginErrorState('Invalid response from server.'));
        debugPrint('Error: Response does not contain required fields.');
      }
    }).catchError((error) {
      debugPrint('Error type: ${error.runtimeType}');
      debugPrint('Error: $error');

      if (error is DioException) {
        final errorMessage =
            error.response?.data?['message'] ?? 'خطأ أثناء تسجيل الدخول';
        emit(LoginErrorState(errorMessage));
        debugPrint('DioException: $errorMessage');
      } else {
        emit(LoginErrorState('An unexpected error occurred.'));
        debugPrint('Unhandled error: $error');
      }
    });
  }

  void register() async {
    debugPrint('Attempting register...');
    emit(RegisterLoadingState());
    String gender;
    selectedGender == 'ذكر' ? gender = 'male' : gender = 'female';
    await DioHelper.post(
      path: EndPoints.register,
      queryParameters: {
        'email': registerEmailController.text,
        'password': registerPasswordController.text,
        'mobile': registerNumberController.text,
        'first_name': registerFirstNameController.text,
        'last_name': registerSecondNameController.text,
        'gender': gender,
        'date_of_birth': registerDateController.text,
      },
    ).then((value) {
      debugPrint('Response: ${value.data}');

      // Check for statusCode or data structure in the response
      if (value.data != null && value.data['statusCode'] == 200) {
        // register successful
        debugPrint('register successful');
        emit(RegisterSuccessState());
      } else if (value.data['statusCode'] != 200) {
        // Handle specific error cases
        final errorMessage = value.data['message'] ?? 'فشل إنشاء الحساب';
        emit(RegisterErrorState(errorMessage));
        debugPrint('Error: $errorMessage');
      } else {
        // Handle unexpected response structure
        emit(RegisterErrorState('Invalid response from server.'));
        debugPrint('Error: Response does not contain required fields.');
      }
    }).catchError((error) {
      debugPrint('Error type: ${error.runtimeType}');
      debugPrint('Error: $error');

      if (error is DioException) {
        final errorMessage =
            error.response?.data?['message'] ?? 'خطأ أثناء إنشاء الحساب';
        emit(RegisterErrorState(errorMessage));
        debugPrint('DioException: $errorMessage');
      } else {
        emit(RegisterErrorState('An unexpected error occurred.'));
        debugPrint('Unhandled error: $error');
      }
    });
  }

  void logout(context) {
    SharedHelper.removeKey(SharedKeys.token);
    SharedHelper.removeKey(SharedKeys.isLogged);
    SharedHelper.removeKey(SharedKeys.firstName);
    SharedHelper.removeKey(SharedKeys.secondName);
    SharedHelper.removeKey(SharedKeys.avatar);
    SharedHelper.saveData(SharedKeys.isLogged, false);
    BottomNavCubit.get(context).changeIndex(0);
    viewToast('تم تسجيل الخروج', context, AppColors.red);
    debugPrint('isLogged: ${SharedHelper.getData(SharedKeys.isLogged)}');
    emit(AuthLogoutSuccessState());
  }
}
