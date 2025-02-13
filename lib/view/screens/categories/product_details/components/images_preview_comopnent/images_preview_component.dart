import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/model/sections_model/sections_model.dart';
import 'package:ecommerce/view_model/cubits/products/products_cubit.dart';
import 'package:ecommerce/view_model/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ImagesPreviewComponent extends StatelessWidget {
  const ImagesPreviewComponent({super.key, required this.product});
  final Products product;

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        final cubit = ProductsCubit.get(context);

        // Get the selected color and its images
        final selectedColor = product.colors!.firstWhere(
              (element) => element.id == cubit.selectedColorId,
          orElse: () => product.colors!.first,
        );
        final images = selectedColor.images!;

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(
                width: double.infinity,
                height: 50.h,
                decoration: BoxDecoration(
                  color: HexColor('#EFEFEF').withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(8.r),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black.withValues(alpha:0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,

                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      images.length,
                          (index) {
                        final imageUrl = images[index].url.toString();

                        // Check if the current image is the top of the stack
                        final isSelected = cubit.peekStack() == imageUrl;

                        return InkWell(
                          onTap: () {
                            // Push the selected image to the stack
                            cubit.popFromStack();
                            cubit.pushToStack(imageUrl);
                          },
                          child: Center(
                            child: Container(
                              width: 75.w,
                              height: 50.h,
                              padding: EdgeInsets.symmetric(
                                vertical: 4.h,
                                horizontal: 4.w,
                              ),
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(8.r),


                              ),
                              child:ClipRRect(
                                borderRadius: BorderRadius.circular(8.r),
                                child: Stack(
                                  children: [
                                    Positioned.fill(
                                      child: FutureBuilder(
                                        future: precacheImage(
                                          CachedNetworkImageProvider(imageUrl),
                                          context,
                                        ),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState == ConnectionState.waiting) {
                                            return Center(
                                              child: LoadingAnimationWidget.inkDrop(
                                                color: AppColors.primaryColor,
                                                size: 15.sp,
                                              ),
                                            );
                                          } else if (snapshot.hasError) {
                                            return const Center(
                                              child: Icon(Icons.error),
                                            );
                                          } else {
                                            return CachedNetworkImage(
                                              fit: BoxFit.cover,
                                              imageUrl: imageUrl,
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                    if (!isSelected)
                                      Positioned.fill(
                                        child: Container(
                                          color: Colors.black.withValues(alpha:0.4),
                                        ),
                                      ),
                                  ],
                                ),
                              ),

                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
