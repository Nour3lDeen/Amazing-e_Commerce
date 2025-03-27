import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ecommerce/model/sections_model/sections_model.dart';
import 'package:ecommerce/model/start_design/logos_model/logos_model.dart';
import 'package:ecommerce/model/start_design/product_model/product_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../model/start_design/example_model/example_model.dart';
import '../../../model/start_design/print_types/print_types.dart';
import '../../data/network/dio_helper.dart';
import '../../data/network/endpoints.dart';
import '../../utils/app_colors/app_colors.dart';

part 'start_design_state.dart';

class StartDesignCubit extends Cubit<StartDesignState> {
  StartDesignCubit() : super(StartDesignInitial()) {
    openMenuId = 1;
    openModelMenuId = 1;
    emit(OpenMenuState());
    getExamples();
  }

  static StartDesignCubit get(BuildContext context) => BlocProvider.of(context);

  TextEditingController numberController = TextEditingController();

  void clear() {
    numberController.clear();
    examplesChecked.clear();
    imagesChecked.clear();
    namesChecked.clear();
    logosChecked.clear();
    modelChecked.clear();
    materialChecked.clear();
    multiChecked.clear();
    printChecked.clear();
    sizeChecked.clear();
    colorController.clear();
    selectedImage = null;
    emit(StartDesignInitial());
  }

  bool check = false;
  int? openMenuId;

  void openMenu(int id) {
    if (openMenuId != id) {
      openMenuId = id;
      emit(OpenMenuState());
    }
  }

  void closeMenu() {
    openMenuId = null;
    emit(CloseMenuState());
  }

  bool isMenuOpen(int id) {
    return openMenuId == id;
  }

  int? openModelMenuId;

  void openModelMenu(int id) {
    if (openModelMenuId != id) {
      openModelMenuId = id;
      emit(OpenMenuState());
    }
  }

  void closeModelMenu() {
    openModelMenuId = null;
    emit(CloseMenuState());
  }

  bool isModelMenuOpen(int id) {
    return openModelMenuId == id;
  }

  final Set<int> namesChecked = {};
  final Set<int> examplesChecked = {};
  final Set<int> logosChecked = {};
  final Set<int> imagesChecked = {};

  void changeCheck(int checkId, String type) {
    // Clear all sets first
    namesChecked.clear();
    examplesChecked.clear();
    logosChecked.clear();
    imagesChecked.clear();
    // Add the new checkId to the specified list
    switch (type) {
      case 'names':
        namesChecked.add(checkId);
        selectedImage = null;
        break;
      case 'examples':
        examplesChecked.add(checkId);
        selectedImage = null;
        break;
      case 'logos':
        logosChecked.add(checkId);
        selectedImage = null;
        break;
      case 'images':
        imagesChecked.add(checkId);
        break;
      default:
        throw ArgumentError('Invalid type: $type');
    }

    // Clear the controller or handle common operations
    numberController.clear();

    // Emit state with the updated checkId and its checked status
    emit(ChangeCheckState(checkId, true));
  }

  bool isChecked(int checkId, String type) {
    // Check the relevant set based on the type
    switch (type) {
      case 'names':
        return namesChecked.contains(checkId);
      case 'examples':
        return examplesChecked.contains(checkId);
      case 'logos':
        return logosChecked.contains(checkId);
      case 'images':
        return imagesChecked.contains(checkId);
      default:
        throw ArgumentError('Invalid type: $type');
    }
  }

  String? getCheckedMedia() {
    if (examplesChecked.isNotEmpty) {
      for (var checkedId in examplesChecked) {
        final matchingExample = examples.firstWhere(
          (example) => example.id == checkedId,
          orElse: () =>
              Examples(id: -1, media: ''), // Default value if not found
        );

        if (matchingExample.id != -1) {
          return matchingExample.media;
        }
      }
    } else if (imagesChecked.isNotEmpty) {
      for (var checkedId in imagesChecked) {
        final matchingImage = images.firstWhere(
          (example) => example.id == checkedId,
          orElse: () => Logos(id: -1, image: ''),
        );
        if (matchingImage.id != -1) {
          return matchingImage.image;
        }
      }
    } else if (namesChecked.isNotEmpty) {
      for (var checkedId in namesChecked) {
        final matchingName = names.firstWhere(
          (example) => example.id == checkedId,
          orElse: () => Examples(id: -1, media: ''),
        );
        if (matchingName.id != -1) {
          return matchingName.media;
        }
      }
    } else if (logosChecked.isNotEmpty) {
      for (var checkedId in logosChecked) {
        final matchingLogo = logos.firstWhere(
          (example) => example.id == checkedId,
          orElse: () => Logos(id: -1, image: ''),
        );
        if (matchingLogo.id != -1) {
          return matchingLogo.image;
        }
      }
    }

    return null;
  }

  String? getCheckedPrint() {
    for (var checkedId in printChecked) {
      final matchingPrint = printTypes.firstWhere(
        (example) => example.id == checkedId,
        orElse: () => PrintType(id: -1, nameAr: ''),
      );
      if (matchingPrint.id != -1) {
        return matchingPrint.nameAr;
      }
    }
    return null;
  }

  List<String> getCheckedSizeDirections() {
    List<String> checkedNames = [];

    debugPrint('multiChecked: $multiChecked');
    for (var checkedId in multiChecked) {
      final matchingSize = sizesAndDirections.firstWhere(
        (size) => size.id == checkedId,
        orElse: () => PrintType(id: -1, nameAr: ''),
      );

      if (matchingSize.id != -1) {
        checkedNames.add(matchingSize.nameAr!);
      }
    }

    debugPrint('checkedNames: $checkedNames');
    return checkedNames;
  }

  final Set<int> modelChecked = {};

  void changeModelCheck(int checkId) {
    for (int checkedId in modelChecked) {
      productCounts[checkedId] = 0;
    }

    modelChecked
      ..clear()
      ..add(checkId);
    sizeChecked.clear();
    designColor.clear();
    getProductSizesAndColors(checkId);
    productCounts[checkId] = 1;

    emit(ChangeCheckState(checkId, true));
    emit(ChangeNumberState(1));
  }

  bool isModelChecked(int checkId) {
    return modelChecked.contains(checkId);
  }

  final Map<int, int> productCounts = {};

  void incrementNumber(int productId) {
    final currentCount = productCounts[productId] ?? 0;

    productCounts.update(
      productId,
      (currentCount) => currentCount + 1,
      ifAbsent: () => 1,
    );

    if (currentCount == 0) {
      changeModelCheck(productId);
    }
    if (currentStep != 6) {
      changeStep(6);
    }
    emit(ChangeNumberState(productCounts[productId]!));
  }

  void decrementNumber(int productId) {
    if (productCounts.containsKey(productId) && productCounts[productId]! > 0) {
      final currentCount = productCounts[productId]!;
      productCounts.update(
        productId,
        (currentCount) => currentCount - 1,
      );

      // If count decreases to 0, uncheck the product
      if (currentCount == 1) {
        modelChecked.remove(productId);
        emit(ChangeCheckState(productId, false));
      }
      if (currentStep != 6) {
        changeStep(6);
      }
      emit(ChangeNumberState(productCounts[productId]!));
    }
  }

  int getProductCount(int productId) {
    return productCounts[productId] ?? 0;
  }

  final Set<int> printChecked = {};

  void changePrintCheck(int checkId) {
    printChecked
      ..clear()
      ..add(checkId);
    emit(ChangeCheckState(checkId, true));
  }

  bool isPrintChecked(int checkId) {
    return printChecked.contains(checkId);
  }

  final Set<int> materialChecked = {};

  void changeMaterialCheck(int checkId) {
    materialChecked
      ..clear()
      ..add(checkId);
    emit(ChangeCheckState(checkId, true));
  }

  bool isMaterialChecked(int checkId) {
    return materialChecked.contains(checkId);
  }

  int currentStep = 1;

  void changeStep(int step) {
    currentStep = step;
    emit(ChangeStepState());
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

  final ScrollController scrollController = ScrollController();

  void scrollToPosition(double position) {
    scrollController.animateTo(
      position,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    emit(ScrollPositionChangedState(position));
  }

  void scrollToTop() {
    scrollToPosition(0.0);
  }

  void scrollToBottom() {
    scrollToPosition(scrollController.position.maxScrollExtent);
  }

  final Set<int> multiChecked = {};

  void toggleMultiCheck(int checkId) {
    if (multiChecked.contains(checkId)) {
      multiChecked.remove(checkId); // Uncheck the checkbox
    } else {
      multiChecked.add(checkId); // Check the checkbox
    }
    emit(ChangeMultiCheckState(multiChecked));
  }

  bool isMultiChecked(int checkId) {
    return multiChecked.contains(checkId);
  }

  Color selectedColor = HexColor('#FFFFFF');
  TextEditingController colorController = TextEditingController();

  void changeColor(Color color) {
    selectedColor = color;
    emit(ColorChangedState(color));
  }

  List<Examples> examples = [];

  List<Logos> logos = [];

  List<Examples> names = [];

  List<Logos> images = [];

  void fetchData<T>({
    required String path,
    required Function(Map<String, dynamic>) fromJson,
    required Function(List<T>) onSuccess,
    required String debugLabel,
  }) {
    emit(GetExamplesLoadingState()); // Emit loading state

    DioHelper.get(path: path).then((value) {
      if (value.data != null && value.data['statusCode'] == 200) {
        final data = (value.data['data'] as List)
            .map((item) => fromJson(item as Map<String, dynamic>))
            .toList();
        onSuccess(data.cast<T>());
        debugPrint('$debugLabel: $data');
        emit(GetExamplesSuccessState()); // Emit success state
      } else {
        emit(
            GetExamplesErrorState()); // Handle case where statusCode is not 200
      }
    }).catchError((error) {
      debugPrint('Error fetching $debugLabel: $error');
      emit(GetExamplesErrorState()); // Emit error state
    });
  }

  void getExamples() {
    fetchData<Examples>(
      path: EndPoints.examples,
      fromJson: (item) => Examples.fromJson(item),
      onSuccess: (data) {
        examples = data;
        emit(
            GetExamplesSuccessState()); // Emit state with new data to trigger UI rebuild
      },
      debugLabel: 'examples',
    );
  }

  void getNames() {
    fetchData<Examples>(
      path: EndPoints.names,
      fromJson: (item) => Examples.fromJson(item),
      onSuccess: (data) {
        names = data;
      },
      debugLabel: 'names',
    );
  }

  void getLogos() {
    fetchData<Logos>(
      path: EndPoints.logos,
      fromJson: (item) => Logos.fromJson(item),
      onSuccess: (data) {
        logos = data;
      },
      debugLabel: 'logos',
    );
  }

  void getImages() {
    fetchData<Logos>(
      path: EndPoints.images,
      fromJson: (item) => Logos.fromJson(item),
      onSuccess: (data) {
        images = data;
      },
      debugLabel: 'images',
    );
  }

  File? selectedImage;

  Future<void> pickImage() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );

      // Check if the user selected a file
      if (result != null && result.files.isNotEmpty) {
        final file = result.files.first;

        // Ensure the path is not null before using it
        if (file.path != null) {
          selectedImage = File(file.path!); // Store the selected image
          changeCheck(100, 'images');
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

  List<PrintType> printTypes = [];

  void getPrintTypes() {
    emit(GetPrintTypesLoadingState());
    DioHelper.get(path: EndPoints.printTypes).then((value) {
      if (value.data != null && value.data['statusCode'] == 200) {
        final data = (value.data['data'] as List)
            .map((item) => PrintType.fromJson(item as Map<String, dynamic>))
            .toList();
        printTypes = data;
        Future.delayed(const Duration(milliseconds: 15), () {
          scrollToBottom();
        });
        emit(GetPrintTypesSuccessState());
      } else {
        emit(GetPrintTypesErrorState());
      }
    }).catchError((error) {
      debugPrint('Error fetching print types: $error');
      emit(GetPrintTypesErrorState());
    });
  }

  List<PrintType> sizesAndDirections = [];

  void getSizesAndDirections() {
    emit(GetSizesAndDirectionsLoadingState());
    DioHelper.get(path: EndPoints.sizeDirections).then((value) {
      if (value.data != null && value.data['statusCode'] == 200) {
        final data = (value.data['data'] as List)
            .map((item) => PrintType.fromJson(item as Map<String, dynamic>))
            .toList();
        sizesAndDirections = data;
        Future.delayed(const Duration(milliseconds: 15), () {
          scrollToBottom();
        });
        emit(GetSizesAndDirectionsSuccessState());
      } else {
        emit(GetSizesAndDirectionsErrorState());
      }
    }).catchError((error) {
      debugPrint('Error fetching print types: $error');
      emit(GetSizesAndDirectionsErrorState());
    });
  }

  List<PrintType> materials = [];

  void getMaterials() {
    emit(GetMaterialLoadingState());
    DioHelper.get(path: EndPoints.materials).then((value) {
      if (value.data != null && value.data['statusCode'] == 200) {
        final data = (value.data['data'] as List)
            .map((item) => PrintType.fromJson(item as Map<String, dynamic>))
            .toList();
        materials = data;
        Future.delayed(const Duration(milliseconds: 15), () {
          scrollToBottom();
        });
        emit(GetMaterialSuccessState());
      } else {
        emit(GetMaterialErrorState());
      }
    }).catchError((error) {
      debugPrint('Error fetching print types: $error');
      emit(GetMaterialErrorState());
    });
  }

  String? getMaterialName() {
    if (materialChecked.isEmpty) {
      return null; // Return null if no material is selected
    }

    return materials
        .firstWhere(
          (element) => element.id == materialChecked.first,
          orElse: () => PrintType(id: -1, nameAr: ''), // Fallback to a default
        )
        .nameAr; // Safely return the name
  }

  List<PrintType> models = [];

  void getModels() {
    emit(GetModelLoadingState());
    DioHelper.get(path: EndPoints.models).then((value) {
      if (value.data != null && value.data['statusCode'] == 200) {
        final data = (value.data['data'] as List)
            .map((item) => PrintType.fromJson(item as Map<String, dynamic>))
            .toList();
        models = data;
        openModelMenuId = models[0].id;
        openModelMenu(models[0].id!);
        getModelProducts(models[0].id!);
        Future.delayed(const Duration(milliseconds: 15), () {
          scrollToBottom();
        });
        emit(GetModelSuccessState());
      } else {
        emit(GetModelErrorState());
      }
    }).catchError((error) {
      debugPrint('Error fetching print types: $error');
      emit(GetModelErrorState());
    });
  }

  List<Products> products = [];

  void getModelProducts(int modelId) {
    emit(GetProductLoadingState());
    debugPrint('Loading products...');
    DioHelper.get(path: '${EndPoints.models}/$modelId').then((value) {
      if (value.data != null && value.data['statusCode'] == 200) {
        final data = (value.data['data'] as List)
            .map((item) => Products.fromJson(item as Map<String, dynamic>))
            .toList();
        products = data;

        Future.delayed(const Duration(milliseconds: 15), () {
          scrollToBottom();
        });

        emit(GetProductSuccessState());
      } else {
        emit(GetProductErrorState());
      }
    }).catchError((error) {
      debugPrint('Error fetching products: $error');
      emit(GetProductErrorState());
    });
  }

  String? getSelectedProductImage() {
    if (modelChecked.isEmpty || designColor.isEmpty) {
      return null;
    }

    final int selectedModelId = modelChecked.first;

    final Products selectedProduct = products.firstWhere(
      (product) => product.id == selectedModelId,
      orElse: () => Products(id: -1, colors: []),
    );

    if (selectedProduct.id == -1 || selectedProduct.colors == null) {
      return null;
    }

    final ProductsColors? selectedColor = selectedProduct.colors!.firstWhere(
      (color) => color.id == designColor.first,
      orElse: () => ProductsColors(),
    );

    if (selectedColor?.id == null || selectedColor?.images == null) {
      return null;
    }

    return selectedColor?.images!.first.url;
  }

  final Set<int> designColor = {};

  void changeColorCheck(int colorId) {
    designColor
      ..clear()
      ..add(colorId);
    emit(ChangeCheckState(colorId, true));
  }

  bool isColorChecked(int checkId) {
    return designColor.contains(checkId);
  }

  List<Sizes> sizes = [];
  List<ProductsColors> colors = [];

  void getProductSizesAndColors(int productId) {
    emit(GetProductSizesLoadingState());

    try {
      var product = products.firstWhere(
        (p) => p.id == productId,
        orElse: () => Products(id: 0, sizes: [], colors: []),
      );

      if (product.sizes != null) {
        sizes = product.sizes!;
      } else {
        sizes = [];
      }
      debugPrint('Sizes: ${sizes.toString()}');

      if (product.colors != null) {
        colors = product.colors!;
      } else {
        colors = [];
      }
      debugPrint('Colors: ${colors.toString()}');

      emit(GetProductSizesSuccessState(sizes: sizes, colors: colors));
    } catch (error) {
      debugPrint('Error in getProductSizesAndColors: $error');
      emit(GetProductSizesErrorState(error: error.toString()));
    }
  }

  String? getCheckedModel() {
    final matchingModel = models.firstWhere(
      (model) => model.id == openModelMenuId,
      orElse: () => PrintType(id: -1, nameAr: ''),
    );
    return matchingModel.nameAr;
  }

  String? getCheckedColor() {
    for (var colorId in designColor) {
      final matchingColor = colors.firstWhere(
        (color) => color.id == colorId,
        orElse: () => ProductsColors(id: -1, colorCode: ''),
      );
      if (matchingColor.id != -1) {
        return matchingColor.colorCode;
      }
    }
    return '#000000';
  }

  final Set<int> sizeChecked = {};

  void changeSizeCheck(int checkId) {
    // Clear the set and add the new checkId
    sizeChecked
      ..clear()
      ..add(checkId);
    emit(ChangeCheckState(checkId, true));
  }

  bool isSizeChecked(int checkId) {
    return sizeChecked.contains(checkId);
  }

  double total = 0.0;

  String? getCheckedSize() {
    for (var sizeId in sizeChecked) {
      final matchingSize = sizes.firstWhere(
        (size) => size.id == sizeId,
        orElse: () => Sizes(id: -1, sizeCode: ''),
      );
      if (matchingSize.id != -1) {
        if (matchingSize.discountPrice != null) {
          final discountPrice =
              double.tryParse(matchingSize.discountPrice.toString()) ?? 15.0;
          total += discountPrice;
        } else {
          final price =
              double.tryParse(matchingSize.basicPrice.toString()) ?? 0.0;
          total += price;
        }
        return matchingSize.sizeCode;
      }
    }
    return '';
  }

  double getTotalPrice() {
    double total = 0.0;

    // Calculate total for examplesChecked
    for (var checkedId in examplesChecked) {
      final matchingExample = examples.firstWhere(
        (example) => example.id == checkedId,
        orElse: () => Examples(id: -1, media: '', price: 0),
      );
      if (matchingExample.id != -1) {
        final count = productCounts[matchingExample.id] ?? 1;
        total +=
            (double.tryParse(matchingExample.price.toString()) ?? 0.0) * count;
      }
    }

    // Calculate total for imagesChecked
    for (var checkedId in imagesChecked) {
      final matchingImage = images.firstWhere(
        (image) => image.id == checkedId,
        orElse: () => Logos(id: -1, image: '', price: 0),
      );
      if (matchingImage.id != -1) {
        final count = productCounts[matchingImage.id] ?? 1;
        total +=
            (double.tryParse(matchingImage.price.toString()) ?? 0.0) * count;
      }
    }

    // Calculate total for namesChecked
    for (var checkedId in namesChecked) {
      final matchingName = names.firstWhere(
        (name) => name.id == checkedId,
        orElse: () => Examples(id: -1, media: '', price: 0),
      );
      if (matchingName.id != -1) {
        final count = productCounts[matchingName.id] ?? 1;
        total +=
            (double.tryParse(matchingName.price.toString()) ?? 0.0) * count;
      }
    }

    // Calculate total for logosChecked
    for (var checkedId in logosChecked) {
      final matchingLogo = logos.firstWhere(
        (logo) => logo.id == checkedId,
        orElse: () => Logos(id: -1, image: '', price: 0),
      );
      if (matchingLogo.id != -1) {
        final count = productCounts[matchingLogo.id] ?? 1;
        total +=
            (double.tryParse(matchingLogo.price.toString()) ?? 0.0) * count;
      }
    }

    // Calculate total for printChecked
    for (var checkedId in printChecked) {
      final matchingPrint = printTypes.firstWhere(
        (printType) => printType.id == checkedId,
        orElse: () => PrintType(id: -1, nameAr: '', price: 0),
      );
      if (matchingPrint.id != -1) {
        final count = productCounts[matchingPrint.id] ?? 1;
        total +=
            (double.tryParse(matchingPrint.price.toString()) ?? 0.0) * count;
      }
    }

    // Calculate total for sizeChecked
    for (var sizeId in sizeChecked) {
      final matchingSize = sizes.firstWhere(
        (size) => size.id == sizeId,
        orElse: () =>
            Sizes(id: -1, sizeCode: '', basicPrice: 0, discountPrice: 0),
      );
      if (matchingSize.id != -1) {
        final count = productCounts[matchingSize.id] ?? 1;
        final discountPrice =
            double.tryParse(matchingSize.discountPrice.toString()) ?? 0.0;
        final basicPrice =
            double.tryParse(matchingSize.basicPrice.toString()) ?? 0.0;
        total += (discountPrice > 0 ? discountPrice : basicPrice) * count;
      }
    }

    // Calculate total for materialChecked
    for (var materialId in materialChecked) {
      final matchingMaterial = materials.firstWhere(
        (material) => material.id == materialId,
        orElse: () => PrintType(id: -1, nameAr: '', price: 0),
      );
      if (matchingMaterial.id != -1) {
        final count = productCounts[matchingMaterial.id] ?? 1;
        total +=
            (double.tryParse(matchingMaterial.price.toString()) ?? 0.0) * count;
      }
    }

    // Calculate total for multiChecked
    for (var checkedId in multiChecked) {
      final matchingSizeDirection = sizesAndDirections.firstWhere(
        (size) => size.id == checkedId,
        orElse: () => PrintType(id: -1, nameAr: '', price: 0),
      );
      if (matchingSizeDirection.id != -1) {
        final count = productCounts[matchingSizeDirection.id] ?? 1;
        total +=
            (double.tryParse(matchingSizeDirection.price.toString()) ?? 0.0) *
                count;
      }
    }

    // Multiply final total with the product count
    int globalProductCount =
        productCounts.values.fold(0, (sum, count) => sum + count);
    return total * globalProductCount;
  }

  void addCartItem() {
    emit(AddCartItemLoadingState());

    // Ensure collections are not empty before accessing `.first`
    if (modelChecked.isEmpty) {
      emit(AddCartItemErrorState('No model selected'));
      return;
    }
    if (printChecked.isEmpty) {
      emit(AddCartItemErrorState('No print type selected'));
      return;
    }
    if (materialChecked.isEmpty) {
      emit(AddCartItemErrorState('No material selected'));
      return;
    }
    if (designColor.isEmpty) {
      emit(AddCartItemErrorState('No design color selected'));
      return;
    }
    if (sizeChecked.isEmpty) {
      emit(AddCartItemErrorState('No size selected'));
      return;
    }
    int argbValue = selectedColor.value;

    String hexCode = argbValue.toRadixString(16).padLeft(8, '0');

    hexCode = '$hexCode';

    debugPrint('Hex Code: $hexCode');

    String rgbHexCode = hexCode.substring(2);
    debugPrint('RGB Hex Code: $rgbHexCode');
    debugPrint('open model menu id: ${openModelMenuId}');
    // Create the base FormData map
    final formDataMap = {
      'product_id': modelChecked.first,
      'quantity': getProductCount(modelChecked.first),
      'example_id': examplesChecked.isEmpty ? null : examplesChecked.first,
      'name_id': namesChecked.isEmpty ? null : namesChecked.first,
      'logo_id': logosChecked.isEmpty ? null : logosChecked.first,
      'image_id': imagesChecked.isEmpty ? null : imagesChecked.first,
      'image': selectedImage == null ? null : selectedImage!.path,
      'number': numberController.text.isEmpty ? null : numberController.text,
      'printtype_id': printChecked.first,
      'model_id': openModelMenuId,
      'print_color': '#$rgbHexCode',
      'material_id': materialChecked.first,
      'color_id': designColor.first,
      'size_id': sizeChecked.first,
      'order_type': 'custom',
    };

    // Add sizedirection_ids dynamically based on the Set multiChecked
    int index = 0;
    for (var item in multiChecked) {
      formDataMap['sizedirection_ids[$index]'] = item;
      index++;
    }

    // Create FormData from the map
    final formData = FormData.fromMap(formDataMap);

    debugPrint('FormData: ${formData.fields}');

    DioHelper.post(
      path: EndPoints.carts,
      withToken: true,
      body: formData,
    ).then((value) {
      debugPrint('Response: ${value.data}');
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
}
