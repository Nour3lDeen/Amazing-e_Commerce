import 'dart:async';
import 'dart:math';

import 'package:chewie/chewie.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce/model/season_model/season_model.dart';
import 'package:ecommerce/model/sections_model/sections_model.dart';
import 'package:ecommerce/view_model/cubits/cart/cart_cubit.dart';
import 'package:ecommerce/view_model/data/network/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:video_player/video_player.dart';

import '../../data/network/dio_helper.dart';
import '../../utils/app_colors/app_colors.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsInitial());

  static ProductsCubit get(BuildContext context) => BlocProvider.of(context);

  Future<void> init() async {
    getSections();
    getAllCategories();
    getFavorites();
    getAllProducts();
    getSeasons();
  }

  int rate = 3;
  TextEditingController rateController = TextEditingController();

  void setRate(double rate) {
    this.rate = rate.toInt();
    debugPrint('Rate: ${this.rate}');
  }

  void sendRate({required int productId}) {
    emit(SendRateLoadingState());
    final formData = FormData.fromMap({
      'product_id': productId,
      'note': rateController.text != '' ? rateController.text : null,
      'rate': rate
    });
    DioHelper.post(
      path: EndPoints.rates,
      body: formData,
      withToken: true,
    ).then((value) {
      if (value.data != null && value.data['statusCode'] == 200) {
        debugPrint(value.data['message']);
        emit(SendRateSuccessState());
      } else {
        debugPrint(value.data['message']);
        emit(SendRateErrorState(value.data['message']));
      }
    }).catchError((error) {
      debugPrint(error.toString());
      emit(SendRateErrorState(error.toString()));
    });
  }

  String refundType = 'cash'; //wallet

  void changeRefundType(String type) {
    if (type == refundType) return;
    refundType = type;
    emit(ChangeRefundTypeState());
  }

  int selectedIndex = 0;

  void updateScrollOffset(double offset) {
    emit(ProductsScrollState(offset > 50));
  }

  int selectedSectionId = 0;
  int selectedSectionIndex = -1;

  void changeSelectedSection(int index) {
    selectedSectionIndex = index;
    if (index != -1) {
      selectedSectionId = sections[index].id!;
    }
    debugPrint('selectedSectionIndex: $selectedSectionIndex');
    debugPrint('selectedSectionId: $selectedSectionId');
    emit(ChangeSelectedSectionState());
  }

  int offerIndex = 0;

  void changeOffer(int index) {
    offerIndex = index;
    emit(ChangeOfferState());
  }

  VideoPlayerController? videoController;
  ChewieController? chewieController;
  bool isVideoPressed = false;

  Future<void> initializeVideo(String videoUrl) async {
    emit(ProductsLoading());

    try {
      videoController = VideoPlayerController.networkUrl(Uri.parse(videoUrl));
      await videoController!.initialize();

      chewieController = ChewieController(
        videoPlayerController: videoController!,
        aspectRatio: videoController!.value.aspectRatio,
      );

      emit(ProductsVideoLoaded(
        videoController: videoController!,
        chewieController: chewieController!,
        isVideoPressed: isVideoPressed,
      ));
    } catch (e) {
      emit(ProductsError('خطأ في تحميل الفيديو: $e'));
    }
  }

  void toggleVideoPressed() {
    isVideoPressed = !isVideoPressed;
    if (state is ProductsVideoLoaded) {
      emit(ProductsVideoLoaded(
        videoController: videoController!,
        chewieController: chewieController!,
        isVideoPressed: isVideoPressed,
      ));
    }
  }

  @override
  Future<void> close() {
    videoController?.dispose();
    chewieController?.dispose();
    return super.close();
  }

  bool isSelected(int index) {
    return selectedIndex == index;
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

  final Set<int> favoriteProducts = {};
  List<Products> favorites = [];

  Future<void> getFavorites() async {
    try {
      emit(GetFavoritesLoadingState());
      debugPrint('Fetching favorites...');

      Response response = await DioHelper.get(
          path: EndPoints.favorites,
          withToken: true
      );

      debugPrint('API Response in getting favorites: ${response.data}');

      if (response.data != null && response.data['statusCode'] == 200) {
        debugPrint('API Success in getting favorites: ${response.data}');

        // Filter out null products before mapping
        favorites = (response.data['data'] as List)
            .where((e) => e['products'] != null)
            .map((e) => Products.fromJson(e['products']))
            .toList();

        debugPrint('Favorites List: $favorites');

        emit(GetFavoritesSuccessState());
      } else {
        String errorMessage = response.data['message'] ?? 'Unknown error occurred';
        emit(GetFavoritesErrorState(errorMessage));
        debugPrint('API Error Message: $errorMessage');
      }
    } catch (error) {
      String errorMessage = 'Error: ${error.toString()}';
      emit(GetFavoritesErrorState(errorMessage));
      debugPrint('Dio Error in getting favorites: $error');
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

  String? selectedSize;
  String? sizeId;

  void changeSize(String newSize) {
    selectedSize = newSize;
    sizeId = sizes
        .firstWhere((element) => element.sizeCode == selectedSize)
        .id
        .toString();
    emit(ProductsSizeChangedState(newSize));
  }

  /*void changeSize(String value) {
    try {
      // Find the size in the sizes list
      final selectedSize = sizes.firstWhere(
            (size) => size.sizeCode == value,
        orElse: () => Sizes(sizeCode: value), // Default if no match
      );

      // Update the selected size
      selectedSizeCode = selectedSize.sizeCode;
      emit(ProductsSizeChangedState(value));
    } catch (e) {
      debugPrint('Error in changeSize: $e');
    }
  }*/

  List<Sizes> sizes = [];

  void initializeSelectedSize() {
    if (sizes.isNotEmpty) {
      selectedSize = '${sizes.first.sizeCode}';
      sizeId = sizes.first.id.toString();
      emit(ProductsSizeChangedState(selectedSize!));
    }
  }

  List<ProductsColors> colors = [];
  int selectedColorId = 0;

  void changeColorCheck(int colorId) {
    selectedColorId = colorId;

    emit(ProductsColorChangedState(colorId));
  }

  bool isColorChecked(int colorId) {
    return selectedColorId == colorId;
  }

  void changeFilterSelected(int index) {
    if (selectedIndex != index) {
      selectedIndex = index;
    }
    emit(ProductsIsSelectedState(selectedIndex));
  }

  final Map<int, int> productCounts = {};

  void incrementNumber(int productId) {
    productCounts.update(
      productId,
      (currentCount) => currentCount + 1,
      ifAbsent: () => 1,
    );

    emit(ChangeNumberState(productCounts[productId]!));
  }

  void decrementNumber(int productId) {
    if (productCounts.containsKey(productId) && productCounts[productId]! > 1) {
      productCounts.update(
        productId,
        (currentCount) => currentCount - 1,
      );

      emit(ChangeNumberState(productCounts[productId]!));
    }
  }

  int getProductCount(int productId) {
    // Ensure the first number for any product is 1 by default
    return productCounts.putIfAbsent(productId, () => 1);
  }

  /* Timer? _timer;

  void startIncrementing(int index) {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      incrementNumber(index);
    });
  }

  void startDecrementing(int index) {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      decrementNumber(index);
    });
  }

  void stopIncrementing() {
    _timer?.cancel();
  }

  void stopDecrementing() {
    _timer?.cancel();
  }*/

  void changeIsSelected(int index) {
    if (colors.isNotEmpty && selectedIndex != index) {
      selectedIndex = index;
      selectedColorId = colors[index].id!;

      // Ensure the color exists in the list
      var selectedColor = colors.firstWhere(
        (color) => color.id == selectedColorId,
        orElse: () => ProductsColors(id: 0, images: []),
      );

      // Safe access of images list
      if (selectedColor.images != null && selectedColor.images!.isNotEmpty) {
        popFromStack();
        pushToStack(selectedColor.images!.first.url!);
      } else {
        debugPrint('No images found for selected color');
      }

      debugPrint('Image URL: $imageUrl');
    }
    emit(ProductsIsSelectedState(selectedIndex));
  }

  String imageUrl = '';

  String searchQuery = '';

  void updateSearchQuery(String query) {
    searchQuery = query;
    emit(ProductsSearchQueryUpdatedState());
  }

  List<String> stack = [];

  // Push an item onto the stack
  void pushToStack(String item) {
    stack.add(item); // Add the item to the stack
    emit(StackUpdatedState(stack)); // Emit new state with updated stack
  }

  // Pop an item from the stack
  String? popFromStack() {
    if (stack.isNotEmpty) {
      String poppedItem =
          stack.removeLast(); // Remove the last item from the stack
      emit(StackUpdatedState(stack)); // Emit new state with updated stack
      return poppedItem;
    }
    return null; // Return null if the stack is empty
  }

  // Peek at the top item of the stack without removing it
  String? peekStack() {
    if (stack.isNotEmpty) {
      return stack.last; // Return the last item (top of the stack)
    }
    return null; // Return null if the stack is empty
  }

  ///Backend
  List<Section> sections = [];
  List<Categories> allCategories = [];

  Future<void> getSections() async {
    emit(SectionsLoadingState());

    try {
      Response response = await DioHelper.get(path: EndPoints.sections);

      if (response.data['statusCode'] == 200 && response.data['data'] != null) {
        debugPrint('Response Data in sections: ${response.data['data']}');
        sections = List<Section>.from(
          (response.data['data'] as List).map((x) => Section.fromJson(x)),
        );

        debugPrint('categories: ${sections.first.toString()}');

        emit(SectionsSuccessState());
      } else {
        debugPrint('API Error Message: ${response.data['message']}');
        emit(SectionsErrorState('Error: Status code ${response.statusCode}'));
      }
    } catch (error) {
      debugPrint('Dio Error in sections : $error');
      emit(SectionsErrorState('Error: $error'));
    }
  }

  Future<void> getAllCategories() async {
    emit(CategoriesLoadingState());

    try {
      Response response = await DioHelper.get(path: EndPoints.categories);

      if (response.data['statusCode'] == 200 && response.data['data'] != null) {
       // debugPrint('Response Data in all categories: ${response.data['data']}');
        allCategories = List<Categories>.from(
          (response.data['data'] as List).map((x) => Categories.fromJson(x)),
        );
        debugPrint('all categories: ${allCategories.toString()}');
        debugPrint(
            'male categories: ${allCategories.where((e) => e.sectionId == '5').toList().toString()}');

        emit(CategoriesSuccessState());
      } else {
        debugPrint('API Error Message: ${response.data['message']}');
        emit(CategoriesErrorState('Error: Status code ${response.statusCode}'));
      }
    } catch (error) {
      debugPrint('Dio Error in categories : $error');
      emit(
        CategoriesErrorState('Error: $error'),
      );
    }
  }

  Section selectedSection = Section();
  List<Categories> categories = [];
  List<Products> allProducts = [];
  List<Products> allSectionProducts = [];

  void populateAllProducts() {
    allSectionProducts.clear();
    for (var category in categories) {
      if (category.products != null) {
        allSectionProducts.addAll(category.products!);
      }
    }
    emit(ProductsUpdatedState());
  }

  void showSection(int sectionId) async {
    emit(SectionLoadingState());

    try {
      Response response = await DioHelper.get(
        path: '${EndPoints.sections}/$sectionId',
      );

      if (response.statusCode == 200) {
        if (response.data is Map) {
          var sectionData = response.data['data'];

          if (sectionData != null) {
            // Populate selectedSection with the data inside 'data'
            selectedSection = Section.fromJson(sectionData);
            debugPrint('Selected Section: ${selectedSection.toString()}');

            if (sectionData['categories'] != null) {
              categories = List<Categories>.from(
                (sectionData['categories'] as List)
                    .map((x) => Categories.fromJson(x)),
              );
              debugPrint('Categories: ${categories.toString()}');

              populateAllProducts();

              changeFilterSelected(categories[0].id!);
              //getCategoryProduct(categories[0].id!);
              emit(SectionSuccessState());
            } else {
              debugPrint('No categories found in section data.');
            }
          }
        } else {
          emit(SectionErrorState('Unexpected response format'));
        }
      } else {
        emit(SectionErrorState('Error: Status code ${response.statusCode}'));
      }
    } catch (error) {
      emit(SectionErrorState('Error: $error'));
    }
  }

  List<Products> products = [];

  void getCategoryProduct(int categoryId) async {
    emit(ProductsLoadingState());

    try {
      Response value =
          await DioHelper.get(path: '${EndPoints.categories}/$categoryId');

      if (value.data != null && value.data['statusCode'] == 200) {
        // Access 'data' to extract the product list
        var productData = value.data['data']['products'];

        if (productData != null && productData is List) {
          // Map the list to Product models
          products = productData
              .map((item) => Products.fromJson(item as Map<String, dynamic>))
              .toList();

          debugPrint('Products: $products');

          emit(ProductsSuccessState());
        } else {
          debugPrint('No product data found.');
          emit(ProductsErrorState('Error: No product data found.'));
        }
      } else {
        debugPrint('Error fetching products: ${value.data['message']}');
        emit(ProductsErrorState(
            value.data['message'] ?? 'Error: Unexpected response.'));
      }
    } catch (error) {
      debugPrint('Error fetching products: $error');
      emit(ProductsErrorState('Error fetching products: $error'));
    }
  }

  Products product = Products();

  void showProduct(int productId) async {
    emit(ProductLoadingState());

    try {
      // API call to fetch product details
      Response response = await DioHelper.get(
        path: '${EndPoints.products}/$productId',
      );
      if (response.statusCode == 200) {
        debugPrint('Response Data: ${response.data}');

        if (response.data is Map && response.data['data'] != null) {
          var productData = response.data['data'];

          product = Products.fromJson(productData);
          sizes = product.sizes!;
          colors = product.colors!;
          selectedColorId = product.colors![0].id!;
          imageUrl = product.colors![0].images![0].url!;
          initializeSelectedSize();

          debugPrint('Selected Product: ${product.toString()}');
          debugPrint('Selected Product rate: ${product.rate}');

          emit(ProductSuccessState());
        } else {
          // Handle unexpected response format or missing 'data'
          emit(ProductErrorState('Error: No product data found in response.'));
        }
      } else {
        // Handle non-200 status codes
        emit(ProductErrorState('Error: Status code ${response.statusCode}'));
      }
    } catch (error, stackTrace) {
      // Handle network or unexpected errors
      debugPrint('Error: $error');
      debugPrintStack(stackTrace: stackTrace);
      emit(ProductErrorState('Error: $error'));
    }
  }

  void addCartItem(context, int productId) {
    emit(AddCartItemLoadingState());

    final formData = FormData.fromMap({
      'product_id': productId.toString(),
      'quantity': getProductCount(productId),
      'color_id': selectedColorId.toString(),
      'size_id': sizeId,
      'order_type': 'normal',
    });

    debugPrint('FormData: ${formData.fields}');

    DioHelper.post(
      path: EndPoints.carts,
      withToken: true,
      body: formData,
    ).then((value) {
      debugPrint('Response: ${value.data}');
      viewToast('تم الاضافة للعربة', context, Colors.green);
      emit(AddCartItemSuccessState());
    }).catchError((error) {
      if (error is DioException) {
        debugPrint('Error Type: ${error.type}');
        debugPrint('Error Response: ${error.response?.data}');
        debugPrint('Error Status Code: ${error.response?.statusCode}');
      }
      emit(AddCartItemErrorState(error.toString()));
    });
  }

  bool isProductInCart(context, int productId) {
    // Check if the product exists in the cart
    return CartCubit.get(context)
        .cartItem!
        .cartItems!
        .any((item) => item.product!.id == productId);
  }

  void updateCartState() {
    emit(ChangeButtonState());
  }

  List<Products> everyProducts = [];

  Future<void> getAllProducts() async {
    debugPrint('Fetching all products...');
    emit(GetProductsLoadingState());

    try {
      Response response = await DioHelper.get(
        path: EndPoints.products,
        queryParameters: {'mobile': true},
      );

      if (response.data != null) {
        everyProducts = List<Products>.from(
          (response.data['data'] as List).map((x) => Products.fromJson(x)),
        );
        everyProducts.shuffle(Random());
        debugPrint('All Products: ${everyProducts.toString()}');
        debugPrint('All Products Length: ${everyProducts.length}');
        emit(GetProductsSuccessState());
      } else {
        emit(GetProductsErrorState('${response.data['message']}'));
        debugPrint('API Error Message: ${response.data['message']}');
      }
    } catch (error) {
      emit(GetProductsErrorState('Error: $error'));
    }
  }

  List<SeasonModel> seasons = [];
  int selectedIndexSeason = -1;
  int selectedSeasonId = 0;

  void changeSeason(int index) {
    selectedIndexSeason = index;
    if (index != -1) {
      selectedSeasonId = seasons[index].id!;
    }
    debugPrint('selectedIndexSeason: $selectedIndexSeason');
    debugPrint('selectedSeasonId: $selectedSeasonId');
    emit(ChangeSeasonState());
  }

  Future<void> getSeasons() async {
    emit(GetSeasonsLoadingState());
    try {
      Response response = await DioHelper.get(path: EndPoints.seasons);
      if (response.data != null) {
        seasons = List<SeasonModel>.from(
          (response.data['data'] as List).map((x) => SeasonModel.fromJson(x)),
        );
        debugPrint('Seasons: ${seasons.toString()}');
        emit(GetSeasonsSuccessState());
      } else {
        emit(GetSeasonsErrorState('${response.data['message']}'));
      }
    } catch (error) {
      emit(GetSeasonsErrorState('Error: $error'));
    }
  }
}
