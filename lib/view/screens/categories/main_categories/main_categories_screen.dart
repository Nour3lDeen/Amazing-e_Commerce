import 'package:ecommerce/view/screens/categories/category_details/category_details_screen.dart';
import 'package:ecommerce/view/screens/categories/components/main_category_component/main_category_component.dart';
import 'package:ecommerce/view_model/cubits/products/products_cubit.dart';
import 'package:ecommerce/view_model/utils/Texts/Texts.dart';
import 'package:ecommerce/view_model/utils/app_colors/app_colors.dart';
import 'package:ecommerce/view_model/utils/navigation/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../view_model/data/local/shared_helper.dart';
import '../../../../view_model/data/local/shared_keys.dart';
import '../../../../view_model/utils/app_assets/app_assets.dart';

class MainCategoriesScreen extends StatelessWidget {
  const MainCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProductsCubit, ProductsState>(
        builder: (context, state) {
          final cubit = ProductsCubit.get(context);

          return Stack(
            children: [
              // Main Content
              Container(
                width: double.infinity,
                height: double.infinity,
                padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: SharedHelper.getData(SharedKeys.platform) == 'ios'
                        ? 0.h
                        : 16.h),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: Image.asset(AppAssets.back).image,
                    fit: BoxFit.cover,
                  ),
                ),
                child: ListView(
                  physics: const ClampingScrollPhysics(),
                  children: [
                    Center(
                      child: TextTitle(
                        'أقسام Amazing',
                        color: AppColors.primaryColor,
                        fontSize: 20.sp,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    if (state is! SectionsLoadingState)
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: cubit.sections.length,
                        separatorBuilder: (context, index) => SizedBox(
                          height: 16.h,
                        ),
                        itemBuilder: (context, index) {
                          return MainCategoryComponent(
                            image: cubit.sections[index].media!,
                            index: index,
                            title: cubit.sections[index].name!,
                            description: cubit.sections[index].description!,
                            onTap: () {
                              cubit.categories.clear();
                              cubit.products.clear();
                              Navigation.push(
                                context,
                                CategoryDetailsScreen(
                                  title: cubit.sections[index].name!,
                                ),
                              );
                              cubit.showSection(cubit.sections[index].id!);
                              debugPrint(
                                  'Selected Category ID: ${cubit.sections[index].id}');
                              if (cubit.categories.isNotEmpty) {
                                cubit.selectedIndex = cubit.categories[0].id!;
                                cubit.getCategoryProduct(
                                    cubit.categories[0].id!);
                              }
                            },
                          );
                        },
                      ),
                    SizedBox(height:SharedHelper.getData(SharedKeys.platform) == 'ios'
                        ? 48.h:60.h),
                  ],
                ),
              ),

              // Loading Indicator Overlay
              if (state is SectionsLoadingState)
                Center(
                    child: LoadingAnimationWidget.inkDrop(
                        color: AppColors.primaryColor, size: 30.sp))
            ],
          );
        },
      ),
    );
  }
}
