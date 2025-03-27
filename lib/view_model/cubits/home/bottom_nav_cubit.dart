import 'package:dio/dio.dart';
import 'package:ecommerce/model/policy/policy_model.dart';
import 'package:ecommerce/model/sections_model/sections_model.dart';
import 'package:ecommerce/model/settings/settings_model.dart';
import 'package:ecommerce/model/social/social_model.dart';
import 'package:ecommerce/view_model/data/local/shared_helper.dart';
import 'package:ecommerce/view_model/data/local/shared_keys.dart';
import 'package:ecommerce/view_model/data/network/dio_helper.dart';
import 'package:ecommerce/view_model/data/network/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:shorebird_code_push/shorebird_code_push.dart';

import '../../../model/slider/slider_model.dart';
import '../../utils/app_colors/app_colors.dart';

part 'bottom_nav_state.dart';

class BottomNavCubit extends Cubit<BottomNavState> {
  BottomNavCubit() : super(BottomNavInitial());

  static BottomNavCubit get(BuildContext context) => BlocProvider.of(context);
  final updater = ShorebirdUpdater();

  Future<void> init() async {
    changeIndex(0);
   // checkForUpdates();
    if (SharedHelper.getData('slider 0') == null) {
      getSliders();
    }
    getSocialLinks();
    getPolicies();
    getSettings();
  }

 /* Future<void> checkForUpdates() async {
    final status = await updater.checkForUpdate();

    if (status == UpdateStatus.outdated) {
      try {
        await updater.update();
      } on UpdateException catch (error) {}
    }
  }*/

  int currentIndex = 0;

  void changeIndex(int newIndex) {
    currentIndex = newIndex;

    emit(BottomNavChanged(newIndex));
  }

  final Set<int> favoriteProducts = {};
  List<Products> favorites = [];

  Future<void> getFavorites() async {
    try {
      emit(GetFavoritesLoadingState());
      Response response = await DioHelper.get(path: EndPoints.favorites);
      if (response.data != null && response.data['statusCode'] == 200) {
        favorites = (response.data['data'] as List)
            .map((e) => Products.fromJson(e))
            .toList();
        debugPrint('favorites: ${favorites.toString()}');
        emit(GetFavoritesSuccessState());
      } else {
        emit(GetFavoritesErrorState('${response.data['message']}'));
        debugPrint('favorites: ${favorites.toString()}');
      }
    } catch (error) {
      emit(GetFavoritesErrorState('Error: $error'));
    }
  }

  void toggleFavorite(int productId, BuildContext context) async {
    try {
      emit(ToggleFavoriteLoadingState());

      // Check if the product is already in favorites
      bool isCurrentlyFavorite =
          favorites.any((product) => product.id == productId);

      Response response = await DioHelper.post(
        path: EndPoints.favorites,
        body: {'product_id': productId},
      );
      debugPrint('🔍 API Response: ${response.data}');

      if (response.data != null && response.data['statusCode'] == 200) {
        debugPrint('🔍 API Response: ${response.data}');
        if (isCurrentlyFavorite) {
          // Remove product from favorites
          favorites.removeWhere((product) => product.id == productId);
          showToast('تم إزالة من المفضلة',
              context: context,
              position: StyledToastPosition.bottom,
              animation: StyledToastAnimation.scale,
              backgroundColor: Colors.red,
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
        } else {
          // Add product to favorites
          favorites.add(
              Products(id: productId)); // Assuming `Products` has an `id` field
          showToast('تمت إضافة المنتج إلى المفضلة',
              context: context,
              animation: StyledToastAnimation.scale,
              reverseAnimation: StyledToastAnimation.fade,
              position: StyledToastPosition.bottom,
              backgroundColor: Colors.green,
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
        emit(ChangeFavoriteState(productId, isProductFavorite(productId)));
      } else {
        showToast('فشل العملية، حاول مجددًا',
            context: context, backgroundColor: Colors.red);
        emit(ToggleFavoriteErrorState(response.data['message']));
      }
    } catch (error) {
      showToast('حدث خطأ أثناء العملية',
          context: context, backgroundColor: Colors.red);
      emit(ToggleFavoriteErrorState('$error'));
    }
  }

  bool isProductFavorite(int productId) {
    return favorites.any((product) => product.id == productId);
  }

  List<Social> socialLinks = [];

  Future<void> getSocialLinks() async {
    emit(GetSocialLinksLoadingState());

    try {
      final response = await DioHelper.get(path: EndPoints.socials);

      if (response.data is Map && response.data.containsKey('data')) {
        socialLinks = (response.data['data'] as List)
            .map((e) => Social.fromJson(e))
            .toList();

        emit(GetSocialLinksSuccessState(socialLinks));
      } else {
        throw Exception('🚨 البيانات المستلمة غير صحيحة.');
      }
    } catch (error) {
      String errorMessage = '❌ حدث خطأ أثناء جلب روابط التواصل الاجتماعي.';

      if (error is DioException) {
        debugPrint(
            '🔍 DioException: ${error.response?.data}'); // Debug error details

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

      debugPrint(errorMessage);
      emit(GetSocialLinksErrorState(errorMessage));
    }
  }

  List<PolicyModel> policies = [];

  Future<void> getPolicies() async {
    emit(GetPoliciesLoadingState());

    try {
      final response = await DioHelper.get(path: EndPoints.policies);

      if (response.data is Map && response.data.containsKey('data')) {
        policies = (response.data['data'] as List)
            .map((e) => PolicyModel.fromJson(e))
            .toList();

        emit(GetPoliciesSuccessState());
      }
    } catch (error) {
      debugPrint('🚨 Error fetching policies: $error');
      emit(GetPoliciesErrorState(error.toString()));
    }
  }

  String refactorText(String htmlText) {
    var unescape = HtmlUnescape();
    var document = html_parser.parse(unescape.convert(htmlText));

    String formattedText = '';

    void parseElement(element) {
      if (element.localName == 'p') {
        formattedText +=
            '${element.text.trim()}\n\n'; // Add spacing for paragraphs
      } else if (element.localName == 'b' || element.localName == 'strong') {
        formattedText += '**${element.text.trim()}**'; // Markdown-style bold
      } else if (element.localName == 'i' || element.localName == 'em') {
        formattedText += '_${element.text.trim()}_'; // Markdown-style italics
      } else if (element.localName == 'ul') {
        for (var li in element.children) {
          if (li.localName == 'li') {
            formattedText += '- ${li.text.trim()}\n'; // Bullet points
          }
        }
        formattedText += '\n';
      } else if (element.localName == 'ol') {
        int counter = 1;
        for (var li in element.children) {
          if (li.localName == 'li') {
            formattedText += '$counter. ${li.text.trim()}\n'; // Numbered list
            counter++;
          }
        }
        formattedText += '\n';
      } else if (element.localName == 'br') {
        formattedText += '\n'; // Line break
      } else {
        formattedText += element.text;
      }
    }

    for (var element in document.body!.children) {
      parseElement(element);
    }

    return formattedText.trim();
  }

  SettingsModel settings = SettingsModel();

  Future<void> getSettings() async {
    debugPrint('getting settings');
    emit(GetSettingsLoadingState());

    try {
      final response = await DioHelper.get(path: EndPoints.settings);

      if (response.data != null && response.data['statusCode'] == 200) {
        settings = SettingsModel.fromJson(response.data['data']);
        SharedHelper.removeKey(SharedKeys.mainLogo);
        SharedHelper.removeKey(SharedKeys.secondaryLogo);
        SharedHelper.saveData(SharedKeys.mainLogo, settings.mainLogo);
        SharedHelper.saveData(SharedKeys.secondaryLogo, settings.secondaryLogo);
        debugPrint('mainLogo: ${settings.mainLogo}');
        debugPrint('secondaryLogo: ${settings.secondaryLogo}');
        emit(GetSettingsSuccessState());
      } else {
        emit(GetSettingsErrorState('Error: ${response.data['message']}'));
      }
    } catch (error) {
      emit(GetSettingsErrorState('Error: $error'));
    }
  }

  List<SliderModel> sliders = [];

  Future<void> getSliders() async {
    emit(GetSlidersLoadingState());
    try {
      final response = await DioHelper.get(path: EndPoints.sliders);

      if (response.data != null && response.data['statusCode'] == 200) {
        sliders = (response.data['data'] as List)
            .map((e) => SliderModel.fromJson(e))
            .toList();
        for (var slider in sliders) {
          SharedHelper.saveData('slider ${slider}', slider.media);
        }
        emit(GetSlidersSuccessState());
      } else {
        emit(GetSlidersErrorState('Error: ${response.data['message']}'));
      }
    } catch (error) {
      emit(GetSlidersErrorState('Error: $error'));
    }
  }
}
