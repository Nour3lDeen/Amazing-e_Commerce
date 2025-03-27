import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/model/countries/countries_model.dart';
import 'package:ecommerce/view_model/cubits/home/bottom_nav_cubit.dart';
import 'package:file_picker/file_picker.dart';
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

  init() {
    emit(AuthInitial());
    getUserData();
    getCountries();
  }

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

  final Map<String, bool> passwordVisibility = {
    'password': true,
    'confirmPassword': true,
    'newPassword': true,
    'oldPassword': true,
  };
  final emailRegExp = RegExp(
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    caseSensitive: false,
  );

  bool validateEmail(String email) {
    return emailRegExp.hasMatch(email);
  }

  void changePasswordVisibility(String field) {
    passwordVisibility[field] = !passwordVisibility[field]!;
    emit(ChangePasswordVisibilityState());
  }

  bool rememberMe = false;

  void changeRememberMe() {
    rememberMe = !rememberMe;
    emit(ChangeRememberMeState());
  }

  void clearData() {
    loginEmailController.clear();
    loginPasswordController.clear();
    registerEmailController.clear();
    registerPasswordController.clear();
    registerNumberController.clear();
    registerFirstNameController.clear();
    registerSecondNameController.clear();
    forgetPasswordEmailController.clear();
    selectedGender = null;
    selectedImage = null;
    otpController.clear();
    createNewPasswordController.clear();
    confirmPasswordController.clear();
    addressOtherPhoneController.clear();
    addressDescriptionController.clear();
    addressPhoneController.clear();
    addressFullNameController.clear();
    addressNameController.clear();
    selectedCountry = null;
    selectedCity = null;
    myCities = [];
    emit(ClearDataState());
  }

  void viewToast(
      String message, BuildContext context, Color color, int? duration) {
    showToast(message,
        context: context,
        backgroundColor: color,
        position: StyledToastPosition.bottom,
        animation: StyledToastAnimation.scale,
        reverseAnimation: StyledToastAnimation.fade,
        animDuration: const Duration(seconds: 1),
        duration: Duration(seconds: duration ?? 2),
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
        getCountries();
        if (value.data['data'] != null &&
            value.data['data']['user_data'] != null) {
          user = User.fromJson(value.data['data']['user_data']);
          SharedHelper.saveData(SharedKeys.firstName, user!.firstName);
          SharedHelper.saveData(SharedKeys.secondName, user!.lastName);
          SharedHelper.saveData(SharedKeys.avatar, user!.avatar);
          SharedHelper.saveData(SharedKeys.email, user!.email);
          SharedHelper.saveData(SharedKeys.phone, user!.mobile);
          if (user!.gender != null)
            SharedHelper.saveData(
                SharedKeys.gender,
                user!.gender == 'male'
                    ? LocaleKeys.male.tr()
                    : LocaleKeys.female.tr());
          if (user!.dateOfBirth != null)
            SharedHelper.saveData(SharedKeys.birthDate, user!.dateOfBirth);
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
        debugPrint('Error2: $errorMessage');
      } else {
        // Handle unexpected response structure
        emit(LoginErrorState('هناك عطل في الخادم'));
        debugPrint('Error: Response does not contain required fields.');
      }
    }).catchError((error) {
      debugPrint('Error type: ${error.runtimeType}');
      debugPrint('Error: $error');
      if (error is DioException) {
        if (error.response != null && error.response!.statusCode! >= 500)
        // Handle specific error cases
        {
          final errorMessage = 'هناك عطل في الخادم';
          emit(LoginErrorState(errorMessage));
          debugPrint('Error1: $errorMessage');
        } else if (error.response != null &&
            error.response!.statusCode! >= 400 &&
            error.response!.statusCode! < 500) {
          // Handle specific error cases
          final errorMessage = 'فشل تسجيل الدخول';
          emit(LoginErrorState(errorMessage));
          debugPrint('Error2: $errorMessage');
        }
      }
      /* if (error is DioException) {
        final errorMessage = 'هناك عطل في الخادم';
        emit(LoginErrorState(errorMessage));
        debugPrint('DioException: $errorMessage');
      } else {
        emit(LoginErrorState('An unexpected error occurred.'));
        debugPrint('Unhandled error: $error');
      }*/
    });
  }

  void register(context) async {
    debugPrint('Attempting register...');
    emit(RegisterLoadingState());
    await DioHelper.post(
      path: EndPoints.register,
      queryParameters: {
        'email': registerEmailController.text,
        'password': registerPasswordController.text,
        'mobile': registerNumberController.text,
        'first_name': registerFirstNameController.text,
        'last_name': registerSecondNameController.text,
      },
    ).then((value) {
      debugPrint('Response: ${value.data}');

      // Check for statusCode or data structure in the response
      if (value.data != null && value.data['statusCode'] == 200) {
        // register successful
        debugPrint('register successful');
        showToast(value.data['message'],
            context: context,
            backgroundColor: Colors.green,
            position: StyledToastPosition.bottom,
            animation: StyledToastAnimation.scale,
            reverseAnimation: StyledToastAnimation.fade,
            animDuration: const Duration(seconds: 1),
            duration: const Duration(seconds: 4),
            curve: Curves.elasticOut,
            reverseCurve: Curves.linear,
            borderRadius: BorderRadius.circular(25.r),
            isHideKeyboard: true,
            textStyle: TextStyle(
              color: AppColors.white,
              fontSize: 12.sp,
              fontFamily: 'Lamar',
            ));
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

  int otpTimer = 60; // Countdown duration in seconds
  bool canResendOtp = false;
  Timer? _otpTimer;

  void startOtpTimer() {
    otpTimer = 60;
    canResendOtp = false;
    emit(OtpTimerStartedState());

    _otpTimer?.cancel();
    _otpTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (otpTimer > 0) {
        otpTimer--;
        emit(OtpTimerUpdatedState(otpTimer));
      } else {
        canResendOtp = true;
        _otpTimer?.cancel();
        emit(OtpTimerFinishedState());
      }
    });
  }

  void sendOtp(context) {
    emit(SendOtpLoadingState());

    DioHelper.post(
      path: EndPoints.checkOtp,
      queryParameters: {
        'email': registerEmailController.text,
        'otp': otpController.text,
      },
    ).then((value) {
      debugPrint('Response: ${value.data}');
      if (value.data != null && value.data['statusCode'] == 200) {
        showToast(value.data['message'],
            context: context,
            backgroundColor: Colors.green,
            position: StyledToastPosition.bottom,
            animation: StyledToastAnimation.scale,
            reverseAnimation: StyledToastAnimation.fade,
            animDuration: const Duration(seconds: 1),
            duration: const Duration(seconds: 4),
            curve: Curves.elasticOut,
            reverseCurve: Curves.linear,
            borderRadius: BorderRadius.circular(25.r),
            isHideKeyboard: true,
            textStyle: TextStyle(
              color: AppColors.white,
              fontSize: 12.sp,
              fontFamily: 'Lamar',
            ));
        emit(SendOtpSuccessState());
        startOtpTimer();
        emit(SendOtpSuccessState());
      } else if (value.data['statusCode'] != 200) {
        // Handle specific error cases
        final errorMessage = value.data['message'] ?? 'فشل تسجيل الدخول';
        viewToast(value.data['message'], context, Colors.red, 4);
        otpController.clear();
        debugPrint(otpController.text);
        emit(SendOtpErrorState(errorMessage));
        debugPrint('Error: $errorMessage');
      }
    }).catchError((error) {
      viewToast(error.toString(), context, AppColors.red, 2);
      debugPrint('Error type: ${error.runtimeType}');
      debugPrint('Error: $error');
      emit(SendOtpErrorState('An unexpected error occurred.'));
    });
  }

  void resendOtp(context) {
    emit(ResendOtpLoadingState());

    DioHelper.post(
      path: EndPoints.resendOtp,
      queryParameters: {
        'email': registerEmailController.text,
      },
    ).then((value) {
      debugPrint('Response: ${value.data}');
      viewToast('${value.data['message']}', context, Colors.green, 2);
      startOtpTimer();
      emit(ResendOtpSuccessState());
    }).catchError((error) {
      viewToast(error.toString(), context, AppColors.red, 4);
      debugPrint('Error type: ${error.runtimeType}');
      debugPrint('Error: $error');
      emit(ResendOtpErrorState('An unexpected error occurred.'));
    });
  }

  void logout(context) {
    emit(AuthLogoutLoadingState());
    DioHelper.post(
      path: EndPoints.logout,
      withToken: true,
    ).then((value) {
      debugPrint('Response: ${value.data}');
      Navigator.pop(context);
      SharedHelper.removeKey(SharedKeys.token);
      SharedHelper.removeKey(SharedKeys.isLogged);
      SharedHelper.removeKey(SharedKeys.firstName);
      SharedHelper.removeKey(SharedKeys.secondName);
      SharedHelper.removeKey(SharedKeys.avatar);
      SharedHelper.saveData(SharedKeys.isLogged, false);
      BottomNavCubit.get(context).changeIndex(0);
      viewToast('${value.data['message']}', context, AppColors.red, 4);
      debugPrint('isLogged: ${SharedHelper.getData(SharedKeys.isLogged)}');
      emit(AuthLogoutSuccessState());
    });
  }

  /// update profile

  File? selectedImage;
  TextEditingController updateFirstNameController = TextEditingController();
  TextEditingController updateSecondNameController = TextEditingController();
  TextEditingController updateEmailController = TextEditingController();
  TextEditingController updatePhoneController = TextEditingController();
  TextEditingController updateGenderController = TextEditingController();
  TextEditingController updateDateController = TextEditingController();
  TextEditingController updatePasswordController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController newPasswordConfirmationController =
      TextEditingController();
  GlobalKey<FormState> updateFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> changePasswordFormKey = GlobalKey<FormState>();

  void updateBirthDate(DateTime date) {
    final formattedDate =
        "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
    updateDateController.text = formattedDate;
    emit(AuthDateChanged(formattedDate));
  }

  String? selectedGender;

  final List<String> genders = [LocaleKeys.male.tr(), LocaleKeys.female.tr()];

  void changeGender(String? gender) {
    selectedGender = gender;
    emit(AuthGenderChanged());
  }

  Future<void> pickImage() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );
      if (result != null && result.files.isNotEmpty) {
        final file = result.files.first;
        if (file.path != null) {
          selectedImage = File(file.path!);
          emit(ImagePickedState(selectedImage!));
          debugPrint('Selected file path: ${file.path}');
        } else {
          debugPrint('File has no path');
        }
      } else {
        debugPrint('No file selected');
      }
    } catch (e) {
      debugPrint('Error picking file: $e');
    }
  }

  void getUserData() async {
    debugPrint('Getting user data...');

    emit(AuthGetDataLoadingState());

    try {
      var response =
          await DioHelper.get(path: EndPoints.profile, withToken: true);

      if (response.data != null && response.data['statusCode'] == 200) {
        debugPrint('User data: ${response.data['data']}');
        var userData = response.data['data'];

        if (userData != null) {
          user = User.fromJson(userData);

          SharedHelper.saveData(SharedKeys.firstName, user!.firstName);
          SharedHelper.saveData(SharedKeys.secondName, user!.lastName);
          SharedHelper.saveData(SharedKeys.avatar, user!.avatar);
          SharedHelper.saveData(SharedKeys.email, user!.email);
          SharedHelper.saveData(SharedKeys.phone, user!.mobile);

          if (user!.gender != null) {
            SharedHelper.saveData(
              SharedKeys.gender,
              user!.gender == 'male'
                  ? LocaleKeys.male.tr()
                  : LocaleKeys.female.tr(),
            );
          }

          if (user!.dateOfBirth != null) {
            SharedHelper.saveData(SharedKeys.birthDate, user!.dateOfBirth);
          }

          debugPrint('User data: $user');
          emit(AuthGetDataSuccessState(user!));
        } else {
          emit(AuthGetDataErrorState('User data is missing.'));
        }
      } else {
        emit(AuthGetDataErrorState(
            response.data?['message'] ?? 'Failed to get user data.'));
      }
    } catch (error) {
      if (error is DioException) {
        debugPrint('Dio Error in getting user data: ${error.response?.data}');
        emit(AuthGetDataErrorState(
            error.response?.data['message'] ?? 'Server error'));
      } else {
        debugPrint('Unexpected Error in getting user data: $error');
        emit(AuthGetDataErrorState('An unexpected error occurred.'));
      }
    }
  }

  void updateProfile(BuildContext context) async {
    emit(AuthUpdateLoadingState());
    String? gender;
    debugPrint(updatePhoneController.text);
    try {
      MultipartFile? avatarFile;
      if (selectedImage != null) {
        avatarFile = await MultipartFile.fromFile(
          selectedImage!.path,
          filename: selectedImage!.path.split('/').last,
        );
      }
      if (selectedGender != null) {
        gender = selectedGender == LocaleKeys.male.tr() ? 'male' : 'female';
      }
      // Create FormData
      FormData formData = FormData.fromMap({
        'first_name': updateFirstNameController.text,
        'last_name': updateSecondNameController.text,
        'email': updateEmailController.text,
        'mobile': updatePhoneController.text,
        'gender': gender ?? null,
        'date_of_birth': updateDateController.text.isNotEmpty
            ? updateDateController.text
            : null,
        'avatar': avatarFile, // Attach image file
        'password': updatePasswordController.text.isNotEmpty
            ? updatePasswordController.text
            : null,
      });

      Response response = await DioHelper.post(
        path: EndPoints.updateProfile,
        body: formData,
        withToken: true,
      );

      debugPrint('Response: ${response.data}');

      if (response.data != null && response.data['statusCode'] == 200) {
        getUserData();
        emit(AuthUpdateSuccessState());
      } else if (response.data != null && response.data['statusCode'] != 200) {
        viewToast('${response.data['message']}', context, Colors.red, 3);
        emit(AuthUpdateErrorState('حدث خطأ غير متوقع، يرجى المحاولة مرة أخرى'));
      }
    } on DioException catch (dioError) {
      debugPrint('DioError: ${dioError.response?.data ?? dioError.message}');

      String errorMessage = 'حدث خطأ أثناء تحديث الملف الشخصي';
      if (dioError.response != null) {
        errorMessage = dioError.response!.data['message'] ?? errorMessage;
      } else if (dioError.type == DioExceptionType.connectionTimeout) {
        errorMessage = 'خطأ في الاتصال: انتهت مهلة الاتصال بالخادم';
      } else if (dioError.type == DioExceptionType.receiveTimeout) {
        errorMessage = 'انتهت مهلة استلام البيانات من الخادم';
      } else if (dioError.type == DioExceptionType.badResponse) {
        errorMessage = 'بيانات غير صحيحة، تحقق من المدخلات';
      }

      viewToast(errorMessage, context, Colors.red, 3);
      emit(AuthUpdateErrorState(errorMessage));
    } catch (error) {
      debugPrint('Unexpected Error in updating profile: $error');
      viewToast(
          'حدث خطأ غير متوقع، يرجى المحاولة مرة أخرى', context, Colors.red, 3);
      emit(AuthUpdateErrorState(error.toString()));
    }
    updatePasswordController.clear();
  }

  void changePassword(BuildContext context) {
    if (newPasswordController.text != newPasswordConfirmationController.text) {
      viewToast('الرجاء التاكد من تطابق كلمة المرور', context, Colors.red, 2);
      return;
    }

    emit(ChangePasswordLoadingState());

    FormData formData = FormData.fromMap({
      'old_password': oldPasswordController.text,
      'new_password': newPasswordController.text,
      'new_password_confirmation': newPasswordConfirmationController.text,
    });

    debugPrint('إرسال البيانات: ${formData.fields}');

    DioHelper.post(
      path: EndPoints.changePassword,
      withToken: true,
      body: formData,
    ).then((value) {
      debugPrint('الاستجابة: ${value.data}');
      if (value.data != null && value.data['statusCode'] == 200) {
        emit(ChangePasswordSuccessState());
      } else if (value.data != null && value.data['statusCode'] != 200) {
        viewToast('${value.data['message']}', context, Colors.red, 4);
        emit(ChangePasswordErrorState('${value.data['message']}'));
      }
    }).catchError((error) {
      if (error is DioException && error.response != null) {
        final statusCode = error.response!.statusCode;
        final responseData = error.response!.data;

        debugPrint('استجابة الخطأ من API: $responseData');

        String errorMessage = 'حدث خطأ غير متوقع';

        if (statusCode == 400) {
          errorMessage = 'الرجاء التحقق من البيانات المدخلة';
        } else if (statusCode == 401) {
          errorMessage = 'انتهت صلاحية الجلسة، يرجى تسجيل الدخول مجددًا';
        } else if (statusCode == 403) {
          errorMessage = 'ليس لديك الصلاحيات اللازمة';
        } else if (statusCode == 404) {
          errorMessage = 'المستخدم غير موجود';
        } else if (statusCode == 422) {
          errorMessage = responseData['message'] ??
              'البيانات المدخلة غير صحيحة، الرجاء التحقق وإعادة المحاولة';
        } else if (statusCode == 500) {
          errorMessage = 'خطأ في الخادم، يرجى المحاولة لاحقًا';
        }

        viewToast(errorMessage, context, Colors.red, 2);
      } else {
        debugPrint('خطأ غير متوقع: $error');
        viewToast('حدث خطأ غير متوقع، يرجى المحاولة مرة أخرى', context,
            Colors.red, 2);
      }
      emit(ChangePasswordErrorState(error.toString()));
    });
  }

  /// addresses
  List<Countries> countries = [];
  List<Cities> allCities = []; // Store all cities separately
  List<Cities> cities = [];
  List<String> myCountries = [];
  List<String> myCities = [];

  void getCountries() async {
    emit(GetCountriesLoadingState());

    try {
      Response response = await DioHelper.get(path: EndPoints.countries);

      if (response.data != null && response.data['statusCode'] == 200) {
        List<dynamic> data = response.data['data'];

        countries = data.map((e) => Countries.fromJson(e)).toList();
        myCountries = countries.map((e) => e.countryName!).toList();

        debugPrint('Countries: ${countries.length} countries loaded.');
        debugPrint('All Cities: ${allCities.length} cities loaded.');

        emit(GetCountriesSuccessState());
      } else {
        emit(GetCountriesErrorState(
            response.data['message'] ?? 'حدث خطأ غير متوقع.'));
      }
    } catch (error) {
      debugPrint('Error fetching countries: $error');
      emit(GetCountriesErrorState('فشل تحميل الدول، يرجى المحاولة لاحقًا.'));
    }
  }

  TextEditingController addressFullNameController = TextEditingController();
  TextEditingController addressNameController = TextEditingController();
  TextEditingController addressDescriptionController = TextEditingController();
  TextEditingController addressPhoneController = TextEditingController();
  TextEditingController addressOtherPhoneController = TextEditingController();
  GlobalKey<FormState> addAddressFormKey = GlobalKey<FormState>();

  int? selectedCountryId;
  String? selectedCountry;
  int? selectedCityId;
  String? selectedCity;

  void getCountryCities(String? countryName) {
    if (countryName == null) return;

    debugPrint('Country Name: $countryName');

    Countries? selected = countries.firstWhere(
      (c) => c.countryName == countryName,
      orElse: () => Countries(),
    );

    debugPrint('Selected Country: ${selected.countryName}');
    debugPrint('Selected Country Id: ${selected.id}');

    if (selected.id != null && selected.cities != null) {
      selectedCountryId = selected.id;
      cities = selected.cities!;

      debugPrint('Filtered Cities: ${cities.length}');

      myCities = cities.map((e) => e.cityName ?? '').toList();
      debugPrint('Filtered Cities: ${myCities}');
    } else {
      cities = [];
      myCities = [];
    }

    selectedCity = null; // Reset city when changing country
    emit(GetCitiesSuccessState());
  }

  void changeCountry(String? country) {
    selectedCountry = country;
    selectedCountryId =
        countries.firstWhere((c) => c.countryName == country).id;
    getCountryCities(country);
    emit(CountryChanged());
  }

  void changeCity(String? city) {
    selectedCity = city;
    selectedCityId = cities.firstWhere((c) => c.cityName == city).id;
    emit(CityChanged());
  }

  void addAddress(BuildContext context) {
    if (!addAddressFormKey.currentState!.validate()) {
      //emit(AddAddressErrorState('يرجى ملء جميع الحقول المطلوبة.'));
      return;
    }

    emit(AddAddressLoadingState());

    try {
      FormData form = FormData.fromMap({
        'full_name': addressFullNameController.text.trim(),
        'name': addressNameController.text.trim(),
        'description': addressDescriptionController.text.trim(),
        'mobile': addressPhoneController.text.trim(),
        if (addressOtherPhoneController.text.trim().isNotEmpty)
          'other_mobile': addressOtherPhoneController.text.trim(),
        'country_id': selectedCountryId,
        'city_id': selectedCityId,
      });

      DioHelper.post(
        path: EndPoints.addresses,
        body: form,
        withToken: true,
      ).then((value) {
        if (value.data['statusCode'] == 200) {
          debugPrint('✅ العنوان أُضيف بنجاح');
          clearData();
          emit(AddAddressSuccessState('تمت إضافة العنوان بنجاح!'));
        } else {
          debugPrint('❌ خطأ عند إضافة العنوان: ${value.data['message']}');
          emit(AddAddressErrorState(
              value.data['message'] ?? 'حدث خطأ غير متوقع.'));
        }
      }).catchError((error) {
        String errorMessage = 'حدث خطأ أثناء الاتصال بالخادم.';
        if (error is DioException) {
          if (error.response != null) {
            errorMessage = error.response?.data['message'] ?? errorMessage;
          } else if (error.type == DioExceptionType.connectionTimeout) {
            errorMessage = 'انتهت مهلة الاتصال بالخادم.';
          } else if (error.type == DioExceptionType.receiveTimeout) {
            errorMessage = 'الخادم لا يستجيب، حاول لاحقًا.';
          }
        }
        debugPrint('❌ خطأ: $errorMessage');
        emit(AddAddressErrorState(errorMessage));
      });
    } catch (e) {
      debugPrint('❌ خطأ غير متوقع: $e');
      emit(AddAddressErrorState('حدث خطأ غير متوقع، يرجى المحاولة لاحقًا.'));
    }
  }

  void deleteAddress(int addressId) {
    emit(DeleteAddressLoadingState());
    DioHelper.delete(path: EndPoints.addresses + '/$addressId', withToken: true)
        .then((value) {
      if (value.data['statusCode'] == 200) {
        debugPrint('✅ العنوان حذف بنجاح');
        user?.addresses!.removeWhere((element) => element.id == addressId);
        emit(DeleteAddressSuccessState(value.data['message']));
      } else {
        debugPrint('❌ خطأ عند حذف العنوان: ${value.data['message']}');
        emit(DeleteAddressErrorState(
            value.data['message'] ?? 'حدث خطأ غير متوقع.'));
      }
    }).catchError((error) {
      String errorMessage = 'حدث خطأ أثناء الاتصال بالخادم.';
      if (error is DioException) {
        if (error.response != null) {
          errorMessage = error.response?.data['message'] ?? errorMessage;
        } else if (error.type == DioExceptionType.connectionTimeout) {
          errorMessage = 'انتهت مهلة الاتصال بالخادم.';
        } else if (error.type == DioExceptionType.receiveTimeout) {
          errorMessage = 'الخادم لا يستجيب، حاول لاحقًا.';
        }
      }
      debugPrint('❌ خطأ: $errorMessage');
      emit(DeleteAddressErrorState(errorMessage));
    });
  }

  void updateAddress(int addressId) async {
    emit(UpdateAddressLoadingState());

    try {
      final response = await DioHelper.put(
        path: '${EndPoints.addresses}/$addressId',
        body: {
          'full_name': addressFullNameController.text.trim(),
          'name': addressNameController.text.trim(),
          'description': addressDescriptionController.text.trim(),
          'mobile': addressPhoneController.text.trim(),
          'other_mobile': addressOtherPhoneController.text,
          'country_id': selectedCountryId,
          'city_id': selectedCityId,
        },
        withToken: true,
      );

      if (response.data['statusCode'] == 200) {
        debugPrint('✅ تم تحديث العنوان بنجاح');
        getUserData();
        clearData();
        emit(UpdateAddressSuccessState(response.data['message']));
      } else {
        String errorMessage = response.data['message'] ?? 'حدث خطأ غير متوقع.';
        debugPrint('❌ خطأ عند تحديث العنوان: $errorMessage');
        emit(UpdateAddressErrorState(errorMessage));
      }
    } catch (error) {
      String errorMessage = 'حدث خطأ أثناء الاتصال بالخادم.';

      if (error is DioException) {
        if (error.response != null) {
          errorMessage = error.response?.data['message'] ?? errorMessage;
        } else {
          switch (error.type) {
            case DioExceptionType.connectionTimeout:
              errorMessage = '⏳ انتهت مهلة الاتصال بالخادم.';
              break;
            case DioExceptionType.receiveTimeout:
              errorMessage = '⚠️ الخادم لا يستجيب، حاول لاحقًا.';
              break;
            case DioExceptionType.badResponse:
              errorMessage = '🚨 خطأ في البيانات المستلمة من الخادم.';
              break;
            case DioExceptionType.cancel:
              errorMessage = '🚫 تم إلغاء الطلب.';
              break;
            default:
              errorMessage = '❌ خطأ غير معروف، حاول لاحقًا.';
          }
        }
      }

      debugPrint('❌ خطأ: $errorMessage');
      emit(UpdateAddressErrorState(errorMessage));
    }
  }
}
