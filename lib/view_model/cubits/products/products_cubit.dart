import 'dart:async';

import 'package:chewie/chewie.dart';
import 'package:dio/dio.dart';
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

  int selectedIndex = 0;

  void updateScrollOffset(double offset) {
    emit(ProductsScrollState(offset > 50));
  }

  List<String> seasons=[
  'الصيف',
    'الشتاء',
    'الربيع',
    'الخريف',
  ];
  int selectedIndexSeason=0;
  void changeSeason(int index){
    selectedIndexSeason=index;
    emit(ChangeSeasonState());
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
        autoPlay: false,
        looping: false,
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

  final Set<int> favoriteProducts = {};

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

  void toggleFavorite(int productId, BuildContext context) {
    if (favoriteProducts.contains(productId)) {
      favoriteProducts.remove(productId);
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
      favoriteProducts.add(productId);
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
    emit(ChangeFavoriteState(productId, favoriteProducts.contains(productId)));
  }

  bool isProductFavorite(int productId) {
    return favoriteProducts.contains(productId);
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
      ifAbsent: () =>
          1, // Initialize to 1 if the product is not already in the map
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

  Timer? _timer;

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
  }

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

  void getSections() async {
    emit(SectionsLoadingState()); // Emit loading state

    try {
      Response response = await DioHelper.get(path: EndPoints.sections);

      if (response.statusCode == 200) {
        debugPrint('Response Data: ${response.data}');

        if (response.data is List) {
          sections = List<Section>.from(
            (response.data as List).map((x) => Section.fromJson(x)),
          );
        } else if (response.data is Map && response.data['data'] is List) {
          sections = List<Section>.from(
            (response.data['data'] as List).map((x) => Section.fromJson(x)),
          );
          emit(SectionsSuccessState());
        } else {
          emit(SectionsErrorState('Unexpected response format'));
        }
      } else {
        emit(SectionsErrorState('Error: Status code ${response.statusCode}'));
      }
    } catch (error) {
      emit(SectionsErrorState('Error: $error'));
    }
  }

  Section selectedSection = Section();
  List<Categories> categories = [];
  List<Products> allProducts = [];

  void populateAllProducts() {
    allProducts.clear();
    for (var category in categories) {
      if (category.products != null) {
        allProducts.addAll(category.products!);
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
          // Access 'data' from the response
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

              // Populate the allProducts list
              populateAllProducts();

              changeFilterSelected(categories[0].id!);
              getCategoryProduct(categories[0].id!);
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

      // Handle successful response
      if (response.statusCode == 200) {
        debugPrint('Response Data: ${response.data}');

        if (response.data is Map && response.data['data'] != null) {
          // Extract product data
          var productData = response.data['data'];

          product = Products.fromJson(productData);
          sizes = product.sizes!;
          colors = product.colors!;
          selectedColorId = product.colors![0].id!;
          imageUrl = product.colors![0].images![0].url!;
          initializeSelectedSize();

          debugPrint('Selected Product: ${product.toString()}');

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
    return CartCubit.get(context).cartItems.any((item) => item.product!.id == productId);
  }

  void updateCartState() {
    emit(ChangeButtonState());
  }

}
